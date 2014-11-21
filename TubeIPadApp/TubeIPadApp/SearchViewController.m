//
//  SearchViewController.m
//  TubeIPadApp
//
//  Created by djzhang on 10/23/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//



#import "SearchViewController.h"

#import "VideoDetailViewControlleriPad.h"
#import "GYoutubeRequestInfo.h"


@interface SearchViewController ()<IpadGridViewCellDelegate, UISearchBarDelegate, YoutubeCollectionNextPageDelegate>
@property(strong, nonatomic) UISegmentedControl * segment_title;
@property(nonatomic, strong) UISearchBar * searchBar;
@property(strong, nonatomic) NSMutableArray * ParsingArray;// Put that in .h file or after @interface in your .m file

@end


@implementation SearchViewController


- (void)viewDidLoad {
   [super viewDidLoad];
   // Do any additional setup after loading the view, typically from a nib.
   self.view.backgroundColor = [UIColor clearColor];

   self.delegate = self;
   self.nextPageDelegate = self;
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

   [self search:@"sketch 3" withItemType:YTSegmentItemVideo];// test
//   [self searchByPageToken];// test

   searchBar.delegate = self;

   self.searchBar = searchBar;
   self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:searchBar];
}


- (void)setupNavigationTitle {
   self.segment_title = [[UISegmentedControl alloc] initWithItems:[GYoutubeRequestInfo getSegmentTitlesArray]];
   self.segment_title.selectedSegmentIndex = 0;
   self.segment_title.autoresizingMask = UIViewAutoresizingFlexibleWidth;
   self.segment_title.frame = CGRectMake(0, 0, 300, 30);
   [self.segment_title addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
   self.segment_title.tintColor = [UIColor redColor];
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
   [self segmentAction:nil];
   [searchBar resignFirstResponder];
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
   [self autocompleteSegesstions:self.searchBar.text];
}


#pragma mark -
#pragma mark -  UISegmentedControl event


- (void)segmentAction:(id)sender {
   if (self.searchBar.text.length == 0)
      return;

   YTSegmentItemType itemType = [GYoutubeRequestInfo getItemTypeByIndex:self.segment_title.selectedSegmentIndex];
   [self search:self.searchBar.text withItemType:itemType];
}


#pragma mark -
#pragma mark YoutubeCollectionNextPageDelegate


- (void)executeRefreshTask {
   [self segmentAction:nil];
}


- (void)executeNextPageTask {
   [self searchByPageToken];
}


#pragma mark -
#pragma mark google autocomplete search suggest


- (void)autocompleteSegesstions:(NSString *)searchWish {
   searchWish = @"call";
   //searchWish is the text from your search bar (self.searchBar.text)
   NSString * jsonString = [NSString stringWithFormat:@"http://suggestqueries.google.com/complete/search?client=youtube&ds=yt&alt=json&q=%@",
                                                      searchWish];
   NSString * URLString = [jsonString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]; // Encoding to identify where, for example, there are spaces in your query.

   NSLog(@"%@", URLString);

   NSData * allVideosData = [[NSData alloc] initWithContentsOfURL:[[NSURL alloc] initWithString:URLString]];

   NSString * str = [[NSString alloc] initWithData:allVideosData encoding:NSUTF8StringEncoding];
   NSLog(@"%@", str); //Now you have NSString contain JSON.

   NSString * json = nil;
   NSScanner * scanner = [NSScanner scannerWithString:str];
   [scanner scanUpToString:@"[[" intoString:NULL]; // Scan to where the JSON begins
   [scanner scanUpToString:@"]]" intoString:&json];
   //The idea is to identify where the "real" JSON begins and ends.
   json = [NSString stringWithFormat:@"%@%@", json, @"]]"];
   NSLog(@"json = %@", json);

   NSArray * jsonObject = [NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding] //Push all the JSON autocomplete detail in to jsonObject array.
                                                          options:0 error:NULL];
   self.ParsingArray = [[NSMutableArray alloc] init]; //array that contains the objects.
   for (int i = 0; i != [jsonObject count]; i++) {
      for (int j = 0; j != 1; j++) {
         NSLog(@"%@", [[jsonObject objectAtIndex:i] objectAtIndex:j]);
         [self.ParsingArray addObject:[[jsonObject objectAtIndex:i] objectAtIndex:j]];
         //Parse the JSON here...
      }
   }


}

@end