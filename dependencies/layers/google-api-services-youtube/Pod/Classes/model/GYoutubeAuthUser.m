//
//  Search.m
//  IOSTemplate
//
//  Created by djzhang on 9/25/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import "GYoutubeAuthUser.h"

#import "YoutubeConstants.h"
#import "YoutubeParser.h"


@implementation GYoutubeAuthUser


- (NSArray *)getTableRows {
   NSMutableArray * rows = [[NSMutableArray alloc] init];
   for (YTYouTubeSubscription * subscription in self.subscriptions) {
      NSString * title = subscription.snippet.title;
      NSString * thumbnailsUrl = [YoutubeParser getSubscriptionSnippetThumbnailUrl:subscription];
      NSString * channelId = [YoutubeParser getChannelIdBySubscription:subscription];
      NSArray * row = @[ title, thumbnailsUrl, [NSString stringWithFormat:@"_left_menu_%@", channelId] ];

      [rows addObject:row];
   }

   return [rows copy];
}


@end
