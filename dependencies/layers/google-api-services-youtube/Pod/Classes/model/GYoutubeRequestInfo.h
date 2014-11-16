//
//  Search.h
//  IOSTemplate
//
//  Created by djzhang on 9/25/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//


#include "YoutubeConstants.h"


@interface GYoutubeRequestInfo : NSObject {


}

@property(nonatomic, strong) NSMutableArray * videoList;

@property(nonatomic) BOOL hasLoadingMore;
@property(nonatomic, copy) NSString * queryType;

@property(nonatomic, strong) NSMutableDictionary * parameters;

@property(nonatomic) YTSegmentItemType itemType;
@property(nonatomic, copy) NSString * queryTeam;

@property(nonatomic, copy) NSString * itemIdentify;

@property(nonatomic, copy) NSString * channelId;

@property(nonatomic) enum YTPlaylistItemsType playlistItemsType;

@property(nonatomic, copy) NSString * nextPageToken;

- (void)resetRequestInfoForSuggestionList:(NSString *)id1;
- (void)resetRequestInfoForPlayList:(enum YTPlaylistItemsType)playlistItemsType;
- (void)resetRequestInfo;
- (void)resetRequestInfoForSearchWithItemType:(enum YTSegmentItemType)itemType withQueryTeam:(NSString *)queryTeam;
- (void)putNextPageToken:(NSString *)token;
- (BOOL)hasNextPage;

+ (NSArray *)getChannelPageSegmentTitlesArray;
- (void)appendNextPageData:(NSArray *)array;
+ (NSString *)getIdentifyByItemType:(YTSegmentItemType)itemType;
- (void)resetInfo;
+ (YTSegmentItemType)getItemTypeByIndex:(int)index;
+ (NSArray *)getSegmentTitlesArray;


@end
