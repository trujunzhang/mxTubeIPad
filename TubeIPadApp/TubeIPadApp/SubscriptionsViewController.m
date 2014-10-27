//
//  SubscriptionsViewController.m
//  TubeIPadApp
//
//  Created by djzhang on 10/23/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import "SubscriptionsViewController.h"

#import <SWRevealViewController/SWRevealViewController.h>

#import "YoutubeGridLayoutViewController.h"
#import "VideoDetailViewControlleriPad.h"


@interface SubscriptionsViewController ()

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
   [self setupSlideMenuController:self.youtubeGridLayoutViewController];

   //3
   [self pushViewController:self.youtubeGridLayoutViewController animated:YES];
}


- (void)setupSlideMenuController:(UIViewController *)controller {
   SWRevealViewController * revealController = [controller revealViewController];

   [revealController panGestureRecognizer];
   [revealController tapGestureRecognizer];

   UIBarButtonItem * revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"mt_side_tab_button"]
                                                                         style:UIBarButtonItemStyleBordered
                                                                        target:revealController
                                                                        action:@selector(revealToggle:)];

   controller.navigationItem.leftBarButtonItem = revealButtonItem;
}


- (void)didReceiveMemoryWarning {
   [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
}


- (BOOL)shouldAutorotate {
   return YES;
}


- (NSUInteger)supportedInterfaceOrientations {
   return UIInterfaceOrientationMaskAll;
}


#pragma mark -
#pragma mark - IpadGridViewCellDelegate


- (void)gridViewCellTap:(GTLYouTubeVideo *)video sender:(id)sender {
   VideoDetailViewControlleriPad * controller = [[VideoDetailViewControlleriPad alloc] initWithDelegate:self
                                                                                                  video:video];
   [self.navigationItem setBackBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"back"
                                                                              style:UIBarButtonItemStyleBordered
                                                                             target:nil
                                                                             action:nil]];
   [self pushViewController:controller animated:YES];
}


@end
