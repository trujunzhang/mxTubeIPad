//
//  YoutubeChannelPageViewController.m
//  IOSTemplate
//
//  Created by djzhang on 11/12/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import "YoutubeChannelPageViewController.h"
#import "YoutubeChannelTopCell.h"
#import "WHTopTabBarController.h"
#import "YoutubeParser.h"


@interface YoutubeChannelPageViewController ()<JBTopTabBarControllerDelegate, YoutubeCollectionNextPageDelegate>

@property(strong, nonatomic) IBOutlet UIView * topBannerContainer;
@property(strong, nonatomic) IBOutlet UIView * tabbarViewsContainer;

@property(nonatomic, strong) YTYouTubeSubscription * subscription;

@property(nonatomic, strong) YoutubeChannelTopCell * topBanner;
@property(nonatomic, strong) WHTopTabBarController * videoTabBarController;

@property(nonatomic, strong) NSMutableArray * defaultTableControllers;

@property(nonatomic) YTSegmentItemType selectedSegmentItemType;
@property(nonatomic, strong) YTCollectionViewController * selectedController;

@property(nonatomic, strong) YTCollectionViewController * firstViewController;
@property(nonatomic, strong) YTCollectionViewController * secondViewController;
@property(nonatomic, strong) YTCollectionViewController * thirdViewController;

@end


@implementation YoutubeChannelPageViewController

- (instancetype)initWithSubscription:(YTYouTubeSubscription *)subscription {
   self = [super init];
   if (self) {
      self.subscription = subscription;
   }

   return self;
}


- (void)viewDidLoad {
   [super viewDidLoad];

   // Do any additional setup after loading the view from its nib.
   // 1
   [self makeTopBanner:self.topBannerContainer];

   // 2
   [self makeSegmentTabs:self.tabbarViewsContainer];

   // 3
   [self fetchListWithController:self.defaultTableControllers[0] withType:YTSegmentItemVideo];

   if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
      self.edgesForExtendedLayout = UIRectEdgeNone;
      self.automaticallyAdjustsScrollViewInsets = NO;
   }
}


- (void)makeSegmentTabs:(UIView *)parentView {
   WHTopTabBarController * tabBarController = [[WHTopTabBarController alloc] init];
   tabBarController.view.frame = parentView.bounds;
   tabBarController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

   self.defaultTableControllers = [[NSMutableArray alloc] init];
   for (NSString * title in [GYoutubeRequestInfo getChannelPageSegmentTitlesArray]) {
      YTCollectionViewController * controller = [[YTCollectionViewController alloc] init];
      controller.delegate = self.delegate;
      controller.nextPageDelegate = self;
      controller.title = title;
      controller.numbersPerLineArray = [NSArray arrayWithObjects:@"3", @"4", nil];
      [self.defaultTableControllers addObject:controller];
   }

   tabBarController.viewControllers = self.defaultTableControllers;
   tabBarController.delegate = self;

   self.videoTabBarController = tabBarController;
   [parentView addSubview:self.videoTabBarController.view];
}


- (void)makeTopBanner:(UIView *)parentView {
   self.topBanner = [[YoutubeChannelTopCell alloc] initWithSubscription:self.subscription];
   self.topBanner.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

   [parentView addSubview:self.topBanner];
}


- (void)didReceiveMemoryWarning {
   [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark JBTopTabBarControllerDelegate


- (void)tabBarController:(WHTopTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
   NSUInteger integer = tabBarController.selectedIndex;
   NSString * debug = @"debug";
   [self fetchListWithController:viewController withType:integer];
}


- (void)fetchListWithController:(YTCollectionViewController *)controller withType:(YTSegmentItemType)type {
   self.selectedController = controller;
   self.selectedSegmentItemType = type;

   [self executeRefreshTask];
}


#pragma mark -
#pragma mark YoutubeCollectionNextPageDelegate


- (void)executeRefreshTask {
   switch (self.selectedSegmentItemType) {
      case YTSegmentItemVideo:
         [self.selectedController fetchActivityListByType:self.selectedSegmentItemType
                                            withChannelId:[YoutubeParser getChannelId:self.subscription]];
         break;
      case YTSegmentItemChannel:
         [self.selectedController fetchVideoListFromChannelWithChannelId:[YoutubeParser getChannelId:self.subscription]];
         break;
      case YTSegmentItemPlaylist:
         [self.selectedController fetchPlayListFromChannelWithChannelId:[YoutubeParser getChannelId:self.subscription]];
         break;
   }
}


- (void)executeNextPageTask {
   switch (self.selectedSegmentItemType) {
      case YTSegmentItemVideo:
         [self.selectedController fetchActivityListByPageToken];
         break;
      case YTSegmentItemChannel:
         [self.selectedController fetchVideoListFromChannelByPageToken];
         break;
      case YTSegmentItemPlaylist:
         [self.selectedController fetchPlayListFromChannelByPageToken];
         break;
   }
}


@end
