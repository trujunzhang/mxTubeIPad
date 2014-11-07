//
//  YoutubeGridLayoutViewController.m
//  YoutubePlayApp
//
//  Created by djzhang on 10/15/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import "YoutubeGridLayoutViewController.h"

#import "KRLCollectionViewGridLayout.h"
#import "IpadGridViewCell.h"
#import "GYoutubeHelper.h"
#import "GYoutubeSearchInfo.h"


static NSString * const identifier = @"GridViewCellIdentifier";
static NSString * const LOADING_CELL_IDENTIFIER = @"LoadingItemCell";


NSString * lastSearch = @"call of duty advanced warfare";
//NSString * lastSearch = nil;


@interface YoutubeGridLayoutViewController ()
@property(nonatomic, strong) UIRefreshControl * refreshControl;


@property(nonatomic, strong) UICollectionView * collectionView;

@property(nonatomic, strong) KRLCollectionViewGridLayout * collectionViewGridLayout;
@property(nonatomic, strong) NSMutableArray * videoList;


@property(nonatomic, strong) UIImage * placeHoderImage;
@property(nonatomic, strong) GYoutubeSearchInfo * searchInfo;

@end


@implementation YoutubeGridLayoutViewController

- (instancetype)initWithVideoList:(NSArray *)videoList {
   self = [super init];
   if (self) {
      self.videoList = videoList;
      [[self collectionView] reloadData];
   }

   return self;
}


- (void)viewDidLoad {
   [super viewDidLoad];

   if (lastSearch)
      [self search:lastSearch];

   // Do any additional setup after loading the view.
   self.view.backgroundColor = [UIColor clearColor];

   self.placeHoderImage = [UIImage imageNamed:@"mt_cell_cover_placeholder"];

   [self setupCollectionView:self.view];
   [self setupRefresh];
}


- (void)setupRefresh {
   self.refreshControl = [[UIRefreshControl alloc] init];
   self.refreshControl.tintColor = [UIColor clearColor];
   [self.refreshControl addTarget:self
                           action:@selector(refreshControlAction)
                 forControlEvents:UIControlEventValueChanged];

   [self.collectionView addSubview:self.refreshControl];
}


- (void)refreshControlAction {
   // Enter your code for request you are creating here when you pull the collectionView. When the request is completed then the collectionView go to its original position.
   [self.refreshControl endRefreshing];
}


- (void)setupCollectionView:(UIView *)pView {
   self.collectionViewGridLayout = [[KRLCollectionViewGridLayout alloc] init];
   self.collectionView = [[UICollectionView alloc] initWithFrame:pView.frame
                                            collectionViewLayout:self.collectionViewGridLayout];

   [self.collectionView setAutoresizesSubviews:YES];
   [self.collectionView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
   [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:LOADING_CELL_IDENTIFIER];

   [self.collectionView registerClass:[IpadGridViewCell class] forCellWithReuseIdentifier:identifier];


   self.collectionView.dataSource = self;
   self.collectionView.delegate = self;
   self.collectionView.backgroundColor = [UIColor clearColor];

   [pView addSubview:self.collectionView];

   self.layout.aspectRatio = 1;
   self.layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
   self.layout.interitemSpacing = 10;
   self.layout.lineSpacing = 10;
}


- (KRLCollectionViewGridLayout *)layout {
   return (id) self.collectionView.collectionViewLayout;
}


- (void)didReceiveMemoryWarning {
   [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
   return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
   return self.videoList.count + 1;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
   if (indexPath.item < self.videoList.count) {
      return [self itemCellForIndexPath:indexPath];
   } else {
//      [self search:lastSearch];
      return [self loadingCellForIndexPath:indexPath];
   }
}


- (UICollectionViewCell *)itemCellForIndexPath:(NSIndexPath *)indexPath {
   IpadGridViewCell * cell = (IpadGridViewCell *) [self.collectionView dequeueReusableCellWithReuseIdentifier:identifier
                                                                                                 forIndexPath:indexPath];

   YTYouTubeVideo * video = [self.videoList objectAtIndex:indexPath.row];
   [cell bind:video placeholderImage:self.placeHoderImage delegate:self.delegate];

   return cell;
}


- (UICollectionViewCell *)loadingCellForIndexPath:(NSIndexPath *)indexPath {

   UICollectionViewCell * cell = (UICollectionViewCell *)
    [self.collectionView dequeueReusableCellWithReuseIdentifier:LOADING_CELL_IDENTIFIER forIndexPath:indexPath];

   UIActivityIndicatorView * activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];

   activityIndicator.color = [UIColor blackColor];
   activityIndicator.center = cell.center;

   [cell addSubview:activityIndicator];

   [activityIndicator startAnimating];

   return cell;
}


- (void)viewDidLayoutSubviews {
   [super viewDidLayoutSubviews];

//   [DebugUtils printFrameInfo:self.view.frame withControllerName:@"YoutubeGridLayoutViewController"];// TODO test(log)

   [self updateLayout:[UIApplication sharedApplication].statusBarOrientation];
}


- (void)updateLayout:(UIInterfaceOrientation)toInterfaceOrientation {
   BOOL isPortrait = (toInterfaceOrientation == UIInterfaceOrientationPortrait) || (toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);

   NSAssert(self.numbersPerLineArray, @"Please initialize numbersPerLineArray first.");

   self.layout.numberOfItemsPerLine = [(self.numbersPerLineArray[isPortrait ? 0 : 1]) intValue];
}


- (void)search:(NSString *)text {
   [self search:text withQueryType:@"video"];
}


- (void)search:(NSString *)text withQueryType:(NSString *)queryType {
   [self cleanup];

   self.searchInfo = [[GYoutubeSearchInfo alloc] initWithQueryType:@"video" withTeam:text];

   lastSearch = text;

   YoutubeResponseBlock completion = ^(NSArray * array) {
       [self.refreshControl endRefreshing];
       self.videoList = array;
       [[self collectionView] reloadData];
   };
   ErrorResponseBlock error = ^(NSError * error) {
       NSString * debug = @"debug";
   };
   [[GYoutubeHelper getInstance] searchByQueryWithSearchInfo:self.searchInfo
                                           completionHandler:completion
                                                errorHandler:error];

}


- (void)cleanup {
   self.videoList = [[NSArray alloc] init];

   [[self collectionView] reloadData];
}
@end
