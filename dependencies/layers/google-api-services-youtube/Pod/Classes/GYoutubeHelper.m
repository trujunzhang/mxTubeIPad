//
//  Search.m
//  IOSTemplate
//
//  Created by djzhang on 9/25/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import "GYoutubeHelper.h"

#import "GTLYouTubeSearchResult.h"
#import "GTLYouTubeResourceId.h"
#import "GTMOAuth2ViewControllerTouch.h"
#import "GTLYouTubeSubscriptionListResponse.h"
#import "GTLYouTubeChannelListResponse.h"
#import "GTLYouTubeChannelSnippet.h"
#import "GYoutubeAuthUser.h"
#import "YoutubeAuthDataStore.h"

static GYoutubeHelper * instance = nil;


@implementation GYoutubeHelper

#pragma mark -
#pragma mark Global GTLServiceYouTube instance


- (GTLServiceYouTube *)youTubeService {
   static GTLServiceYouTube * service;

   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
       service = [[GTLServiceYouTube alloc] init];

       // Have the service object set tickets to fetch consecutive pages
       // of the feed so we do not need to manually fetch them.
       service.shouldFetchNextPages = YES;

       // Have the service object set tickets to retry temporary error conditions
       // automatically.
       service.retryEnabled = YES;
   });
   return service;
}


#pragma mark -
#pragma mark GYoutubeHelper Static instance


+ (GYoutubeHelper *)getInstance {
   @synchronized (self) {
      if (instance == nil) {
         instance = [[self alloc] init];
      }
   }
   return (instance);
}


- (instancetype)init {
   self = [super init];
   if (self) {
      [self initYoutubeService];
   }

   return self;
}


#pragma mark -
#pragma mark initialize Youtube Service


- (void)initYoutubeService {
   // 1
   self.youTubeService.APIKey = apiKey;

   // 2
   GTMOAuth2Authentication * auth;
   auth = [GTMOAuth2ViewControllerTouch authForGoogleFromKeychainForName:kKeychainItemName
                                                                clientID:kMyClientID
                                                            clientSecret:kMyClientSecret];
   // 3
   [self fetchAuthorizeInfo:auth];
}


#pragma mark -
#pragma mark Youtube search.


- (NSArray *)searchByQueryWithQueryTerm:(NSString *)queryTerm completionHandler:(YoutubeResponseBlock)responseHandler errorHandler:(ErrorResponseBlock)errorHandler {
   YoutubeResponseBlock completion = ^(NSArray * array) {
       // 02 Search Videos by videoIds
       [self searchVideoByVideoIds:array
                 completionHandler:(YoutubeResponseBlock) responseHandler
                      errorHandler:errorHandler];
   };
   ErrorResponseBlock error = ^(NSError * error) {
       if (error) {
          errorHandler(error);
       }
   };
   // 01: Search videoIds by queryTerm
   [self fetchSearchListWithQueryTerm:queryTerm completionHandler:completion errorHandler:error];

   return nil;
}


- (void)searchVideoByVideoIds:(NSArray *)searchResultList completionHandler:(YoutubeResponseBlock)responseHandler errorHandler:(ErrorResponseBlock)errorHandler {
   NSMutableArray * videoIds = [[NSMutableArray alloc] init];

   if (searchResultList) {
      // Merge video IDs
      for (GTLYouTubeSearchResult * searchResult in searchResultList) {
         [videoIds addObject:searchResult.identifier.videoId];
      }
      [self fetchVideoListWithVideoId:[videoIds componentsJoinedByString:@","]
                    completionHandler:responseHandler
                         errorHandler:errorHandler];
   }
}


- (void)fetchSearchListWithQueryTerm:(NSString *)queryTerm
                   completionHandler:(YoutubeResponseBlock)completion
                        errorHandler:(ErrorResponseBlock)errorBlock {
   GTLServiceYouTube * service = self.youTubeService;

   GTLQueryYouTube * query = [GTLQueryYouTube queryForSearchListWithPart:@"id,snippet"];
   query.q = queryTerm;
   query.type = @"video";

   // maxResults specifies the number of results per page.  Since we earlier
   // specified shouldFetchNextPages=YES, all results should be fetched,
   // though specifying a larger maxResults will reduce the number of fetches
   // needed to retrieve all pages.
   query.maxResults = search_maxResults; // NUMBER_OF_VIDEOS_RETURNED

   // We can specify the fields we want here to reduce the network
   // bandwidth and memory needed for the fetched collection.
   //
   // For example, leave query.fields as nil during development.
   // When ready to test and optimize your app, specify just the fields needed.
   // For example, this sample app might use
   //
   query.fields = @"items(id/videoId)";

   _searchListTicket = [service executeQuery:query
                           completionHandler:^(GTLServiceTicket * ticket,
                            GTLYouTubeSearchListResponse * resultList,
                            NSError * error) {
                               // The contentDetails of the response has the playlists available for "my channel".
                               if ([[resultList items] count] > 0) {
                                  completion([resultList items]);
                               }
                               errorBlock(error);
                               _searchListTicket = nil;
                           }];
}


