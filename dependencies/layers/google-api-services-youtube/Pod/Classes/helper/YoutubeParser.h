//
//  YoutubeParser.h
//  IOSTemplate
//
//  Created by djzhang on 11/15/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import "YoutubeConstants.h"




@interface YoutubeParser : NSObject

+ (NSString *)getVideoIdsByActivityList:searchResultList;

+ (NSString *)getVideoIdsBySearchResult:(NSMutableArray *)searchResultList;

+ (NSString *)getChannelId:(YTYouTubeSubscription *)subscription;

+ (NSString *)getVideoSnippetThumbnails:(YTYouTubeVideo *)video;
+ (NSString *)getWatchVideoId:(YTYouTubeVideo *)video;

+ (NSString *)getBannerImageUrl:(YTYouTubeChannel *)channel;
+ (NSString *)getSubscriptionSnippetThumbnailUrl:(YTYouTubeSubscription *)subscription;
+ (NSString *)getChannelSnippetThumbnailUrl:(YTYouTubeChannel *)channel;

+ (NSString *)GetMABChannelSnippetThumbnail:(YTYouTubeMABChannel *)channel;
+ (NSString *)getThumbnailKeyWithChannelId:(NSString *)channelId;
+ (NSString *)checkAndAppendThumbnailWithChannelId:(NSString *)channelId;
+ (void)AppendThumbnailWithChannelId:(NSString *)channelId withThumbnailUrl:(NSString *)thumbnailUrl;
+ (NSString *)timeFormatConvertToSecondsWithInteger:(NSUInteger)timeSecs;
+ (NSString *)timeFormatConvertToSeconds:(NSString *)timeSecs;
+ (NSError *)getError:(NSData *)data httpresp:(NSHTTPURLResponse *)httpresp;
@end
