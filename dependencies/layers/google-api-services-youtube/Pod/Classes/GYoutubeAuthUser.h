//
//  Search.h
//  IOSTemplate
//
//  Created by djzhang on 9/25/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GTLYouTubeChannel;


@interface GYoutubeAuthUser : NSObject {

}

@property(nonatomic, strong) GTLYouTubeChannel * channel;

@property(nonatomic, strong) NSArray * subscriptions;

- (NSArray *)getTableRows;
@end
