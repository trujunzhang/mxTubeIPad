//
//  Search.m
//  IOSTemplate
//
//  Created by djzhang on 9/25/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import <google-api-services-youtube/YoutubeConstants.h>
#import "GYoutubeSearchInfo.h"


@implementation GYoutubeSearchInfo


- (instancetype)initWithQueryType:(NSString *)queryType withTeam:(NSString *)team {
   self = [super init];
   if (self) {
      self.pageToken = @"";
      self.queryType = queryType;
      self.queryTeam = team;
      self.itemType = [self getItemType];
      self.itemIdentify = [GYoutubeSearchInfo getIdentify:[NSString stringWithFormat:@"%@s", self.queryType]];

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


+ (NSArray *)getSegmentTitlesArray {
   NSArray * segmentTextContent = [NSArray arrayWithObjects:
    @"Videos",
    @"Channels",
    @"Playlists",
     nil];
   return segmentTextContent;
}


+ (NSString *)getIdentify:(NSString *)title {
   return [NSString stringWithFormat:@"%@Identifier", title];
}


- (YTSegmentItemType)getItemType {
   int index = 0;
   NSArray * array = [GYoutubeSearchInfo getSegmentTitlesArray];
   for (int i = 0; i < array.count; ++i) {
      if ([self.queryType isEqualToString:array[i]]) {
         index = i;
         break;
      }
   }
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


@end
