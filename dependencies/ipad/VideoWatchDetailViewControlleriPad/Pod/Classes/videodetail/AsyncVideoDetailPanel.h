//
//  AsyncVideoDetailPanel.h
//  YoutubePlayApp
//
//  Created by djzhang on 10/14/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncDisplayKit.h"
@class YoutubeVideoCache;


@interface AsyncVideoDetailPanel : ASDisplayNode

@property(nonatomic) CGRect detailViewPanelFrame;

- (instancetype)initWithVideo:(YoutubeVideoCache *)videoCache;
- (void)setCurrentFrame:(CGRect)rect;
@end
