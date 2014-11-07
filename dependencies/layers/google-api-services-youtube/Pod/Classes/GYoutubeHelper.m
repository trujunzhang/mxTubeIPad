//
//  Search.m
//  IOSTemplate
//
//  Created by djzhang on 9/25/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//


#import "GYoutubeHelper.h"

#import "GYoutubeAuthUser.h"
#import "YoutubeAuthDataStore.h"
#import "YoutubeAuthInfo.h"

#import "MAB_GoogleAccessToken.h"
#import "MAB_GoogleUserCredentials.h"

static GYoutubeHelper * instance = nil;


@interface GYoutubeHelper ()<MAB_GoogleUserCredentialsDelegate> {
   GTLServiceTicket * _searchListTicket;
}
@end


@implementation GYoutubeHelper

#pragma mark -
#pragma mark Global YTServiceYouTube instance


- (YTServiceYouTube *)youTubeService {
   static YTServiceYouTube * service;

   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
       service = [[YTServiceYouTube alloc] init];

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
//      [MAB_GoogleUserCredentials sharedInstance].delegate = self;
   }

   return self;
}


#pragma mark -
#pragma mark initialize Youtube Service


- (void)initYoutubeService {
   // 1
   self.youTubeService.APIKey = apiKey;

   // 2
   YTOAuth2Authentication * auth;
   auth = [GTMOAuth2ViewControllerTouch authForGoogleFromKeychainForName:kKeychainItemName
                                                                clientID:kMyClientID
                                                            clientSecret:kMyClientSecret];
   // 3
   [self fetchAuthorizeInfo:auth];

   // 4
   [self saveMABGoogleAccessToken:[YoutubeAuthDataStore readTokens]];
}


#pragma mark -


- (void)saveMABGoogleAccessToken:(YoutubeAuthInfo *)youtubeAuthInfo {
   MAB_GoogleAccessToken * token = [[MAB_GoogleAccessToken alloc] init];
   token.accessToken = youtubeAuthInfo.accessToken;
   token.refreshToken = youtubeAuthInfo.refreshToken;
//   token.tokenTime = youtubeAuthInfo.expirationDate;
//   token.tokenType = youtubeAuthInfo.tokenType;

   [[MAB_GoogleUserCredentials sharedInstance] setAuthToken:token isSignedIn:self.isSignedIn];
}


#pragma mark Youtube search.


- (NSArray *)searchByQueryWithQueryType:(NSString *)queryType queryTerm:(NSString *)queryTerm completionHandler:(YoutubeResponseBlock)responseHandler errorHandler:(ErrorResponseBlock)errorHandler {
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
   [self fetchSearchListWithQueryType:queryType queryTerm:queryTerm completionHandler:completion errorHandler:error];

   return nil;
}


- (void)searchVideoByVideoIds:(NSArray *)searchResultList completionHandler:(YoutubeResponseBlock)responseHandler errorHandler:(ErrorResponseBlock)errorHandler {
   NSMutableArray * videoIds = [[NSMutableArray alloc] init];

   if (searchResultList) {
      // Merge video IDs
      for (YTYouTubeSearchResult * searchResult in searchResultList) {
         [videoIds addObject:searchResult.identifier.videoId];
      }
      [self fetchVideoListWithVideoId:[videoIds componentsJoinedByString:@","]
                    completionHandler:responseHandler
                         errorHandler:errorHandler];
   }
}


- (void)fetchSearchListWithQueryType:(NSString *)queryType queryTerm:(NSString *)queryTerm completionHandler:(YoutubeResponseBlock)completion errorHandler:(ErrorResponseBlock)errorBlock {
   NSDictionary * parameters = @{
    @"part" : @"id,snippet",
    @"q" : queryTerm,
    @"fields" : @"items(id/videoId)",
   };
   NSString * urlStr = [[MABYT3_APIRequest sharedInstance] VideoSearchURLforTerm:queryTerm
                                                                       queryType:@"playlist"
                                                                  withParameters:parameters
                                                                   andMaxResults:10];
   [[MABYT3_APIRequest sharedInstance]
    fetchWithUrl:urlStr
      andHandler:^(NSMutableArray * results, NSError * error, NSString * pageToken) {
          if (!error) {
             completion(results);
          }
          else {
             NSLog(@"%@", error.description);
             errorBlock(error);
          }
      }];
}


