//
//  SubscriptionsViewController.m
//  TubeIPadApp
//
//  Created by djzhang on 10/23/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//


#import "SubscriptionsViewController.h"


#import "VideoDetailViewControlleriPad.h"

#import "LeftRevealHelper.h"
#import "LeftMenuItemTree.h"

//#import "YoutubeGridLayoutViewController.h"
#import "YoutubeChannelPageViewController.h"
#import "YoutubeGridLayoutViewController.h"


@interface SubscriptionsViewController ()

//@property(nonatomic, strong) YoutubeGridLayoutViewController * youtubeGridLayoutViewController;

@property(nonatomic, strong) YoutubeChannelPageViewController * youtubeChannelPageViewController;

@property(nonatomic, strong) UIViewController * rootViewController;

@end


@implementation SubscriptionsViewController

- (void)viewDidLoad {
   [super viewDidLoad];
   // 1
   // Do any additional setup after loading the view, typically from a nib.
   self.tabBarItem.title = @"Subscriptions";
   self.view.backgroundColor = [UIColor clearColor];

   [self setupRootController];

//   [self changeRootView];// test
}


- (void)setupRootController {
   self.rootViewController = [[UIViewController alloc] init];
   self.rootViewController.view.frame = self.view.bounds;
   self.rootViewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

   [self pushViewController:self.rootViewController animated:NO];
}


- (void)setupRootController123 {
// 2
   self.youtubeChannelPageViewController = [[YoutubeChannelPageViewController alloc] init];
   self.youtubeChannelPageViewController.title = @"Subscriptions";
//   self.youtubeChannelPageViewController.delegate = self;
//   self.youtubeChannelPageViewController.numbersPerLineArray = [NSArray arrayWithObjects:@"3", @"4", nil];

   // 2.1
   self.youtubeChannelPageViewController.navigationItem.leftBarButtonItem = self.revealButtonItem;

   //3
   [self pushViewController:self.youtubeChannelPageViewController animated:YES];
}

//- (void)setupRootController {
//// 2
//   self.youtubeGridLayoutViewController = [[YoutubeGridLayoutViewController alloc] init];
//   self.youtubeGridLayoutViewController.title = @"Subscriptions";
//   self.youtubeGridLayoutViewController.delegate = self;
//   self.youtubeGridLayoutViewController.numbersPerLineArray = [NSArray arrayWithObjects:@"3", @"4", nil];
//
//   // 2.1
//   self.youtubeGridLayoutViewController.navigationItem.leftBarButtonItem = self.revealButtonItem;
//
//   //3
//   [self pushViewController:self.youtubeGridLayoutViewController animated:YES];
//}


- (void)didReceiveMemoryWarning {
   [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
}


- (void)viewDidAppear:(BOOL)animated {
   [super viewDidAppear:animated];

}


#pragma mark -
#pragma mark  IpadGridViewCellDelegate


- (void)gridViewCellTap:(YTYouTubeVideo *)video sender:(id)sender {
   [[LeftRevealHelper sharedLeftRevealHelper] closeLeftMenuAndNoRearOpen];

   VideoDetailViewControlleriPad * controller = [[VideoDetailViewControlleriPad alloc] initWithDelegate:self
                                                                                                  video:video];
   [self.navigationItem setBackBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"back"
                                                                              style:UIBarButtonItemStyleBordered
                                                                             target:nil
                                                                             action:nil]];
   [self pushViewController:controller animated:YES];
}


#pragma mark -
#pragma mark Left menu events


- (void)startToggleLeftMenuWithTitle:(NSString *)title {
   UIViewController * controller = [self changeRootView:title];

   controller.title = title;
//   [self.youtubeGridLayoutViewController cleanupAndStartPullToRefreshWithItemType:YTSegmentItemVideo];
}


- (void)endToggleLeftMenuEventWithResponse:(NSArray *)array withModel:(LeftMenuItemTree *)menuItemTree withTitle:(NSString *)title {
//   [self.youtubeGridLayoutViewController endPullToRefreshWithResponse:array];
}


- (void)endToggleLeftMenuEventForChannelPageWithSubscription:(YTYouTubeSubscription *)subscription {
   // 1
   YoutubeChannelPageViewController * controller = [[YoutubeChannelPageViewController alloc] initWithChannelId:subscription.snippet.resourceId.channelId];

   // 2
   self.viewControllers = [NSArray arrayWithObject:controller];
}


#pragma mark -
#pragma mark Change root view


- (YoutubeChannelPageViewController *)changeRootView:(NSString *)title {
   if (title.length > 7) {
      YoutubeGridLayoutViewController * controller = [[YoutubeGridLayoutViewController alloc] init];
      controller.numbersPerLineArray = [NSArray arrayWithObjects:@"3", @"4", nil];
      self.viewControllers = [NSArray arrayWithObject:controller];

      return controller;
   } else {
      YoutubeChannelPageViewController * controller = [[YoutubeChannelPageViewController alloc] init];
      self.viewControllers = [NSArray arrayWithObject:controller];

      return controller;
   }
}


@end
