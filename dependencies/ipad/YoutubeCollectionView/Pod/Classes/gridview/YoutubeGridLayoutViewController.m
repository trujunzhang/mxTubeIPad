//
//  YoutubeGridLayoutViewController.m
//  YoutubePlayApp
//
//  Created by djzhang on 10/15/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import "YoutubeGridLayoutViewController.h"
#import "CHTCollectionViewWaterfallLayout.h"
#import "YoutubeFooterView.h"
#import "GYoutubeRequestInfo.h"
#import "YTGridViewVideoCell.h"
#import "KRLCollectionViewGridLayout.h"
#import "YTGridVideoCellNode.h"


@interface YoutubeGridLayoutViewController ()<ASCollectionViewDataSource, ASCollectionViewDelegate, CHTCollectionViewDelegateWaterfallLayout>

@end


@implementation YoutubeGridLayoutViewController

- (void)viewDidLoad {
   [self.view addSubview:[self getCollectionView]];

   self.placeHolderImage = [UIImage imageNamed:@"mt_cell_cover_placeholder"];

   [super viewDidLoad];
}


- (void)viewWillAppear:(BOOL)animated {
   [super viewDidAppear:animated];

   NSAssert(self.nextPageDelegate, @"not found YoutubeCollectionNextPageDelegate!");
   NSAssert(self.numbersPerLineArray, @"not found numbersPerLineArray!");

//   [self.nextPageDelegate executeNextPageTask]; // test
}


- (UICollectionView *)getCollectionView {
   if (!self.collectionView) {
      self.layout = [[KRLCollectionViewGridLayout alloc] init];
      self.layout.aspectRatio = 1;
      self.layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
      self.layout.interitemSpacing = 10;
      self.layout.lineSpacing = 10;
      self.layout.scrollDirection = UICollectionViewScrollDirectionVertical;


      self.collectionView = [[ASCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
      self.collectionView.asyncDataSource = self;
      self.collectionView.asyncDelegate = self;

      self.collectionView.backgroundColor = [UIColor whiteColor];
   }
   return self.collectionView;
}


#pragma mark - Life Cycle


- (void)dealloc {
   self.collectionView.asyncDataSource = nil;
   self.collectionView.asyncDelegate = nil;
}


- (void)viewDidLayoutSubviews {
   [super viewDidLayoutSubviews];
   self.collectionView.frame = self.view.bounds;

   [self updateLayout:[UIApplication sharedApplication].statusBarOrientation];
}


- (void)updateLayout:(UIInterfaceOrientation)orientation {
   self.layout.numberOfItemsPerLine = [(self.numbersPerLineArray[UIInterfaceOrientationIsPortrait(orientation) ? 0 : 1]) intValue];
}


#pragma mark - UICollectionViewDataSource


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
   int moreCount = [[self getYoutubeRequestInfo] hasLoadingMore] ? 1 : 0;
   return [self getYoutubeRequestInfo].videoList.count + moreCount;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
   return 1;
}


- (ASCellNode *)collectionView:(ASCollectionView *)collectionView nodeForItemAtIndexPath:(NSIndexPath *)indexPath {
   ASCellNode * node;

   NSUInteger count = [self getYoutubeRequestInfo].videoList.count;

   if (indexPath.row == count) {
      node = [[ASCellNode alloc] init];
      node.backgroundColor = [UIColor redColor];
      [self.nextPageDelegate executeNextPageTask]; // test
   } else {
      node = [self getCellNodeAtIndexPath:indexPath];
   }

   return node;
}


- (ASCellNode *)getCellNodeAtIndexPath:(NSIndexPath *)indexPath {

   ASCellNode * node;

   YTSegmentItemType itemType = [self getYoutubeRequestInfo].itemType;

   if (itemType == YTSegmentItemVideo) {
      YTYouTubeVideo * video = [[self getYoutubeRequestInfo].videoList objectAtIndex:indexPath.row];
      YTGridVideoCellNode * videoCellNode = [[YTGridVideoCellNode alloc] initWithCellNodeOfSize:[self.layout cellSize]];
      [videoCellNode bind:video
         placeholderImage:self.placeHolderImage
                 delegate:self.delegate];

      node = videoCellNode;
   }

   return node;
}


@end

