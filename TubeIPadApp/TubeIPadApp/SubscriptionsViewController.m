//
//  SubscriptionsViewController.m
//  TubeIPadApp
//
//  Created by djzhang on 10/23/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import "SubscriptionsViewController.h"
#import "YoutubeGridLayoutViewController.h"


@interface SubscriptionsViewController ()

@end


@implementation SubscriptionsViewController

- (void)viewDidLoad {
   [super viewDidLoad];
   // Do any additional setup after loading the view, typically from a nib.
   self.title = @"Subscriptions";
   self.view.backgroundColor = [UIColor clearColor];

   NSArray * numbersPerLineArray = [NSArray arrayWithObjects:@"3", @"4", nil];

   self.youtubeGridLayoutViewController = [[YoutubeGridLayoutViewController alloc] init];
   self.youtubeGridLayoutViewController.numbersPerLineArray = numbersPerLineArray;

   UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 26, 19)];
   [btn addTarget:self action:@selector(popMenu:) forControlEvents:UIControlEventTouchUpInside];
   [btn setImage:[UIImage imageNamed:@"mt_side_tab_button"] forState:UIControlStateNormal];

   UIBarButtonItem * btnSearch = [[UIBarButtonItem alloc] initWithCustomView:btn];
   self.youtubeGridLayoutViewController.navigationItem.leftBarButtonItem = btnSearch;

   [self pushViewController:self.youtubeGridLayoutViewController animated:YES];
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


@end