- (void)fetchVideoListWithVideoId:(NSString *)videoId
                completionHandler:(YoutubeResponseBlock)completion
                     errorHandler:(ErrorResponseBlock)errorBlock {
   GTLServiceYouTube * service = self.youTubeService;

   GTLQueryYouTube * query = [GTLQueryYouTube queryForVideosListWithPart:@"snippet,contentDetails, statistics"];
   query.identifier = videoId;

   _searchListTicket = [service executeQuery:query
                           completionHandler:^(GTLServiceTicket * ticket,
                            GTLYouTubeSearchListResponse * resultList,
                            NSError * error) {
                               // The contentDetails of the response has the playlists available for "my channel".
                               if ([[resultList items] count] > 0) {
                                  completion([resultList items]);
                               }
                               errorBlock(error);
                               _searchListTicket = nil;
                           }];
}


#pragma mark -
#pragma mark GTMOAuth2ViewControllerTouch, by Youtube oauth2.


- (GTMOAuth2ViewControllerTouch *)getYoutubeOAuth2ViewControllerTouchWithTouchDelegate:(id)touchDelegate leftBarDelegate:(id)leftBarDelegate cancelAction:(SEL)cancelAction {
   //1
   GTMOAuth2ViewControllerTouch * viewController =
    [[GTMOAuth2ViewControllerTouch alloc] initWithScope:scope
                                               clientID:kMyClientID
                                           clientSecret:kMyClientSecret
                                       keychainItemName:kKeychainItemName
                                               delegate:touchDelegate
                                       finishedSelector:@selector(viewController:finishedWithAuth:error:)];

   //2
   viewController.navigationItem.leftBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"Cancel", nil)]
                                     style:UIBarButtonItemStyleBordered
                                    target:leftBarDelegate
                                    action:cancelAction];


   return viewController;
}


- (GTMOAuth2Authentication *)getAuthorizer {
   return self.youTubeService.authorizer;
}


- (void)fetchAuthorizeInfo:(GTMOAuth2Authentication *)authentication {
   self.youTubeService.authorizer = authentication;
   self.isSignedIn = authentication.canAuthorize;

   if (self.isSignedIn) {
      [self getAuthUserInfo];
   }
}


- (void)saveAuthorizeAndFetchUserInfo:(GTMOAuth2Authentication *)authentication {
   // 1
   [self fetchAuthorizeInfo:authentication];
}


- (void)getAuthUserInfo {
   self.youtubeAuthUser = [[GYoutubeAuthUser alloc] init];

   [self getUserInfo];
}


- (void)getUserInfo {
   YoutubeResponseBlock completion = ^(NSArray * array) {
       // 1
       GTLYouTubeChannel * channel = array[0];
       // save user title
       NSString * title = channel.snippet.title;
       NSString * email = self.youTubeService.authorizer.userEmail;
       NSString * thumbnailUrl = [GYoutubeAuthUser getUserThumbnails:channel];
       [[YoutubeAuthDataStore getInstance] saveAuthUserChannelWithTitle:title
                                                              withEmail:email
                                                       withThumbmailUrl:thumbnailUrl];


       self.youtubeAuthUser.channel = channel;
       // 2
       [self getUserSubscriptions];

       // "id" -> "UC0wObT_HayGfWLdRAnFyPwA"
       NSLog(@" user name = %@", self.youtubeAuthUser.channel.snippet.title);
   };

   ErrorResponseBlock error = ^(NSError * error) {
       NSString * debug = @"debug";
   };

   [self initUserWithCompletionHandler:completion errorHandler:error];
}


