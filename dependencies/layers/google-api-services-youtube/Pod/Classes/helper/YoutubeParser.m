//
//  YoutubeParser.m
//  IOSTemplate
//
//  Created by djzhang on 11/15/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import "YoutubeParser.h"


NSMutableDictionary * channelIdThumbnailDictionary;


@interface YoutubeParser ()

@end


@implementation YoutubeParser

+ (NSMutableDictionary *)getChannelIdThumbnailDictionary {
   if (channelIdThumbnailDictionary == nil) {
      channelIdThumbnailDictionary = [[NSMutableDictionary alloc] init];
   }
   return channelIdThumbnailDictionary;
}


+ (NSString *)getVideoIdsByActivityList:searchResultList {
   NSMutableArray * videoIds = [[NSMutableArray alloc] init];
   for (YTYouTubeActivity * searchResult in searchResultList) {
      [videoIds addObject:searchResult.contentDetails.upload.videoId];
   }
   return [videoIds componentsJoinedByString:@","];
}


+ (NSString *)getVideoIdsBySearchResult:(NSMutableArray *)searchResultList {
   NSMutableArray * videoIds = [[NSMutableArray alloc] init];
   for (YTYouTubeSearchResult * searchResult in searchResultList) {
      [videoIds addObject:searchResult.identifier.videoId];
   }
   return [videoIds componentsJoinedByString:@","];
}


+ (NSString *)getChannelId:(YTYouTubeSubscription *)subscription {
   return subscription.snippet.resourceId.JSON[@"channelId"];
}


+ (NSString *)getWatchVideoId:(YTYouTubeVideo *)video {
   return video.identifier;
}


+ (NSString *)getBannerImageUrl:(YTYouTubeChannel *)channel {
   return channel.brandingSettings.image.bannerMobileHdImageUrl;;
}


+ (NSString *)getSubscriptionSnippetThumbnailUrl:(YTYouTubeSubscription *)subscription {
   return subscription.snippet.thumbnails.high.url;
}


+ (NSString *)getChannelSnippetThumbnailUrl:(YTYouTubeChannel *)channel {
   return channel.snippet.thumbnails.high.url;
}


+ (NSString *)getVideoSnippetThumbnails:(YTYouTubeVideo *)video {
   return video.snippet.thumbnails.medium.url;
}


+ (NSString *)GetMABChannelSnippetThumbnail:(YTYouTubeMABChannel *)channel {
   YTYouTubeMABThumbmail * thumbnail = channel.snippet.thumbnails[@"default"];
   return thumbnail.url;
}


+ (NSString *)getThumbnailKeyWithChannelId:(NSString *)channelId {
   return [NSString stringWithFormat:@"_cache_key_%@", channelId];
}


+ (NSString *)checkAndAppendThumbnailWithChannelId:(NSString *)channelId {
   NSMutableDictionary * dictionary = [YoutubeParser getChannelIdThumbnailDictionary];
   NSString * value = [dictionary objectForKey:channelId];
   if (value) {
      return value;
   }
//   else {
//      [dictionary setValue:nil forKey:keyWithChannelId];
//   }
   return nil;
}


+ (void)AppendThumbnailWithChannelId:(NSString *)channelId withThumbnailUrl:(NSString *)thumbnailUrl {
   NSMutableDictionary * dictionary = [YoutubeParser getChannelIdThumbnailDictionary];
   [dictionary setValue:thumbnailUrl forKey:channelId];
}


+ (NSString *)timeFormatConvertToSecondsWithInteger:(NSUInteger)timeSecs {
   return [YoutubeParser timeFormatConvertToSeconds:[NSString stringWithFormat:@"%d", timeSecs]];
}


+ (NSString *)timeFormatConvertToSeconds:(NSString *)timeSecs {
   int totalSeconds = [timeSecs intValue];

   int seconds = totalSeconds % 60;
   int minutes = (totalSeconds / 60) % 60;
   int hours = totalSeconds / 3600;
   if (hours == 0) {
      return [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
   }

   return [NSString stringWithFormat:@"%02d:%02d:%02d", hours, minutes, seconds];
}

@end
