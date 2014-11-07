//
//  SearchViewController.m
//  TubeIPadApp
//
//  Created by djzhang on 10/23/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//



#import "SearchViewController.h"

#import "IpadGridViewCell.h"
#import "VideoDetailViewControlleriPad.h"


@interface SearchViewController ()
@property(strong, nonatomic) UISegmentedControl * segment_title;
@property(nonatomic, strong) UISearchBar * searchBar;
@end


@implementation SearchViewController


- (void)viewDidLoad {
   [super viewDidLoad];
   // Do any additional setup after loading the view, typically from a nib.
   self.view.backgroundColor = [UIColor clearColor];

//   self.youtubeGridLayoutViewController = [[YoutubeGridLayoutViewController alloc] init];
   self.delegate = self;
   self.numbersPerLineArray = [NSArray arrayWithObjects:@"3", @"4", nil];

   [self setupNavigationRightItem];
   [self setupNavigationTitle];
}


- (void)setupNavigationRightItem {
   UISearchBar * searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 220, 19)];
   searchBar.backgroundColor = [UIColor clearColor];
   searchBar.showsCancelButton = YES;
   searchBar.userInteractionEnabled = YES;
   searchBar.placeholder = @"Search";
   searchBar.text = @"sketch 3";//test

   searchBar.delegate = self;

   self.searchBar = searchBar;
   self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:searchBar];
}


- (void)setupNavigationTitle {
   NSArray * segmentTextContent = [NSArray arrayWithObjects:
    @"Videos",
    @"Channels",
    @"Playlists",
     nil];
   self.segment_title = [[UISegmentedControl alloc] initWithItems:segmentTextContent];
   self.segment_title.selectedSegmentIndex = 0;
   self.segment_title.autoresizingMask = UIViewAutoresizingFlexibleWidth;
   self.segment_title.frame = CGRectMake(0, 0, 300, 30);
   [self.segment_title addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
   self.navigationItem.titleView = self.segment_title;
}


- (void)didReceiveMemoryWarning {
   [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark - IpadGridViewCellDelegate


- (void)gridViewCellTap:(YTYouTubeVideo *)video sender:(id)sender {
   VideoDetailViewControlleriPad * controller = [[VideoDetailViewControlleriPad alloc] initWithDelegate:self
                                                                                                  video:video];

   [self.navigationController pushViewController:controller animated:YES];
}


#pragma mark -
#pragma mark - UISearchBarDelegate


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
   [self search:searchBar.text];
   [searchBar resignFirstResponder];
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
   if (searchText.length == 0) {
      [self cleanup];
   }

}


#pragma mark -
#pragma mark -  UISegmentedControl event


- (void)segmentAction:(id)sender {
   if (self.searchBar.text.length == 0)
      return;

   [self search:self.searchBar.text withQueryType:[NSArray arrayWithObjects:@"video",
                                                                            @"channel",
                                                                            @"playlist", nil][self.segment_title.selectedSegmentIndex]];
}


@end