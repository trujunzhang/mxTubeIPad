//
//  Search.m
//  IOSTemplate
//
//  Created by djzhang on 9/25/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import <google-api-services-youtube/YoutubeConstants.h>
#import "GYoutubeRequestInfo.h"


@interface GYoutubeRequestInfo ()

@end


@implementation GYoutubeRequestInfo


#pragma mark - for search


- (instancetype)init {
   self = [super init];
   if (self) {
      self.hasLoadingMore = NO;
   }

   return self;
}


- (instancetype)initWithSearchItemType:(YTSegmentItemType)itemType withQueryTeam:(NSString *)queryTeam {
   self = [super init];
   if (self) {
      [self resetSearchWithItemType:itemType withQueryTeam:queryTeam];
   }

   return self;
}


#pragma mark - search


- (void)resetSearchWithItemType:(enum YTSegmentItemType)itemType {
   self.queryType = @"";
   self.queryTeam = @"";

   self.itemType = [self getItemType];
   self.itemIdentify = [GYoutubeRequestInfo getIdentifyByItemType:self.itemType];

   self.hasLoadingMore = YES;

   self.parameters = [[NSMutableDictionary alloc] init];
}


- (void)resetSearchWithItemType:(enum YTSegmentItemType)itemType withQueryTeam:(NSString *)team {
   self.queryType = [GYoutubeRequestInfo getQueryTypeArray][itemType];
   self.queryTeam = team;
   self.itemType = [self getItemType];
   self.itemIdentify = [GYoutubeRequestInfo getIdentifyByItemType:self.itemType];

   self.hasLoadingMore = YES;

   NSDictionary * parameters = @{
    @"part" : @"id,snippet",
    @"fields" : @"items(id/videoId),nextPageToken",
   };
   self.parameters = [[NSMutableDictionary alloc] initWithDictionary:parameters];
}


- (void)putNextPageToken:(NSString *)pageToken {
   if (pageToken) {
      [self.parameters setObject:pageToken forKey:@"pageToken"];
   } else {
      self.hasLoadingMore = NO;
   }
}


#pragma mark -
#pragma mark


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


#pragma mark -
#pragma mark - next page


- (void)cleanup {
   self.videoList = [[NSMutableArray alloc] init];
   self.hasLoadingMore = NO;
}


- (BOOL)hasNextPage {
   return self.hasLoadingMore;
}


- (void)appendNextPageData:(NSArray *)array {
   NSLog(@"leng = %d", array.count);
   self.hasLoadingMore = YES;
   if (array.count == 0) {
      self.hasLoadingMore = NO;
   } else {
      [self.videoList addObjectsFromArray:array];
   }
}


#pragma mark  Constant


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


@end
