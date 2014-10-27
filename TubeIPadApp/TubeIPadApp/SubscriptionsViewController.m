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


@interface SubscriptionsViewController ()

@end


@implementation SubscriptionsViewController

- (void)viewDidLoad {
   [super viewDidLoad];
   // Do any additional setup after loading the view, typically from a nib.
   self.tabBarItem.title = @"Subscriptions";
   self.view.backgroundColor = [UIColor clearColor];

   self.youtubeGridLayoutViewController = [[YoutubeGridLayoutViewController alloc] init];
   self.youtubeGridLayoutViewController.title = @"Subscriptions";
   self.youtubeGridLayoutViewController.delegate = self;
   self.youtubeGridLayoutViewController.numbersPerLineArray = [NSArray arrayWithObjects:@"3", @"4", nil];

   UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 26, 19)];
   [btn addTarget:self action:@selector(popMenu:) forControlEvents:UIControlEventTouchUpInside];
   [btn setImage:[UIImage imageNamed:@"mt_side_tab_button"] forState:UIControlStateNormal];

   UIBarButtonItem * btnSearch = [[UIBarButtonItem alloc] initWithCustomView:btn];
   self.youtubeGridLayoutViewController.navigationItem.leftBarButtonItem = btnSearch;

   [self pushViewController:self.youtubeGridLayoutViewController animated:YES];
}


- (void)popMenu:(id)popMenu {

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
