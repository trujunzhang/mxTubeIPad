//
//  Search.m
//  IOSTemplate
//
//  Created by djzhang on 9/25/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import "GYoutubeSearchInfo.h"


@implementation GYoutubeSearchInfo


- (instancetype)initWithQueryType:(NSString *)queryType withTeam:(NSString *)team {
   self = [super init];
   if (self) {
      self.queryType = queryType;
      self.queryTeam = team;
      self.parameters = [[NSMutableDictionary alloc] init];
      [self.parameters setObject:@"id,snippet" forKey:@"part"];
      [self.parameters setObject:@"items(id/videoId),nextPageToken" forKey:@"fields"];
   }

   return self;
}


- (void)setNextPageToken:(NSString *)pageToken {
   [self.parameters setObject:pageToken forKey:@"pageToken"];
}
@end
