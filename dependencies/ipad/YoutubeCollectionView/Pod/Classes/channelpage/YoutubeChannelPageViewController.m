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
#import "GYoutubeRequestInfo.h"


@interface YoutubeChannelPageViewController ()

@property(strong, nonatomic) IBOutlet UIView * topBannerContainer;
@property(strong, nonatomic) IBOutlet UIView * tabbarViewsContainer;


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
   [self makeTopBanner:self.topBannerContainer];

   // 2
   [self makeSegmentTabs:self.tabbarViewsContainer];


   if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
      self.edgesForExtendedLayout = UIRectEdgeNone;
      self.automaticallyAdjustsScrollViewInsets = NO;
   }
}


- (void)makeSegmentTabs:(UIView *)parentView {
   WHTopTabBarController * tabBarController = [[WHTopTabBarController alloc] init];
   tabBarController.view.frame = parentView.bounds;
   tabBarController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

   NSMutableArray * tabControllersArray = [[NSMutableArray alloc] init];
   for (NSString * title in [GYoutubeRequestInfo getChannelPageSegmentTitlesArray]) {
      YoutubeGridLayoutViewController * controller = [[YoutubeGridLayoutViewController alloc] init];
      controller.title = title;
      controller.numbersPerLineArray = [NSArray arrayWithObjects:@"3", @"2", nil];
      [tabControllersArray addObject:controller];
   }

   tabBarController.viewControllers = tabControllersArray;

   self.videoTabBarController = tabBarController;
   [parentView addSubview:self.videoTabBarController.view];
}


- (void)makeTopBanner:(UIView *)parentView {
   YoutubeChannelTopCell * topView = [[YoutubeChannelTopCell alloc] init];
   topView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

   self.topBanner = topView;
   [parentView addSubview:self.topBanner];
}


- (void)didReceiveMemoryWarning {
   [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
}


@end
