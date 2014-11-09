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


//NSString * lastSearch = @"call of duty advanced warfare";
NSString * lastSearch = @"sketch 3";
//NSString * lastSearch = nil;


@interface YoutubeGridLayoutViewController ()
@property(nonatomic, strong) UIRefreshControl * refreshControl;
//@property(nonatomic, strong) UICollectionView * collectionView;
@property(strong, nonatomic) IBOutlet UICollectionView * collectionView;

@property(nonatomic, strong) KRLCollectionViewGridLayout * collectionViewGridLayout;

@property(nonatomic, strong) GYoutubeSearchInfo * searchInfo;
@property(nonatomic) NSUInteger hasLoadingMore;
@property(nonatomic, strong) NSMutableArray * videoList;

@end


@implementation YoutubeGridLayoutViewController

- (void)viewDidLoad {
   [super viewDidLoad];

   // Do any additional setup after loading the view.
   self.view.backgroundColor = [UIColor clearColor];

   self.hasLoadingMore = NO;

   [self setupCollectionView];
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


- (void)setupCollectionView {
   self.collectionViewGridLayout = [[KRLCollectionViewGridLayout alloc] init];
//   self.collectionView = [[UICollectionView alloc] initWithFrame:pView.frame
//                                            collectionViewLayout:self.collectionViewGridLayout];
   self.collectionView.collectionViewLayout = self.collectionViewGridLayout;

   self.collectionView.backgroundColor = [UIColor clearColor];
   [self.collectionView setAutoresizesSubviews:YES];
   [self.collectionView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];


   [self.collectionView registerClass:[IpadGridViewCell class] forCellWithReuseIdentifier:identifier];

   [self.collectionView registerClass:[UICollectionReusableView class]
           forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                  withReuseIdentifier:LOADING_CELL_IDENTIFIER];


   self.collectionView.dataSource = self;
   self.collectionView.delegate = self;

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
   return self.videoList.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
   IpadGridViewCell * cell = (IpadGridViewCell *) [self.collectionView dequeueReusableCellWithReuseIdentifier:identifier
                                                                                                 forIndexPath:indexPath];

   YTYouTubeVideo * video = [self.videoList objectAtIndex:indexPath.row];
   [cell bind:video placeholderImage:[UIImage imageNamed:@"mt_cell_cover_placeholder"] delegate:self.delegate];

   return cell;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {

   UICollectionReusableView * reusableview = nil;
   if (kind == UICollectionElementKindSectionFooter) {
      UICollectionReusableView * footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                                                                 withReuseIdentifier:LOADING_CELL_IDENTIFIER
                                                                                        forIndexPath:indexPath];

      footerview.backgroundColor = [UIColor redColor];

//      UIActivityIndicatorView * indicatorView = [footerview viewWithTag:123];

//      footerview.frame = CGRectZero;
//      [indicatorView startAnimating];

      reusableview = footerview;
   }

   return reusableview;
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
