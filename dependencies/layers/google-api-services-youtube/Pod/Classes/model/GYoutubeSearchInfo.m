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
      NSDictionary * parameters = @{
       @"part" : @"id,snippet",
       @"fields" : @"items(id/videoId)",
      };
      self.parameters = parameters;
   }

   return self;
}


@end
