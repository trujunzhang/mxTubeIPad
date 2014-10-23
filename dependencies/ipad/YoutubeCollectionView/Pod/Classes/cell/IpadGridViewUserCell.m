//
//  IpadGridViewUserCell.m
//  IOSTemplate
//
//  Created by djzhang on 10/23/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import "IpadGridViewUserCell.h"
#import "GTLYouTubeVideo.h"
#import "GTLYouTubeVideoSnippet.h"


@implementation IpadGridViewUserCell


- (void)bind:(GTLYouTubeVideo *)video {
   // 4
   [self.userNameLabel setText:video.snippet.channelTitle];
}
@end
