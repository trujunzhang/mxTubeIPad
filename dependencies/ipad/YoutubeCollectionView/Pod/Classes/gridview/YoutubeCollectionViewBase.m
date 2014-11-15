//
//  YoutubeCollectionViewBase.m
//  YoutubePlayApp
//
//  Created by djzhang on 10/15/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import "YoutubeGridLayoutViewController.h"
#import "YoutubeCollectionViewBase.h"
#import <google-api-services-youtube/GYoutubeHelper.h>
#import "GYoutubeRequestInfo.h"

//NSString * lastSearch = @"call of duty advanced warfare";
NSString * lastSearch = @"sketch 3";
//NSString * lastSearch = nil;


@interface YoutubeCollectionViewBase ()

@property(nonatomic, strong) UIRefreshControl * refreshControl;
@end


@implementation YoutubeCollectionViewBase

- (void)viewDidLoad {
   [super viewDidLoad];

   // Do any additional setup after loading the view.
   self.view.backgroundColor = [UIColor clearColor];

   [self setupRefresh];

   self.youtubeRequestInfo = [[GYoutubeRequestInfo alloc] init];

//   [self search:@"sketch 3"];
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
   [self search:text withItemType:YTSegmentItemVideo];
}


- (void)search:(NSString *)text withItemType:(YTSegmentItemType)itemType {
   [self cleanup];

   [self.youtubeRequestInfo resetSearchWithItemType:itemType withQueryTeam:text];

   lastSearch = text;

   [self searchByPageToken];
}


- (void)searchByPageToken {
   if ([self.youtubeRequestInfo hasNextPage] == NO)
      return;


   YoutubeResponseBlock completion = ^(NSArray * array) {
       [self.refreshControl endRefreshing];

       [self.youtubeRequestInfo appendNextPageData:array];

       [[self collectionView] reloadData];
   };
   ErrorResponseBlock error = ^(NSError * error) {
   };
   [[GYoutubeHelper getInstance] searchByQueryWithRequestInfo:self.youtubeRequestInfo
                                            completionHandler:completion
                                                 errorHandler:error];
}


- (void)endPullToRefreshWithResponse:(NSArray *)array {
   [self.refreshControl endRefreshing];

   NSLog(@"leng = %d", array.count);
//   self.hasLoadingMore = YES;
   if (array.count == 0) {
//      self.hasLoadingMore = NO;
   } else {
//      [self.videoList addObjectsFromArray:array];
   }
   [[self collectionView] reloadData];
}


- (void)cleanup {
   [self.youtubeRequestInfo cleanup];

   [[self collectionView] reloadData];
}


- (void)cleanupAndStartPullToRefreshWithItemType:(YTSegmentItemType)itemType {
   [self cleanup];
   [self.refreshControl beginRefreshing];

//   self.youtubeRequestInfo = [[GYoutubeRequestInfo alloc] initWithSearchItemType:itemType withQueryTeam:@""];

}


#pragma mark -
#pragma mark


- (void)fetchListByType:(enum YTSegmentItemType)itemType withChannelId:(NSString *)channelId {
//   channelId = @"UCl78QGX_hfK6zT8Mc-2w8GA";

   [self cleanup];

   [self.youtubeRequestInfo resetSearchWithItemType:itemType];
   self.youtubeRequestInfo.channelId = channelId;

   [self fetchListByPageToken];
}


- (void)fetchListByPageToken {
   if ([self.youtubeRequestInfo hasNextPage] == NO)
      return;

   YoutubeResponseBlock completion = ^(NSArray * array) {
       [self.refreshControl endRefreshing];

       [self.youtubeRequestInfo appendNextPageData:array];

       [[self collectionView] reloadData];
   };
   ErrorResponseBlock error = ^(NSError * error) {
       NSString * debug = @"debug";
   };
   [[GYoutubeHelper getInstance] fetchActivityListWithRequestInfo:self.youtubeRequestInfo
                                                CompletionHandler:completion
                                                     errorHandler:error];
}
@end






