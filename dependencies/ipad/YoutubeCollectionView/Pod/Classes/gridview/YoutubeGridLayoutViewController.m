//
//  YoutubeGridLayoutViewController.m
//  YoutubePlayApp
//
//  Created by djzhang on 10/15/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import <google-api-services-youtube/GYoutubeHelper.h>
#import "YoutubeGridLayoutViewController.h"
#import "GYoutubeSearchInfo.h"

//NSString * lastSearch = @"call of duty advanced warfare";
NSString * lastSearch = @"sketch 3";
//NSString * lastSearch = nil;


@interface YoutubeGridLayoutViewController ()
@property(nonatomic, strong) GYoutubeSearchInfo * searchInfo;
@property(nonatomic, strong) UIRefreshControl * refreshControl;
@end


@implementation YoutubeGridLayoutViewController

- (void)viewDidLoad {
   [super viewDidLoad];

   [self setupRefresh];

   [self search:@"sketch 3"];
}


- (void)setupRefresh {
   self.refreshControl = [[UIRefreshControl alloc] init];
   self.refreshControl.tintColor = [UIColor redColor];
   [self.refreshControl addTarget:self
                           action:@selector(refreshControlAction)
                 forControlEvents:UIControlEventValueChanged];

   [self.collectionView addSubview:self.refreshControl];
}


- (void)refreshControlAction {
   // Enter your code for request you are creating here when you pull the collectionView. When the request is completed then the collectionView go to its original position.
   [self performSelector:@selector(refreshPerform) withObject:(self) afterDelay:(4.0)];
}


- (void)refreshPerform {
   [self.refreshControl endRefreshing];
}


- (void)didReceiveMemoryWarning {
   [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark Search events


- (void)search:(NSString *)text {
   [self search:text withQueryType:@"video"];
}


- (void)search:(NSString *)text withQueryType:(NSString *)queryType {
   [self cleanup];

   self.searchInfo = [[GYoutubeSearchInfo alloc] initWithQueryType:@"video" withTeam:text];

   lastSearch = text;

   [self searchByPageToken];
}


- (void)searchByPageToken {
   YoutubeResponseBlock completion = ^(NSArray * array) {
       [self.refreshControl endRefreshing];

       NSLog(@"leng = %d", array.count);
       [self.videoList addObjectsFromArray:array];
       self.hasLoadingMore = YES;
       [[self collectionView] reloadData];
   };
   ErrorResponseBlock error = ^(NSError * error) {
   };
   [[GYoutubeHelper getInstance] searchByQueryWithSearchInfo:self.searchInfo
                                           completionHandler:completion
                                                errorHandler:error];
}


- (void)cleanup {
   self.videoList = [[NSMutableArray alloc] init];
   self.hasLoadingMore = NO;
   [[self collectionView] reloadData];
}
@end
