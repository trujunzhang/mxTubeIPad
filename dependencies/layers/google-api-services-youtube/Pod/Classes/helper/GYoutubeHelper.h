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

- (NSArray *)searchByQueryWithQueryType:(NSString *)queryType queryTerm:(NSString *)queryTerm completionHandler:(YoutubeResponseBlock)responseHandler errorHandler:(ErrorResponseBlock)errorHandler;

- (void)signingOut;
- (void)fetchSubscriptionsListWithChannelId:(NSString *)channelId CompletionHandler:(YoutubeResponseBlock)completion errorHandler:(ErrorResponseBlock)errorBlock;
- (void)fetchChannelListWithIdentifier:(NSString *)channelId completion:(YoutubeResponseBlock)completion errorHandler:(ErrorResponseBlock)errorBlock;
- (YTOAuth2Authentication *)getAuthorizer;
- (void)saveAuthorizeAndFetchUserInfo:(YTOAuth2Authentication *)authentication;
- (GTMOAuth2ViewControllerTouch *)getYoutubeOAuth2ViewControllerTouchWithTouchDelegate:(id)touchDelegate leftBarDelegate:(id)leftBarDelegate cancelAction:(SEL)cancelAction;

@property(nonatomic, weak) id<GYoutubeHelperDelegate> delegate;

@end
