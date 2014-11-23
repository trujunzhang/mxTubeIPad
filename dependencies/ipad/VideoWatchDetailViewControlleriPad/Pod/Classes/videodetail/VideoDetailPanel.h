//
//  VideoDetailPanel.h
//  YoutubeDetailRotateTabbarsApp
//
//  Created by djzhang on 10/9/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <google-api-services-youtube/YoutubeConstants.h>


@interface VideoDetailPanel : UIView

@property(nonatomic, strong) YTYouTubeVideo * video;
- (instancetype)initWithVideo:(YTYouTubeVideo *)video;


@end