- (void)fetchSearchListWithQueryType111:(NSString *)queryType queryTerm:(NSString *)queryTerm completionHandler:(YoutubeResponseBlock)completion errorHandler:(ErrorResponseBlock)errorBlock {
   YTServiceYouTube * service = self.youTubeService;

   YTQueryYouTube * query = [YTQueryYouTube queryForSearchListWithPart:@"id,snippet"];
   query.q = queryTerm;
   query.type = queryType;
//   query.type = @"video";
//   query.type = @"channel";

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
   YTServiceYouTube * service = self.youTubeService;

   YTQueryYouTube * query = [YTQueryYouTube queryForVideosListWithPart:@"snippet,contentDetails, statistics"];
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


- (void)fetchVideoListWithVideoId123:(NSString *)videoId
                   completionHandler:(YoutubeResponseBlock)completion
                        errorHandler:(ErrorResponseBlock)errorBlock {
   YTServiceYouTube * service = self.youTubeService;

   YTQueryYouTube * query = [YTQueryYouTube queryForVideosListWithPart:@"snippet,contentDetails, statistics"];
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


- (YTOAuth2Authentication *)getAuthorizer {
   return self.youTubeService.authorizer;
}


- (void)fetchAuthorizeInfo:(YTOAuth2Authentication *)authentication {
   self.youTubeService.authorizer = authentication;
   self.isSignedIn = authentication.canAuthorize;

   if (self.isSignedIn) {
      [self getAuthUserInfo];
   }
}


- (void)saveAuthorizeAndFetchUserInfo:(YTOAuth2Authentication *)authentication {
   // 1
   [self fetchAuthorizeInfo:authentication];
   // 2
   YoutubeAuthInfo * info = [YoutubeAuthDataStore saveAuthAccessToken:authentication.accessToken
                                                         refreshToken:authentication.refreshToken];
   // 3
   [self saveMABGoogleAccessToken:info];
}


- (void)getAuthUserInfo {
   self.youtubeAuthUser = [[GYoutubeAuthUser alloc] init];

//   [self getUserInfo];// used
}


- (void)getUserInfo {
   YoutubeResponseBlock completion = ^(NSArray * array) {
       // 1
       GTLYouTubeChannel * channel = array[0];
       // save user title
       NSString * title = channel.snippet.title;
       NSString * email = self.youTubeService.authorizer.userEmail;
       NSString * thumbnailUrl = [GYoutubeAuthUser getUserThumbnails:channel];
       YoutubeAuthInfo * info = [[[YoutubeAuthDataStore alloc] init] saveAuthUserChannelWithTitle:title
                                                                                        withEmail:email
                                                                                 withThumbmailUrl:thumbnailUrl];
       self.youtubeAuthUser.channel = channel;

       if (self.delegate)
          [self.delegate FetchYoutubeChannelCompletion:info];


       // 2
       [self getUserSubscriptions:self.delegate];

       // "id" -> "UC0wObT_HayGfWLdRAnFyPwA"
       NSLog(@" user name = %@", self.youtubeAuthUser.channel.snippet.title);
   };

   ErrorResponseBlock error = ^(NSError * error) {
       NSString * debug = @"debug";
   };

   [self fetchAuthUserChannelWithCompletion:completion errorHandler:error];
}


- (void)getUserSubscriptions:(id<GYoutubeHelperDelegate>)delegate {
   YoutubeResponseBlock completion = ^(NSArray * array) {
       self.youtubeAuthUser.subscriptions = array;

//       for (int i = 0; i < array.count; i++) {
//          GTLYouTubeSubscription * subscription = (GTLYouTubeSubscription *) array[i];
//          GTLYouTubeSubscriptionContentDetails * details = [subscription contentDetails];
//          NSString * activityType = details.activityType;
//
//          NSNumber * number = [details newItemCount];
//          if ([number intValue] > 0) {
//             NSLog(@"%@", subscription.snippet.title);
//             NSLog(@"%d", [number intValue]);
//             NSLog(@"%@", subscription.snippet.channelId);
//             if ([subscription.snippet.title isEqualToString:@"The Online Piano and Violin Tutor"]) {
//                NSString * debug = @"debug";
//             }
//          }
//
//          if ([subscription.snippet.title isEqualToString:@"XiveTV"]) {
//
//             NSString * debug = @"debug";
//             YoutubeResponseBlock channelCompletionBlock = ^(NSArray * array) {
//                 GTLYouTubeChannel * channel = array[0];
////                 contentDetails.relatedPlaylists.uploads
//                 NSString * uploadsVar = channel.contentDetails.relatedPlaylists.uploads;
//                 [self fetchPlaylistItemsListWithplaylistId:channel
//                                                 completion:nil
//                                               errorHandler:nil];
//             };
//             ErrorResponseBlock channelErrorBlock = ^(NSError * error) {
//
//             };
//
//             GTLYouTubeResourceId * resourceId = subscription.snippet.resourceId;
//             NSString * identifier = [(resourceId.JSON) objectForKey:@"channelId"];
//             //"channelId" -> "UCNVqxnfsf0KJjIRlWRMD3cA"
//             // UC0wObT_HayGfWLdRAnFyPwA
//             // QmeTdj_6PqKCdSgz_RNI17IZL-GPEOlyfsiHizcoMRM
//             [self fetchChannelListWithIdentifier:identifier
//                                       completion:channelCompletionBlock
//                                     errorHandler:channelErrorBlock];
//
//          }
//       }

       if (delegate)
          [delegate FetchYoutubeSubscriptionListCompletion:self.youtubeAuthUser];

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
   [[[YoutubeAuthDataStore alloc] init] resetAuthUserChannel];

   // 2
   self.youtubeAuthUser = nil;
   [GTMOAuth2ViewControllerTouch removeAuthFromKeychainForName:kKeychainItemName];
   [GTMOAuth2ViewControllerTouch revokeTokenForGoogleAuthentication:self.youTubeService.authorizer];

   // 3
   [YoutubeAuthDataStore resetAuthToken];
}


#pragma mark -
#pragma mark Fetch auth User's Subscriptions


- (void)fetchSubscriptionsListWithChannelId:(NSString *)channelId CompletionHandler:(YoutubeResponseBlock)completion errorHandler:(ErrorResponseBlock)errorBlock {
   YTServiceYouTube * service = self.youTubeService;

   YTQueryYouTube * query = [YTQueryYouTube queryForSubscriptionsListWithPart:@"id,snippet,contentDetails"];
//   YTQueryYouTube * query = [YTQueryYouTube queryForSubscriptionsListWithPart:@"id,snippet"];
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


#pragma mark -
#pragma mark Fetch channels list.


- (void)fetchPlaylistItemsListWithplaylistId:(GTLYouTubeChannel *)channel completion:(YoutubeResponseBlock)completion errorHandler:(ErrorResponseBlock)errorBlock {
   YTServiceYouTube * service = self.youTubeService;

   YTQueryYouTube * query = [YTQueryYouTube queryForPlaylistItemsListWithPart:@"snippet"];
   query.identifier = channel.identifier;
   query.playlistId = channel.contentDetails.relatedPlaylists.uploads;

//   query.order = @"date";
//   query.publishedBefore = [GTLDateTime dateTimeWithDate:[NSDate dateWithTimeIntervalSinceNow:-(24 * 60 * 60)]
//                                                timeZone:[NSTimeZone systemTimeZone]];
   query.maxResults = 10;
//   query.playlistId = @"PL6urkeK7KgD4vU4jbCTimNXdtB1gqvWsP";


   _searchListTicket = [service executeQuery:query
                           completionHandler:^(GTLServiceTicket * ticket,
                            GTLYouTubePlaylistItemListResponse * resultList,
                            NSError * error) {
                               // The contentDetails of the response has the playlists available for "my channel".
                               NSArray * array = [resultList items];
                               GTLYouTubePlaylistItem * item = array[0];
                               if ([array count] > 0) {
                                  completion(array);
                               }
                               errorBlock(error);
                               _searchListTicket = nil;
                           }];
}
//"Error Domain=com.google.GTLJSONRPCErrorDomain Code=-32602 "The operation couldn’t be completed. (Incompatible parameters specified in the request.)" UserInfo=0x7ae756c0 {error=Incompatible parameters specified in the request., GTLStructuredError=GTLErrorObject 0x7ae29b60: {message:"Incompatible parameters specified in the request." code:-32602 data:[1]}, NSLocalizedFailureReason=(Incompatible parameters specified in the request.)}"

- (void)fetchChannelListWithIdentifier:(NSString *)identifier completion:(YoutubeResponseBlock)completion errorHandler:(ErrorResponseBlock)errorBlock {
   YTServiceYouTube * service = self.youTubeService;

   YTQueryYouTube * query = [YTQueryYouTube queryForChannelsListWithPart:@"id,snippet,contentDetails"];
//   YTQueryYouTube * query = [YTQueryYouTube queryForChannelsListWithPart:@"id,snippet,contentDetails"];
   query.identifier = identifier;

   _searchListTicket = [service executeQuery:query
                           completionHandler:^(GTLServiceTicket * ticket,
                            GTLYouTubeChannelListResponse * resultList,
                            NSError * error) {
                               // The contentDetails of the response has the playlists available for "my channel".
                               NSArray * array = [resultList items];
                               if ([array count] > 0) {
                                  completion(array);
                               }
                               errorBlock(error);
                               _searchListTicket = nil;
                           }];
}


- (void)fetchAuthUserChannelWithCompletion:(YoutubeResponseBlock)completion errorHandler:(ErrorResponseBlock)errorBlock {
   YTServiceYouTube * service = self.youTubeService;

//   YTQueryYouTube * query = [YTQueryYouTube queryForChannelsListWithPart:@"id,snippet,auditDetails,brandingSettings,contentDetails,invideoPromotion,statistics,status,topicDetails"];
   YTQueryYouTube * query = [YTQueryYouTube queryForChannelsListWithPart:@"id,snippet,contentDetails"];
//   YTQueryYouTube * query = [YTQueryYouTube queryForChannelsListWithPart:@"id,snippet"];
   query.mine = YES;

   _searchListTicket = [service executeQuery:query
                           completionHandler:^(GTLServiceTicket * ticket,
                            GTLYouTubeChannelListResponse * resultList,
                            NSError * error) {
                               // The contentDetails of the response has the playlists available for "my channel".
                               NSArray * array = [resultList items];
                               if ([array count] > 0) {
                                  completion(array);
                               }
                               errorBlock(error);
                               _searchListTicket = nil;
                           }];
}


@end
