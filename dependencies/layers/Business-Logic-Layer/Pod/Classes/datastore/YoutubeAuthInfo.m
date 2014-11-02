//
//  YoutubeAuthInfo.m
//  IOSTemplate
//
//  Created by djzhang on 11/2/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import "YoutubeAuthInfo.h"


@implementation YoutubeAuthInfo

- (instancetype)init {
   self = [super init];
   if (self) {
      self.title = @"";
      self.email = @"";
      self.thumbnailUrl = @"";
   }

   return self;
}

@end
