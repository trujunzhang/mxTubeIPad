//
//  VideoDetailViewController.h
//  YoutubePlayApp
//
//  Created by djzhang on 10/14/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VideoDetailPanel;
@class AsyncVideoDetailPanel;


//#define CURRENT_VIDEODETAIL_PANEL VideoDetailPanel
#define CURRENT_VIDEODETAIL_PANEL AsyncVideoDetailPanel


@interface VideoDetailViewController : UIViewController

@property(nonatomic, strong) UIScrollView * videoDetailScrollView;
@end
