//
//  SubscriptionsViewController.m
//  TubeIPadApp
//
//  Created by djzhang on 10/23/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//


#import "SubscriptionsViewController.h"

#import "YoutubeGridLayoutViewController.h"
#import "VideoDetailViewControlleriPad.h"

#import "LeftRevealHelper.h"
#import "LeftMenuItemTree.h"


@interface SubscriptionsViewController ()

@property(nonatomic, strong) YoutubeGridLayoutViewController * youtubeGridLayoutViewController;

@end


@implementation SubscriptionsViewController

- (void)viewDidLoad {
   [super viewDidLoad];
   // 1
   // Do any additional setup after loading the view, typically from a nib.
   self.tabBarItem.title = @"Subscriptions";
   self.view.backgroundColor = [UIColor clearColor];

   // 2
   self.youtubeGridLayoutViewController = [[YoutubeGridLayoutViewController alloc] init];
   self.youtubeGridLayoutViewController.title = @"Subscriptions";
   self.youtubeGridLayoutViewController.delegate = self;
   self.youtubeGridLayoutViewController.numbersPerLineArray = [NSArray arrayWithObjects:@"3", @"4", nil];

   // 2.1
   self.youtubeGridLayoutViewController.navigationItem.leftBarButtonItem = self.revealButtonItem;

   //3
   [self pushViewController:self.youtubeGridLayoutViewController animated:YES];

}


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
   self.youtubeGridLayoutViewController.title = title;
   [self.youtubeGridLayoutViewController cleanupAndStartPullToRefreshWithItemType:YTSegmentItemVideo];
}


- (void)endToggleLeftMenuEventWithResponse:(NSArray *)array withModel:(LeftMenuItemTree *)menuItemTree withTitle:(NSString *)title {
   [self.youtubeGridLayoutViewController endPullToRefreshWithResponse:array];
}


@end
