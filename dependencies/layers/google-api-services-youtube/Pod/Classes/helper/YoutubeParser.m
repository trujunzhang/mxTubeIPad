//
//  YoutubeParser.m
//  IOSTemplate
//
//  Created by djzhang on 11/15/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import "MABYT3_APIRequest.h"
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
      MABYT3_ResourceId * resourceId = [self getResourceIDByActivity:searchResult.contentDetails];
      if (resourceId)
         [videoIds addObject:resourceId.videoId];
   }
   return [videoIds componentsJoinedByString:@","];
}


+ (MABYT3_ResourceId *)getResourceIDByActivity:(YTYouTubeActivityContentDetails *)contentDetails {
   NSArray * resourceArray = @[
    contentDetails.upload,
    contentDetails.like,
   ];

   for (YTYouTubeResourceId * resourceId in resourceArray) {
      if (resourceId.videoId)
         return resourceId.videoId;
   }

   return nil;
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


+ (NSError *)getError:(NSData *)data httpresp:(NSHTTPURLResponse *)httpresp {
   NSError * error;
   NSError * e = nil;
   NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data
                                                         options:NSJSONReadingMutableContainers
                                                           error:&e];
   if ([dict objectForKey:@"error"]) {
      NSDictionary * dict2 = [dict objectForKey:@"error"];
      if ([dict2 objectForKey:@"errors"]) {
         NSArray * items = [dict2 objectForKey:@"errors"];
         if (items.count > 0) {
            NSString * dom = @"YTAPI";
            if ([items[0] objectForKey:@"domain"]) {
               dom = [items[0] objectForKey:@"domain"];
            }
            error = [NSError errorWithDomain:dom
                                        code:httpresp.statusCode
                                    userInfo:items[0]];
         }
      }
   }
   return error;
}
@end
