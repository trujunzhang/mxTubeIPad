//
//  YoutubeAuthDataStore.m
//  IOSTemplate
//
//  Created by djzhang on 11/2/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import "YoutubeAuthDataStore.h"
#import "YoutubeAuthInfo.h"


@implementation YoutubeAuthDataStore


- (void)resetAuthUserChannel {
   NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
   [defaults setObject:nil forKey:@"GTM_youtube_info"];
   [defaults synchronize];
}


- (YoutubeAuthInfo *)readAuthUserInfo {
   NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
   if ([defaults objectForKey:@"GTM_youtube_info"]) {
      return [NSKeyedUnarchiver unarchiveObjectWithData:[defaults objectForKey:@"GTM_youtube_info"]];
   } else {
      return [[YoutubeAuthInfo alloc] init];
   }

   return nil;
}


- (YoutubeAuthInfo *)saveAuthUserChannelWithTitle:(NSString *)title withEmail:(NSString *)email withThumbmailUrl:(NSString *)thumbnailUrl {
   // 1
   YoutubeAuthInfo * info = [[YoutubeAuthInfo alloc] init];
   info.title = title;
   info.email = email;
   info.thumbnailUrl = thumbnailUrl;

   // 2
   NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
   [defaults setObject:info forKey:@"GTM_youtube_info"];
   [defaults synchronize];

   return info;
}


@end
