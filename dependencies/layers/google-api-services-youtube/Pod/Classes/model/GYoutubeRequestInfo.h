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
@property(nonatomic, copy) NSString * nextPageToken;

@property(nonatomic, copy) NSString * itemIdentify;


- (instancetype)initWithSearchItemType:(YTSegmentItemType)queryType withQueryTeam:(NSString *)team;
- (void)resetSearchWithItemType:(enum YTSegmentItemType)itemType withQueryTeam:(NSString *)team;
- (void)putNextPageToken:(NSString *)token;
- (BOOL)hasNextPage;

+ (NSArray *)getChannelPageSegmentTitlesArray;
- (void)appendNextPageData:(NSArray *)array;
+ (NSString *)getIdentifyByItemType:(YTSegmentItemType)itemType;
- (void)cleanup;
+ (YTSegmentItemType)getItemTypeByIndex:(int)index;
+ (NSArray *)getSegmentTitlesArray;


@end
