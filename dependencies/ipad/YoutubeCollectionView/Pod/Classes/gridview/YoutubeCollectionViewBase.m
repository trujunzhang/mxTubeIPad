//
//  YoutubeCollectionViewBase.m
//  YoutubePlayApp
//
//  Created by djzhang on 10/15/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//




#import "YoutubeCollectionViewBase.h"
#import "GYoutubeRequestInfo.h"
#import "GYoutubeHelper.h"


@interface YoutubeCollectionViewBase ()

@property(nonatomic, strong) UIRefreshControl * refreshControl;
@property(strong, nonatomic) UICollectionView * baseCollectionView;

@property(nonatomic, strong) NSMutableDictionary * cellSizeDictionary;

@end


@implementation YoutubeCollectionViewBase


- (GYoutubeRequestInfo *)getYoutubeRequestInfo {
   if (self.youtubeRequestInfo == nil) {
      self.youtubeRequestInfo = [[GYoutubeRequestInfo alloc] init];
   }
   return self.youtubeRequestInfo;
}


- (void)viewDidLoad {
   [super viewDidLoad];

   // Do any additional setup after loading the view.
   self.view.backgroundColor = [UIColor clearColor];

   self.cellSizeDictionary = [[NSMutableDictionary alloc] init];

   NSAssert(self.baseCollectionView, @"not set UICollectionVier instance!");
   self.baseCollectionView.showsVerticalScrollIndicator = NO;

   [self setupRefresh];
}


- (void)viewWillAppear:(BOOL)animated {
   [super viewDidAppear:animated];

   NSAssert(self.nextPageDelegate, @"not found YoutubeCollectionNextPageDelegate!");
   NSAssert(self.numbersPerLineArray, @"not found numbersPerLineArray!");
}


- (void)setUICollectionView:(UICollectionView *)collectionView {
   self.baseCollectionView = collectionView;
}


- (void)setupRefresh {
   self.refreshControl = [[UIRefreshControl alloc] init];
   self.refreshControl.tintColor = [UIColor redColor];
   [self.refreshControl addTarget:self
                           action:@selector(refreshControlAction)
                 forControlEvents:UIControlEventValueChanged];

   [self.baseCollectionView addSubview:self.refreshControl];
}


- (void)refreshControlAction {
   // Enter your code for request you are creating here when you pull the collectionView. When the request is completed then the collectionView go to its original position.
   [self performSelector:@selector(refreshPerform) withObject:(self) afterDelay:(4.0)];
}


- (void)refreshPerform {
//   [self.nextPageDelegate executeRefreshTask];//used
   [self.nextPageDelegate executeNextPageTask];//test
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

   [[self getYoutubeRequestInfo] resetRequestInfoForSearchWithItemType:itemType withQueryTeam:text];
}


- (void)searchByPageToken {
   if ([[self getYoutubeRequestInfo] hasNextPage] == NO)
      return;


   YoutubeResponseBlock completion = ^(NSArray * array, NSObject * respObject) {
       [self.refreshControl endRefreshing];

       [[self getYoutubeRequestInfo] appendNextPageData:array];

       [[self baseCollectionView] reloadData];
   };
   ErrorResponseBlock error = ^(NSError * error) {
   };
   [[GYoutubeHelper getInstance] searchByQueryWithRequestInfo:[self getYoutubeRequestInfo]
                                            completionHandler:completion
                                                 errorHandler:error];
}


- (void)cleanup {
   [[self getYoutubeRequestInfo] resetInfo];
   [[self baseCollectionView] reloadData];
}


#pragma mark -
#pragma mark  Fetch Activity list by channelID


- (void)fetchActivityListByType:(YTSegmentItemType)itemType withChannelId:(NSString *)channelId {
//   channelId = @"UCl78QGX_hfK6zT8Mc-2w8GA";

   [self cleanup];

   [[self getYoutubeRequestInfo] resetRequestInfoForActivityListFromChannelWithChannelId:channelId];
}


- (void)fetchActivityListByPageToken {
   if ([[self getYoutubeRequestInfo] hasNextPage] == NO)
      return;

   YoutubeResponseBlock completion = ^(NSArray * array, NSObject * respObject) {
       [self.refreshControl endRefreshing];

       [[self getYoutubeRequestInfo] appendNextPageData:array];

       [[self baseCollectionView] reloadData];
   };
   ErrorResponseBlock error = ^(NSError * error) {
       NSString * debug = @"debug";
   };
   [[GYoutubeHelper getInstance] fetchActivityListWithRequestInfo:[self getYoutubeRequestInfo]
                                                CompletionHandler:completion
                                                     errorHandler:error];
}


#pragma mark -
#pragma mark  Fetch video list by channelID


- (void)fetchVideoListFromChannelWithChannelId:(NSString *)channelId {
//   channelId = @"UCl78QGX_hfK6zT8Mc-2w8GA";

   [self cleanup];

   [[self getYoutubeRequestInfo] resetRequestInfoForVideoListFromChannelWithChannelId:channelId];
}


