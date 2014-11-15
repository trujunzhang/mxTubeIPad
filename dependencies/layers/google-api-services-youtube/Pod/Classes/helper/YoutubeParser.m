//
//  YoutubeParser.m
//  IOSTemplate
//
//  Created by djzhang on 11/15/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import "YoutubeParser.h"


@implementation YoutubeParser


+ (NSString *)getVideoIdsByActivityList:searchResultList {
   NSMutableArray * videoIds = [[NSMutableArray alloc] init];
   for (YTYouTubeActivity * searchResult in searchResultList) {
      [videoIds addObject:searchResult.contentDetails.upload.videoId];
   }
   return [videoIds componentsJoinedByString:@","];
}


+ (NSString *)getVideoIdsBySearchResult:searchResultList {
   NSMutableArray * videoIds = [[NSMutableArray alloc] init];
   for (YTYouTubeSearchResult * searchResult in searchResultList) {
      [videoIds addObject:searchResult.identifier.videoId];
   }
   return [videoIds componentsJoinedByString:@","];
}


+ (NSString *)getChannelId:(YTYouTubeSubscription *)subscription {
   return subscription.snippet.resourceId.JSON[@"channelId"];
}
@end
