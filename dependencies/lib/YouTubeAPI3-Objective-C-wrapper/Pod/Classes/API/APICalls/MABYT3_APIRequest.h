//
//  MABYT3_LISTRequest.h
//  YTAPI3Demo
//
//  Created by Muhammad Bassio on 5/6/14.
//  Copyright (c) 2014 Muhammad Bassio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MAB_GoogleUserCredentials.h"
#import "MABYT3_Activity.h"
#import "MABYT3_ChannelSection.h"
#import "MABYT3_GuideCategory.h"
#import "MABYT3_Language.h"
#import "MABYT3_Region.h"
#import "MABYT3_PlayListItem.h"
#import "MABYT3_PlayList.h"
#import "MABYT3_VideoCategory.h"
#import "MABYT3_SearchItem.h"
#import "MABYT3_Video.h"

#import "AFHTTPSessionManager.h"
@class YoutubeResponseInfo;

typedef void (^MABYoutubeResponseBlock)(YoutubeResponseInfo * responseInfo, NSError * error);

static NSString * kKeychainItemName = @"mxyoutube";
static NSUInteger search_maxResults = 15;

@interface MABYT3_APIRequest : AFHTTPSessionManager
+ (MABYT3_APIRequest *)sharedInstance;

- (NSString *)ActivitiesURLforUser:(MABYT3_Channel *)channel withMaxResults:(NSInteger)max;
- (NSString *)ChannelURLWithParameters:(NSDictionary *)params withMaxResults:(NSInteger)max;
- (NSString *)ActivitiesURLforUserWithChannelId:(NSString *)channelId withParameters:(NSDictionary *)params withMaxResults:(NSInteger)max;
- (NSString *)ActivitiesURLforHomeWithMaxResults:(NSInteger)max;
- (NSString *)ActivitiesURLforMeWithMaxResults:(NSInteger)max;

- (NSString *)GuidedCategoriesURLforRegion:(NSString *)reg andLanguage:(NSString *)lang;
- (NSString *)LanguagesURLforLanguae:(NSString *)lang;
- (NSString *)RegionsURLforLanguae:(NSString *)lang;


- (NSString *)PlayListItemsURLforPlayList:(NSString *)playlistId withMaxResults:(NSInteger)max;
- (NSString *)PlayListsURLforMewithMaxResults:(NSInteger)max;
- (NSString *)PlayListsURLforChannel:(NSString *)channelId withMaxResults:(NSInteger)max;
- (NSString *)PlayListsURLforPlayList:(NSString *)playlistId withMaxResults:(NSInteger)max;


- (NSString *)VideoSearchURLforTermWithParameters:(NSDictionary *)params withMaxResults:(NSInteger)max;
- (NSString *)VideoSearchURLforTerm:(NSString *)term queryType:(NSString *)queryType withParameters:(NSDictionary *)params andMaxResults:(NSInteger)max;
- (NSString *)ChannelSearchURLforTerm:(NSString *)term withParameters:(NSDictionary *)params andMaxResults:(NSInteger)max;
- (NSString *)PlayListSearchURLforTerm:(NSString *)term withParameters:(NSDictionary *)params andMaxResults:(NSInteger)max;

- (NSString *)VideoURLforVideoWithParameters:(NSDictionary *)params withMaxResults:(NSInteger)max;
- (NSString *)VideoURLforVideo:(NSString *)videoId withMaxResults:(NSInteger)max;
- (NSString *)ChannelURLforId:(NSString *)channelId withMaxResults:(NSInteger)max;


