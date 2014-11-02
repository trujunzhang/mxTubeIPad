//
//  YoutubeAuthDataStore.m
//  IOSTemplate
//
//  Created by djzhang on 9/25/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import "YoutubeAuthDataStore.h"


YoutubeAuthDataStore * instance;

static NSString * const GTM_CHANNEL_TITLE = @"GTM_channel_title";
static NSString * const GTM_CHANNEL_EMAIL = @"GTM_auth_email";


@implementation YoutubeAuthDataStore


+ (YoutubeAuthDataStore *)getInstance {
   @synchronized (self) {
      if (instance == nil) {
         instance = [[self alloc] init];
      }
   }
   return (instance);
}


- (void)saveAuthUserChannel:(NSString *)channelTitle withEmail:(NSString *)email {
   NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
   [defaults setObject:channelTitle forKey:GTM_CHANNEL_TITLE];
   [defaults setObject:email forKey:GTM_CHANNEL_EMAIL];
   [defaults synchronize];
}


- (void)resetAuthUserChannel {
   NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
   [defaults setObject:nil forKey:GTM_CHANNEL_TITLE];
   [defaults setObject:nil forKey:GTM_CHANNEL_EMAIL];
   [defaults synchronize];
}


- (NSString *)readAuthUserChannelTitle {
   NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
   if ([defaults objectForKey:GTM_CHANNEL_TITLE]) {
      return [NSKeyedUnarchiver unarchiveObjectWithData:[defaults objectForKey:GTM_CHANNEL_TITLE]];
   }
   return @"";
}


- (NSString *)readAuthUserEmail {
   NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
   if ([defaults objectForKey:GTM_CHANNEL_EMAIL]) {
      return [NSKeyedUnarchiver unarchiveObjectWithData:[defaults objectForKey:GTM_CHANNEL_EMAIL]];
   }
   return @"";
}


@end
