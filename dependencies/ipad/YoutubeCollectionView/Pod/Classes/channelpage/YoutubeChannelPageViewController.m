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

   NSArray * array = [[NSBundle mainBundle] loadNibNamed:@"YoutubeChannelTopCell"
                                                   owner:nil
                                                 options:nil];
   YoutubeChannelTopCell * topView = [array lastObject];
   CGRect rect = self.view.bounds;
   rect.origin.y = statusbarHeight + navbarHeight;
   rect.size.height = topView.frame.size.height;
   topView.frame = rect;

   topView.autoresizingMask = UIViewAutoresizingFlexibleWidth;

//   CALayer * iconlayer = topView.layer;
//   iconlayer.masksToBounds = NO;
//   iconlayer.cornerRadius = 8.0;
//   iconlayer.shadowOffset = CGSizeMake(-5.0, 5.0);
//   iconlayer.shadowRadius = 5.0;
//   iconlayer.shadowOpacity = 0.6;

   return topView;
}


- (void)viewDidAppear:(BOOL)animated {
   [super viewDidAppear:animated];


}


- (void)viewDidLayoutSubviews {
   [super viewDidLayoutSubviews];

   [self updateLayout:[UIApplication sharedApplication].statusBarOrientation];
}


- (void)updateLayout:(UIInterfaceOrientation)orientation {
//   [self.topBanner makeInsetShadowWithRadius:14.0
//                                       Color:[UIColor colorWithRed:100.0 green:0.0 blue:0.0 alpha:0.2]
//                                  Directions:[NSArray arrayWithObjects:@"bottom", nil]];


}


- (void)didReceiveMemoryWarning {
   [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
}


@end