- (void)LISTActivitiesForURL:(NSString *)urlStr andHandler:(MABYoutubeResponseBlock)handler;
- (void)LISTChannelSectionsForURL:(NSString *)urlStr andHandler:(void (^)(NSMutableArray *, NSError *))handler;
- (void)LISTChannelsForURL:(NSString *)urlStr andHandler:(MABYoutubeResponseBlock)handler;
- (void)LISTGuideCategoriesForURL:(NSString *)urlStr andHandler:(void (^)(NSMutableArray *, NSError *))handler;
- (void)LISTLanguagesForURL:(NSString *)urlStr andHandler:(void (^)(NSMutableArray *, NSError *))handler;
- (void)LISTRegionsForURL:(NSString *)urlStr andHandler:(void (^)(NSMutableArray *, NSError *))handler;
- (NSURLSessionDataTask *)LISTVideosForURL:(NSMutableDictionary *)parameters completion:(MABYoutubeResponseBlock)completion;
- (NSURLSessionDataTask *)LISTChannelsThumbnailsForURL:(NSMutableDictionary *)parameters completion:(MABYoutubeResponseBlock)completion;
- (NSURLSessionDataTask *)LISTActivitiesForURL:(NSMutableDictionary *)parameters completion:(MABYoutubeResponseBlock)completion;
- (NSURLSessionDataTask *)searchForParameters:(NSMutableDictionary *)parameters completion:(MABYoutubeResponseBlock)completion;
- (void)fetchWithUrl:(NSString *)urlStr andHandler:(MABYoutubeResponseBlock)handler;
- (void)LISTPlayListItemsForURL:(NSString *)urlStr andHandler:(MABYoutubeResponseBlock)handler;
- (void)LISTPlayListsForURL:(NSString *)urlStr andHandler:(MABYoutubeResponseBlock)handler;
- (void)LISTVideoCategoriesForURL:(NSString *)urlStr andHandler:(void (^)(NSMutableArray *, NSError *))handler;
- (void)LISTVideosForURL:(NSString *)urlStr andHandler:(MABYoutubeResponseBlock)handler;
- (void)LISTSearchItemsForURL:(NSString *)urlStr andHandler:(MABYoutubeResponseBlock)handler;
- (void)LISTSubscriptionsForURL:(NSString *)urlStr andHandler:(MABYoutubeResponseBlock)handler;


- (void)LIKEVideo:(NSString *)videoId andHandler:(void (^)(NSError *, BOOL))handler;
- (void)DISLIKEVideo:(NSString *)videoId andHandler:(void (^)(NSError *, BOOL))handler;

- (void)INSERTSubscription:(NSString *)channelId andHandler:(void (^)(NSError *, BOOL))handler;
- (void)INSERTVideo:(NSString *)videoId inPlayList:(NSString *)playlistID atPosition:(NSInteger)pos andHandler:(void (^)(NSError *, BOOL))handler;
- (void)INSERTPlayList:(NSString *)playlistTitle withDescription:(NSString *)desc andPrivacyStatus:(YTPrivacyStatus)status andHandler:(void (^)(NSError *, NSString *, BOOL))handler;
- (void)INSERTPlayList:(NSString *)playlistTitle andDescription:(NSString *)desc andHandler:(void (^)(NSError *, NSString *, BOOL))handler;


- (void)UPDATEPlayListItem:(NSString *)itemId withVideo:(NSString *)videoId inPlayList:(NSString *)playlistID atPosition:(NSInteger)pos andHandler:(void (^)(NSError *, BOOL))handler;
- (void)UPDATEPlayList:(NSString *)playlistID withTitle:(NSString *)playlistTitle withDescription:(NSString *)desc andPrivacyStatus:(YTPrivacyStatus)status andHandler:(void (^)(NSError *, BOOL))handler;
- (void)UPDATEPlayList:(NSString *)playlistID withTitle:(NSString *)playlistTitle andDescription:(NSString *)desc andHandler:(void (^)(NSError *, BOOL))handler;


- (void)DELETEPlayListItem:(NSString *)itemId withHandler:(void (^)(NSError *, BOOL))handler;
- (void)DELETEPlayList:(NSString *)playlistID withHandler:(void (^)(NSError *, BOOL))handler;
- (void)DELETESubscription:(NSString *)subscriptionId andHandler:(void (^)(NSError *, BOOL))handler;


@end
