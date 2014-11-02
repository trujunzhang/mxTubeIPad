//
//  YoutubeAuthDataStore.m
//  IOSTemplate
//
//  Created by djzhang on 9/25/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import "YoutubeAuthDataStore.h"


YoutubeAuthDataStore * instance;

static NSString * const GTM_YOUTUBE_INFO = @"GTM_youtube_info";


@implementation YoutubeAuthDataStore


+ (YoutubeAuthDataStore *)getInstance {
   @synchronized (self) {
      if (instance == nil) {
         instance = [[self alloc] init];
      }
   }
   return (instance);
}


- (void)resetAuthUserChannel {
   NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
   [defaults setObject:nil forKey:GTM_YOUTUBE_INFO];
   [defaults synchronize];
}


- (YoutubeAuthInfo *)readAuthUserInfo {
   NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
   if ([defaults objectForKey:GTM_YOUTUBE_INFO]) {
      return [NSKeyedUnarchiver unarchiveObjectWithData:[defaults objectForKey:GTM_YOUTUBE_INFO]];
   }
   return nil;
}


- (void)saveAuthUserChannelWithTitle:(NSString *)title withEmail:(NSString *)email withThumbmailUrl:(NSString *)thumbnailUrl {
   // 1
   YoutubeAuthInfo * info = [[YoutubeAuthInfo alloc] init];
   info.title = title;
   info.email = email;
   info.thumbnailUrl = thumbnailUrl;

   // 2
   NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
   [defaults setObject:info forKey:GTM_YOUTUBE_INFO];
   [defaults synchronize];
}
@end
