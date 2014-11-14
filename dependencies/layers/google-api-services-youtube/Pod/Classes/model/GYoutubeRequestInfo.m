//
//  Search.m
//  IOSTemplate
//
//  Created by djzhang on 9/25/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import <google-api-services-youtube/YoutubeConstants.h>
#import "GYoutubeRequestInfo.h"


@implementation GYoutubeRequestInfo


- (instancetype)initWithItemType:(YTSegmentItemType)itemType withTeam:(NSString *)team {
   self = [super init];
   if (self) {
      self.pageToken = @"";
      self.queryType = [GYoutubeRequestInfo getQueryTypeArray][itemType];
      self.queryTeam = team;
      self.itemType = [self getItemType];
      self.itemIdentify = [GYoutubeRequestInfo getIdentifyByItemType:self.itemType];

      NSDictionary * parameters = @{
       @"part" : @"id,snippet",
       @"fields" : @"items(id/videoId),nextPageToken",
      };
      self.parameters = [[NSMutableDictionary alloc] initWithDictionary:parameters];
   }

   return self;
}


- (void)setNextPageToken:(NSString *)pageToken {
   self.pageToken = pageToken;

   if (pageToken)
      [self.parameters setObject:pageToken forKey:@"pageToken"];
}


#pragma mark -
#pragma mark


+ (NSArray *)getChannelPageSegmentTitlesArray {
   NSArray * array = [NSArray arrayWithObjects:
    @"Activity",
    @"Videos",
    @"Playlists",
     nil];
   return array;
}


+ (NSArray *)getSegmentTitlesArray {
   NSArray * array = [NSArray arrayWithObjects:
    @"Videos",
    @"Channels",
    @"Playlists",
     nil];
   return array;
}


+ (NSArray *)getQueryTypeArray {
   NSArray * array = [NSArray arrayWithObjects:
    @"video",
    @"channel",
    @"playlist",
     nil];
   return array;
}


+ (NSString *)getIdentifyByItemType:(YTSegmentItemType)itemType {
   switch (itemType) {
      case YTSegmentItemVideo:
         return @"VideoIdentifier";
      case YTSegmentItemChannel:
         return @"ChannelIdentifier";
      case YTSegmentItemPlaylist:
         return @"PlaylistIdentifier";
   }
   return nil;
}


+ (YTSegmentItemType)getItemTypeByIndex:(int)index {
   switch (index) {
      case 0:
         return YTSegmentItemVideo;
      case 1:
         return YTSegmentItemChannel;
      case 2:
         return YTSegmentItemPlaylist;
   }
   return YTSegmentItemVideo;
}


- (YTSegmentItemType)getItemType {
   int index = 0;
   NSArray * array = [GYoutubeRequestInfo getSegmentTitlesArray];
   for (int i = 0; i < array.count; ++i) {
      if ([self.queryType isEqualToString:array[i]]) {
         index = i;
         break;
      }
   }
   return [GYoutubeRequestInfo getItemTypeByIndex:index];
}


@end