- (void)getUserSubscriptions {
   YoutubeResponseBlock completion = ^(NSArray * array) {
       self.youtubeAuthUser.subscriptions = array;

       if (self.delegate) {
          [self.delegate FetchYoutubeAuthUserCompletion:self.youtubeAuthUser];
       }
   };
   ErrorResponseBlock error = ^(NSError * error) {
       NSString * debug = @"debug";
   };
   [self fetchSubscriptionsListWithChannelId:self.youtubeAuthUser.channel.identifier
                           CompletionHandler:completion
                                errorHandler:error];
}



//  "userID" -> "106717865566488673403"
//  "scope" -> "https://www.googleapis.com/auth/plus.me https://www.googleapis.com/auth/userinfo.email"

- (void)signingOut {
   if (self.isSignedIn == NO)
      return;

   // 1
   [[YoutubeAuthDataStore getInstance] resetAuthUserChannel];

   // 2
   self.youtubeAuthUser = nil;
   [GTMOAuth2ViewControllerTouch removeAuthFromKeychainForName:kKeychainItemName];
   [GTMOAuth2ViewControllerTouch revokeTokenForGoogleAuthentication:self.youTubeService.authorizer];
}


#pragma mark -
#pragma mark Fetch auth User's Subscriptions


- (void)fetchSubscriptionsListWithChannelId:(NSString *)channelId CompletionHandler:(YoutubeResponseBlock)completion errorHandler:(ErrorResponseBlock)errorBlock {
   GTLServiceYouTube * service = self.youTubeService;

//   GTLQueryYouTube * query = [GTLQueryYouTube queryForSubscriptionsListWithPart:@"id,snippet,contentDetails"];
   GTLQueryYouTube * query = [GTLQueryYouTube queryForSubscriptionsListWithPart:@"id,snippet"];
   query.maxResults = 10;
   query.channelId = channelId;

   _searchListTicket = [service executeQuery:query
                           completionHandler:^(GTLServiceTicket * ticket,
                            GTLYouTubeSubscriptionListResponse * resultList,
                            NSError * error) {
                               // The contentDetails of the response has the playlists available for "my channel".
                               if ([[resultList items] count] > 0) {
                                  completion([resultList items]);
                               }
                               errorBlock(error);
                               _searchListTicket = nil;
                           }];
}


- (void)fetchWantWatchListWithCompletionHandler:(YoutubeResponseBlock)completion
                                   errorHandler:(ErrorResponseBlock)errorBlock {
   GTLServiceYouTube * service = self.youTubeService;

//   GTLQueryYouTube * query = [GTLQueryYouTube queryForSubscriptionsListWithPart:@"id,snippet,contentDetails"];
   GTLQueryYouTube * query = [GTLQueryYouTube queryForSubscriptionsListWithPart:@"snippet"];
   query.forMine = YES;
   query.maxResults = 50;
   query.fields = @"items(id/videoId)";
//   query.fields = @"items,nextPageToken";

   _searchListTicket = [service executeQuery:query
                           completionHandler:^(GTLServiceTicket * ticket,
                            GTLYouTubeSubscriptionListResponse * resultList,
                            NSError * error) {
                               // The contentDetails of the response has the playlists available for "my channel".
                               if ([[resultList items] count] > 0) {
                                  completion([resultList items]);
                               }
                               errorBlock(error);
                               _searchListTicket = nil;
                           }];
}


#pragma mark -
#pragma mark Fetch auth User's Subscriptions


- (void)initUserWithCompletionHandler:(YoutubeResponseBlock)completion
                         errorHandler:(ErrorResponseBlock)errorBlock {
   GTLServiceYouTube * service = self.youTubeService;

//   GTLQueryYouTube * query = [GTLQueryYouTube queryForChannelsListWithPart:@"id,snippet,auditDetails,brandingSettings,contentDetails,invideoPromotion,statistics,status,topicDetails"];
   GTLQueryYouTube * query = [GTLQueryYouTube queryForChannelsListWithPart:@"id,snippet"];
   query.mine = YES;

   _searchListTicket = [service executeQuery:query
                           completionHandler:^(GTLServiceTicket * ticket,
                            GTLYouTubeChannelListResponse * resultList,
                            NSError * error) {
                               // The contentDetails of the response has the playlists available for "my channel".
                               if ([[resultList items] count] > 0) {
                                  completion([resultList items]);
                               }
                               errorBlock(error);
                               _searchListTicket = nil;
                           }];
}


@end
