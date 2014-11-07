//
//  Search.m
//  IOSTemplate
//
//  Created by djzhang on 9/25/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import "GYoutubeAuthUser.h"

#import "YoutubeConstants.h"


@implementation GYoutubeAuthUser


- (NSArray *)getTableRows {
   NSMutableArray * rows = [[NSMutableArray alloc] init];
   for (YTYouTubeSubscription * subscription in self.subscriptions) {
      NSString * title = subscription.snippet.title;
      NSString * thumbnailsUrl = subscription.snippet.thumbnails.high.url;
      NSArray * row = @[ title, thumbnailsUrl ];

      [rows addObject:row];
   }

   return [rows copy];
}


+ (NSString *)getUserThumbnails:(GTLYouTubeChannel *)channel {
   return channel.snippet.thumbnails.high.url;
}


@end
