//
//  Search.m
//  IOSTemplate
//
//  Created by djzhang on 9/25/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import "GYoutubeAuthUser.h"
#import "GTLYouTubeChannel.h"
#import "GTLYouTubeSubscription.h"
#import "GTLYouTubeSubscriptionSnippet.h"
#import "GTLYouTubeThumbnailDetails.h"
#import "GTLYouTubeThumbnail.h"


@implementation GYoutubeAuthUser


- (NSArray *)getTableRows {
   NSMutableArray * rows = [[NSMutableArray alloc] init];
   for (GTLYouTubeSubscription * subscription in self.subscriptions) {
      NSString * title = subscription.snippet.title;
      NSString * thumbnailsUrl = subscription.snippet.thumbnails.high.url;
      NSArray * row = @[ title, thumbnailsUrl ];

      [rows addObject:row];

      break;
   }

   return [rows copy];
}
@end