- (void)fetchVideoListFromChannelByPageToken {
   [self searchByPageToken];
}


#pragma mark -
#pragma mark  Fetch playLists by channelID


- (void)fetchPlayListFromChannelWithChannelId:(NSString *)channelId {
//   channelId = @"UCl78QGX_hfK6zT8Mc-2w8GA";

   [self cleanup];

   [[self getYoutubeRequestInfo] resetRequestInfoForPlayListFromChannelWithChannelId:channelId];
}


- (void)fetchPlayListFromChannelByPageToken {
   if ([[self getYoutubeRequestInfo] hasNextPage] == NO)
      return;

//   NSLog(@" *** fetchPlayListFromChannelByPageToken = %d", [[self getYoutubeRequestInfo] hasNextPage]);

   YoutubeResponseBlock completion = ^(NSArray * array, NSObject * respObject) {
       [self.refreshControl endRefreshing];

       [[self getYoutubeRequestInfo] appendNextPageData:array];

       [[self baseCollectionView] reloadData];
   };
   ErrorResponseBlock error = ^(NSError * error) {
       NSString * debug = @"debug";
   };
   [[GYoutubeHelper getInstance] fetchPlayListFromChannelWithRequestInfo:[self getYoutubeRequestInfo]
                                                       completionHandler:completion
                                                            errorHandler:error
   ];
}


#pragma mark -
#pragma mark  Fetch Activity list by channelID


- (void)fetchPlayListByType:(YTPlaylistItemsType)playlistItemsType {
   [self cleanup];

//   NSLog(@" *** fetchPlayListByType = %d", [[self getYoutubeRequestInfo] hasNextPage]);
   [[self getYoutubeRequestInfo] resetRequestInfoForPlayList:playlistItemsType];
}


- (void)fetchPlayListByPageToken {
   if ([[self getYoutubeRequestInfo] hasNextPage] == NO)
      return;

//   NSLog(@" *** fetchPlayListByPageToken = %d", [[self getYoutubeRequestInfo] hasNextPage]);

   YoutubeResponseBlock completion = ^(NSArray * array, NSObject * respObject) {
       [self.refreshControl endRefreshing];

       [[self getYoutubeRequestInfo] appendNextPageData:array];

       [[self baseCollectionView] reloadData];
   };
   ErrorResponseBlock error = ^(NSError * error) {
       NSString * debug = @"debug";
   };
   [[GYoutubeHelper getInstance] fetchPlaylistItemsListWithRequestInfo:[self getYoutubeRequestInfo]
                                                            completion:completion
                                                          errorHandler:error
   ];
}


#pragma mark -
#pragma mark  Fetch suggestion list by videoID


- (void)fetchSuggestionListByVideoId:(NSString *)videoId {
//   videoId = @"mOQ5DzROpuo";
   [self cleanup];

   [[self getYoutubeRequestInfo] resetRequestInfoForSuggestionList:videoId];
}


- (void)fetchSuggestionListByPageToken {
   [self searchByPageToken];
}


#pragma mark - 
#pragma mark 


- (int)getCurrentColumnCount:(UIInterfaceOrientation)orientation {
   return [(self.numbersPerLineArray[UIInterfaceOrientationIsPortrait(orientation) ? 0 : 1]) intValue];
}


- (CGSize)cellSize {
   CGSize size;

   UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
   NSString * key = UIInterfaceOrientationIsPortrait(orientation) ? @"vertical" : @"horizontal";
   NSString * keyWidth = [NSString stringWithFormat:@"%@_width", key];
   NSString * keyHeight = [NSString stringWithFormat:@"%@_height", key];

   NSNumber * valueWidth = [self.cellSizeDictionary objectForKey:keyWidth];
   NSNumber * valueHeight = [self.cellSizeDictionary objectForKey:keyHeight];
   if (valueWidth && valueHeight) {
      size = CGSizeMake([valueWidth floatValue], [valueHeight floatValue]);
   } else {
      size = [self makeCellSize:orientation];
      NSNumber * aWidth = [NSNumber numberWithFloat:size.width];
      NSNumber * aHeight = [NSNumber numberWithFloat:size.height];
      [self.cellSizeDictionary setObject:aWidth forKey:keyWidth];
      [self.cellSizeDictionary setObject:aHeight forKey:keyHeight];
   }

   return size;
}


- (CGSize)makeCellSize:(UIInterfaceOrientation)orientation {
   int columnCount = [self getCurrentColumnCount:orientation];
   UICollectionViewFlowLayout * layout = self.baseCollectionView.collectionViewLayout;

   CGFloat usableSpace = (layout.collectionViewContentSize.width
    - layout.sectionInset.left - layout.sectionInset.right
    - ((columnCount - 1)));
//    - ((columnCount - 1) * layout.minimumColumnSpacing));

   CGFloat cellLength = usableSpace / columnCount;

   return CGSizeMake(cellLength, cellLength + 12);
}


@end






