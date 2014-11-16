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
//NSString * lastSearch = @"sketch 3";
//NSString * lastSearch = nil;


@interface YoutubeCollectionViewBase ()

@property(nonatomic, strong) UIRefreshControl * refreshControl;
@end


@implementation YoutubeCollectionViewBase
- (instancetype)init {
   self = [super init];
   if (self) {
      self.youtubeRequestInfo = [[GYoutubeRequestInfo alloc] init];
   }

   return self;
}


- (void)viewDidLoad {
   [super viewDidLoad];

   // Do any additional setup after loading the view.
   self.view.backgroundColor = [UIColor clearColor];

   [self setupRefresh];
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
   [self cleanup];
   [self.nextPageDelegate executeRefreshTask];
   [self.refreshControl endRefreshing];
}


- (void)didReceiveMemoryWarning {
   [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark Search events


- (void)search:(NSString *)text withItemType:(YTSegmentItemType)itemType {
   [self cleanup];

   [self.youtubeRequestInfo resetRequestInfoForSearchWithItemType:itemType withQueryTeam:text];
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


- (void)refresh {
   [self.youtubeRequestInfo resetInfo];
   [[self collectionView] reloadData];
}


- (void)cleanup {
   [self.youtubeRequestInfo resetInfo];
   [[self collectionView] reloadData];
}


#pragma mark -
#pragma mark  Fetch Activity list by channelID


- (void)fetchActivityListByType:(enum YTSegmentItemType)itemType withChannelId:(NSString *)channelId {
//   channelId = @"UCl78QGX_hfK6zT8Mc-2w8GA";

   [self cleanup];

   [self.youtubeRequestInfo resetRequestInfo];
   self.youtubeRequestInfo.channelId = channelId;
}


- (void)fetchActivityListByPageToken {
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


#pragma mark -
#pragma mark  Fetch Activity list by channelID


- (void)fetchPlayListByType:(enum YTPlaylistItemsType)playlistItemsType {
   [self cleanup];

   [self.youtubeRequestInfo resetRequestInfoForPlayList:playlistItemsType];
}


- (void)fetchPlayListByPageToken {
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
   [[GYoutubeHelper getInstance] fetchPlaylistItemsListWithRequestInfo:self.youtubeRequestInfo
                                                            completion:completion
                                                          errorHandler:error
   ];
}


#pragma mark -
#pragma mark  Fetch suggestion list by videoID


- (void)fetchSuggestionListByVideoId:(NSString *)videoId {
//   videoId = @"mOQ5DzROpuo";
   [self cleanup];

   [self.youtubeRequestInfo resetRequestInfoForSuggestionList:videoId];
}


- (void)fetchSuggestionListByPageToken {
   [self searchByPageToken];
}
@end






