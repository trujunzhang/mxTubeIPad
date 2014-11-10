//
//  Search.h
//  IOSTemplate
//
//  Created by djzhang on 9/25/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//



@interface GYoutubeSearchInfo : NSObject {


}
@property(nonatomic, copy) NSString * queryType;

@property(nonatomic, strong) NSMutableDictionary * parameters;
@property(nonatomic, copy) NSString * queryTeam;

@property(nonatomic, copy) NSString * pageToken;
- (instancetype)initWithQueryType:(NSString *)queryType withTeam:(NSString *)team;
- (void)setNextPageToken:(NSString *)token;


@end
