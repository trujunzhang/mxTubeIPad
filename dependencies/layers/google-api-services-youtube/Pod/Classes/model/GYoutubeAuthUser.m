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
      if ([title isEqualToString:@"Adobe Acrobat"]) {
         NSString * debug = @"debug";
         //"channelId" -> "UCl78QGX_hfK6zT8Mc-2w8GA"
      }
      NSString * thumbnailsUrl = [YoutubeParser getSubscriptionSnippetThumbnailUrl:subscription];
      NSArray * row = @[ title, thumbnailsUrl ];

      [rows addObject:row];
   }

   return [rows copy];
}




@end
