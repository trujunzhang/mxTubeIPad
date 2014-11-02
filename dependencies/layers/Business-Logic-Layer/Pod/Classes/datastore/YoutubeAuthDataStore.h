//
//  YoutubeAuthDataStore.h
//  IOSTemplate
//
//  Created by djzhang on 9/25/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import <Foundation/Foundation.h>





@interface YoutubeAuthDataStore : NSObject


- (void)saveAuthUserChannel:(NSString *)channelTitle withEmail:(NSString *)email;
- (void)resetAuthUserChannel;
- (NSString *)readAuthUserChannelTitle;
- (NSString *)readAuthUserEmail;
@end
