//
//  YoutubeChannelPageViewController.m
//  IOSTemplate
//
//  Created by djzhang on 11/12/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import <YoutubeCollectionView/YoutubeGridLayoutViewController.h>
#import "YoutubeChannelPageViewController.h"
#import "YoutubeChannelTopCell.h"
#import "WHTopTabBarController.h"


@interface YoutubeChannelPageViewController ()
@property(nonatomic, strong) UIView * topBanner;
@property(nonatomic, strong) WHTopTabBarController * videoTabBarController;
@property(nonatomic, strong) NSArray * defaultTableControllers;

@property(nonatomic, strong) YoutubeGridLayoutViewController * firstViewController;
@property(nonatomic, strong) YoutubeGridLayoutViewController * secondViewController;
@property(nonatomic, strong) YoutubeGridLayoutViewController * thirdViewController;

@end


@implementation YoutubeChannelPageViewController

- (void)viewDidLoad {
   [super viewDidLoad];

   // Do any additional setup after loading the view from its nib.
   // 1 
   CGFloat topBannerBottomPoint = [self makeTopBanner];

   // 2
   [self makeSegmentTabs:topBannerBottomPoint];
}


- (void)makeSegmentTabs:(CGFloat)point {
   self.videoTabBarController = [[WHTopTabBarController alloc] init];
   self.videoTabBarController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

   CGRect rect = CGRectMake(0, point, 0, 0);
   self.videoTabBarController.view.frame = rect;

   // 1
   self.firstViewController = [[YoutubeGridLayoutViewController alloc] init];
   self.firstViewController.title = @"First";
   self.firstViewController.numbersPerLineArray = [NSArray arrayWithObjects:@"3", @"2", nil];

   // 2
   self.secondViewController = [[YoutubeGridLayoutViewController alloc] init];
   self.secondViewController.title = @"Second";
   self.secondViewController.numbersPerLineArray = [NSArray arrayWithObjects:@"3", @"2", nil];

   // 3
   self.thirdViewController = [[YoutubeGridLayoutViewController alloc] init];
   self.thirdViewController.title = @"Third";
   self.thirdViewController.numbersPerLineArray = [NSArray arrayWithObjects:@"3", @"2", nil];

   self.defaultTableControllers = [NSArray arrayWithObjects:
    self.firstViewController,
    self.secondViewController,
    self.thirdViewController,
     nil];

   self.videoTabBarController.viewControllers = self.defaultTableControllers;

   [self.view addSubview:self.videoTabBarController.view];
}


- (CGFloat)makeTopBanner {
   CGRect statusRect = [[UIApplication sharedApplication] statusBarFrame];
   CGFloat statusbarHeight = statusRect.size.height;
   CGFloat navbarHeight = 46;

   YoutubeChannelTopCell * topView = [[YoutubeChannelTopCell alloc] init];

   CGRect rect = self.view.bounds;
   rect.origin.y = statusbarHeight + navbarHeight;
   rect.size.height = topView.frame.size.height;
   topView.frame = rect;

   topView.autoresizingMask = UIViewAutoresizingFlexibleWidth;

   self.topBanner = topView;
   [self.view addSubview:self.topBanner];

   return rect.origin.y + rect.size.height;
}


- (void)didReceiveMemoryWarning {
   [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
}


@end
