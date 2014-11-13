//
//  YoutubeChannelPageViewController.m
//  IOSTemplate
//
//  Created by djzhang on 11/12/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import "YoutubeChannelPageViewController.h"
#import "YoutubeChannelTopCell.h"
#import "UIView+Shadow.h"


@interface YoutubeChannelPageViewController ()
@property(nonatomic, strong) UIView * topBanner;
@end


@implementation YoutubeChannelPageViewController

- (void)viewDidLoad {
   [super viewDidLoad];
   // Do any additional setup after loading the view from its nib.
   self.topBanner = [self getTopBanner];
   [self.view addSubview:self.topBanner];
}


- (UIView *)getTopBanner {
   CGRect statusRect = [[UIApplication sharedApplication] statusBarFrame];
   CGFloat statusbarHeight = statusRect.size.height;
   CGFloat navbarHeight = 46;

   YoutubeChannelTopCell * topView = [[YoutubeChannelTopCell alloc] init];

   CGRect rect = self.view.bounds;
   rect.origin.y = statusbarHeight + navbarHeight;
   rect.size.height = topView.frame.size.height;
   topView.frame = rect;

   topView.autoresizingMask = UIViewAutoresizingFlexibleWidth;


   return topView;
}


- (void)didReceiveMemoryWarning {
   [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
}


@end
