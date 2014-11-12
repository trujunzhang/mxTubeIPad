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
   NSArray * array = [[NSBundle mainBundle] loadNibNamed:@"YoutubeChannelTopCell"
                                                   owner:nil
                                                 options:nil];
   YoutubeChannelTopCell * topBanner = [array lastObject];

   topBanner.autoresizingMask = UIViewAutoresizingFlexibleWidth;

   return topBanner;
}


- (void)didReceiveMemoryWarning {
   [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
}


@end
