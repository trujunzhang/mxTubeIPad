//
//  Search.h
//  IOSTemplate
//
//  Created by djzhang on 9/25/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "YoutubeConstants.h"


@class GYoutubeAuthUser;
@class YoutubeAuthInfo;
@class GYoutubeRequestInfo;

typedef void (^YoutubeResponseBlock)(NSArray * array);
typedef void (^ErrorResponseBlock)(NSError * error);


@protocol GYoutubeHelperDelegate<NSObject>

@optional

- (void)FetchYoutubeSubscriptionListCompletion:(GYoutubeAuthUser *)user;
- (void)FetchYoutubeChannelCompletion:(YoutubeAuthInfo *)info;

@end


@interface GYoutubeHelper : NSObject {

}
// Accessor for the app's single instance of the service object.
@property(nonatomic, strong) YTServiceYouTube * youTubeService;
@property(nonatomic, strong) GYoutubeAuthUser * youtubeAuthUser;
@property(nonatomic) BOOL isSignedIn;

+ (GYoutubeHelper *)getInstance;


- (void)searchByQueryWithRequestInfo:(GYoutubeRequestInfo *)info completionHandler:(YoutubeResponseBlock)handler errorHandler:(ErrorResponseBlock)handler1;

- (void)signingOut;
- (void)fetchSubscriptionsListWithChannelId:(NSString *)channelId CompletionHandler:(YoutubeResponseBlock)completion errorHandler:(ErrorResponseBlock)errorBlock;
- (void)fetchChannelListWithIdentifier:(NSString *)channelId completion:(YoutubeResponseBlock)completion errorHandler:(ErrorResponseBlock)errorBlock;
- (NSString *)fetchChannelThumbnailsWithChannelId:(NSString *)channelId completion:(YoutubeResponseBlock)completion errorHandler:(ErrorResponseBlock)errorBlock;
- (void)fetchPlaylistItemsListWithTagType:(enum YTPlaylistItemsType)tagType completion:(YoutubeResponseBlock)completion errorHandler:(ErrorResponseBlock)errorBlock;
- (void)fetchActivityListWithRequestInfo:(GYoutubeRequestInfo *)info CompletionHandler:(YoutubeResponseBlock)completion errorHandler:(ErrorResponseBlock)errorHandler;
- (void)fetchSuggestionListWithRequestInfo:(GYoutubeRequestInfo *)info CompletionHandler:(YoutubeResponseBlock)completion errorHandler:(ErrorResponseBlock)errorHandler;
- (void)fetchPlaylistItemsListWithPlaylists:(GTLYouTubeChannelContentDetailsRelatedPlaylists *)playlists tagType:(enum YTPlaylistItemsType)tagType completion:(YoutubeResponseBlock)completion errorHandler:(ErrorResponseBlock)errorBlock;
- (YTOAuth2Authentication *)getAuthorizer;
- (void)saveAuthorizeAndFetchUserInfo:(YTOAuth2Authentication *)authentication;
- (GTMOAuth2ViewControllerTouch *)getYoutubeOAuth2ViewControllerTouchWithTouchDelegate:(id)touchDelegate leftBarDelegate:(id)leftBarDelegate cancelAction:(SEL)cancelAction;

@property(nonatomic, weak) id<GYoutubeHelperDelegate> delegate;
- (void)fetchPlaylistItemsListWithRequestInfo:(GYoutubeRequestInfo *)info completion:(YoutubeResponseBlock)completion errorHandler:(ErrorResponseBlock)handler;


@end
