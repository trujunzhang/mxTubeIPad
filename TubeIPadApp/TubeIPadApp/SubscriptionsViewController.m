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


@interface SubscriptionsViewController ()<IpadGridViewCellDelegate, YoutubeCollectionNextPageDelegate>

@property(nonatomic, strong) YoutubeGridLayoutViewController * youtubeGridLayoutViewController;

@property(nonatomic, strong) YoutubeChannelPageViewController * youtubeChannelPageViewController;

@property(nonatomic, strong) UIViewController * rootViewController;

@property(nonatomic) enum YTPlaylistItemsType playlistItemsType;
@end


@implementation SubscriptionsViewController

- (void)viewDidLoad {
   [super viewDidLoad];
   // 1
   // Do any additional setup after loading the view, typically from a nib.
   self.tabBarItem.title = @"Subscriptions";
   self.view.backgroundColor = [UIColor clearColor];

//   [self setupRootController]; // test

//   [self changeRootView];// test
}


//- (void)setupRootController {
//   self.rootViewController = [[UIViewController alloc] init];
//   self.rootViewController.view.frame = self.view.bounds;
//   self.rootViewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//
//   [self pushViewController:self.rootViewController animated:NO];
//}


//- (void)setupRootController123 {
//// 2
//   self.youtubeChannelPageViewController = [[YoutubeChannelPageViewController alloc] init];
//   self.youtubeChannelPageViewController.title = @"Subscriptions";
////   self.youtubeChannelPageViewController.delegate = self;
////   self.youtubeChannelPageViewController.numbersPerLineArray = [NSArray arrayWithObjects:@"3", @"4", nil];
//
//   // 2.1
//   self.youtubeChannelPageViewController.navigationItem.leftBarButtonItem = self.revealButtonItem;
//
//   //3
//   [self pushViewController:self.youtubeChannelPageViewController animated:YES];
//}

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


- (void)startToggleLeftMenuWithTitle:(NSString *)title withType:(enum YTPlaylistItemsType)playlistItemsType {
   // 1
   self.youtubeGridLayoutViewController = [[YoutubeGridLayoutViewController alloc] init];
   self.youtubeGridLayoutViewController.title = title;
   self.youtubeGridLayoutViewController.delegate = self;
   self.youtubeGridLayoutViewController.nextPageDelegate = self;
   self.youtubeGridLayoutViewController.numbersPerLineArray = [NSArray arrayWithObjects:@"3", @"4", nil];

   // 2
   self.youtubeGridLayoutViewController.navigationItem.leftBarButtonItem = self.revealButtonItem;
   self.viewControllers = [NSArray arrayWithObject:self.youtubeGridLayoutViewController];

   // 3
   self.playlistItemsType = playlistItemsType;
   [self.youtubeGridLayoutViewController fetchPlayListByType:playlistItemsType];
}


- (void)endToggleLeftMenuEventForChannelPageWithSubscription:(GTLYouTubeSubscription *)subscription withTitle:(NSString *)title {
   // 1
   YoutubeChannelPageViewController * controller = [[YoutubeChannelPageViewController alloc] initWithSubscription:subscription];
   controller.navigationItem.leftBarButtonItem = self.revealButtonItem;
   controller.title = title;
   controller.delegate = self;

   // 2
   self.viewControllers = [NSArray arrayWithObject:controller];
}


#pragma mark -
#pragma mark YoutubeCollectionNextPageDelegate


- (void)executeRefreshTask {
   [self.youtubeGridLayoutViewController fetchPlayListByType:self.playlistItemsType];
}


- (void)executeNextPageTask {
   [self.youtubeGridLayoutViewController fetchPlayListByPageToken];
}


@end
