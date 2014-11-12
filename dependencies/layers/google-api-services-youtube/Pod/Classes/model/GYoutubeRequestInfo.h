//
//  Search.h
//  IOSTemplate
//
//  Created by djzhang on 9/25/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//



@interface GYoutubeRequestInfo : NSObject {


}
@property(nonatomic, copy) NSString * queryType;

@property(nonatomic, strong) NSMutableDictionary * parameters;

@property(nonatomic) YTSegmentItemType itemType;
@property(nonatomic, copy) NSString * queryTeam;
@property(nonatomic, copy) NSString * pageToken;

@property(nonatomic, copy) NSString * itemIdentify;

- (instancetype)initWithItemType:(YTSegmentItemType)queryType withTeam:(NSString *)team;
- (void)setNextPageToken:(NSString *)token;

+ (NSString *)getIdentifyByItemType:(YTSegmentItemType)itemType;
+ (YTSegmentItemType)getItemTypeByIndex:(int)index;
+ (NSArray *)getSegmentTitlesArray;


@end
