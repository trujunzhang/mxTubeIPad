//
//  YoutubeChannelPageViewController.m
//  IOSTemplate
//
//  Created by djzhang on 11/12/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import "YoutubeChannelPageViewController.h"
#import "YoutubeChannelTopCell.h"


@interface YoutubeChannelPageViewController ()

@end


@implementation YoutubeChannelPageViewController

- (void)viewDidLoad {
   [super viewDidLoad];
   // Do any additional setup after loading the view from its nib.
   UIView * topBanner = [self getTopBanner];
   [self.view addSubview:topBanner];
}


- (UIView *)getTopBanner {
   CGRect statusRect = [[UIApplication sharedApplication] statusBarFrame];
   CGFloat statusbarHeight = statusRect.size.height;
   CGFloat navbarHeight = 46;

   NSArray * array = [[NSBundle mainBundle] loadNibNamed:@"YoutubeChannelTopCell"
                                                   owner:nil
                                                 options:nil];
   YoutubeChannelTopCell * topBanner = [array lastObject];
   CGRect rect = self.view.bounds;
   rect.origin.y = statusbarHeight + navbarHeight;
   rect.size.height = topBanner.frame.size.height;
   topBanner.frame = rect;

   topBanner.autoresizingMask = UIViewAutoresizingFlexibleWidth;

   return topBanner;
}


- (void)didReceiveMemoryWarning {
   [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
}


@end
