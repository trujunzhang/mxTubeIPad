//
//  IpadGridViewInfoCell.m
//  IOSTemplate
//
//  Created by djzhang on 10/23/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import "IpadGridViewInfoCell.h"
#import "GTLYouTubeVideo.h"
#import "GTLYouTubeVideoSnippet.h"
#import "GTLYouTubeVideoStatistics.h"


@implementation IpadGridViewInfoCell


- (void)bind:(GTLYouTubeVideo *)video {
   // 2
   [self.titleLaebl setText:video.snippet.title];
   // 3
   [self.ratingLabel setText:[NSString stringWithFormat:@"%@", video.statistics.likeCount]];
   [self.viewCountLabel setText:[NSString stringWithFormat:@"%@", video.statistics.viewCount]];
}


@end
