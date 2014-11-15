//
//  YoutubeParser.h
//  IOSTemplate
//
//  Created by djzhang on 11/15/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YoutubeConstants.h"


@interface YoutubeParser : NSObject

+ (NSString *)getVideoIdsByActivityList:searchResultList;

+ (NSString *)getVideoIdsBySearchResult:(id)searchResultList;
+ (NSString *)getChannelId:(YTYouTubeSubscription *)subscription;
@end
