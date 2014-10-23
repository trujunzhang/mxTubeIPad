//
//  SearchViewController.m
//  TubeIPadApp
//
//  Created by djzhang on 10/23/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import "SearchViewController.h"
#import "YoutubeGridLayoutViewController.h"
#import "VideoDetailViewControlleriPad.h"


@interface SearchViewController ()

@end


@implementation SearchViewController


- (void)viewDidLoad {
   [super viewDidLoad];
   // Do any additional setup after loading the view, typically from a nib.
   self.tabBarItem.title = @"Subscriptions";
   self.view.backgroundColor = [UIColor clearColor];

   self.youtubeGridLayoutViewController = [[YoutubeGridLayoutViewController alloc] init];
   self.youtubeGridLayoutViewController.title = @"Subscriptions";
   self.youtubeGridLayoutViewController.delegate = self;
   self.youtubeGridLayoutViewController.numbersPerLineArray = [NSArray arrayWithObjects:@"3", @"4", nil];

   UISearchBar * searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 180, 19)];
   searchBar.backgroundColor = [UIColor clearColor];
   searchBar.delegate = self;

   UIBarButtonItem * btnSearch = [[UIBarButtonItem alloc] initWithCustomView:searchBar];
   self.youtubeGridLayoutViewController.navigationItem.rightBarButtonItem = btnSearch;

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


#pragma mark -
#pragma mark - UISearchBarDelegate


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
//   NSLog(@" search123: %@", searchBar.text);
   [self.youtubeGridLayoutViewController search:searchBar.text];
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
   NSLog(@" cancel: %@", searchBar.text);
}


@end