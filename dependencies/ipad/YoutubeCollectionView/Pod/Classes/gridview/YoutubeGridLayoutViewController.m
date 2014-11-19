//
//  YoutubeGridLayoutViewController.m
//  YoutubePlayApp
//
//  Created by djzhang on 10/15/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import <YoutubeCollectionView/IpadGridViewCell.h>
#import "YoutubeGridLayoutViewController.h"
#import "CHTCollectionViewWaterfallLayout.h"
#import "YoutubeFooterView.h"
#import "GYoutubeRequestInfo.h"
#import "YTGridViewVideoCell.h"
#import "KRLCollectionViewGridLayout.h"
#import "YTGridVideoCellNode.h"


@interface YoutubeGridLayoutViewController ()<ASCollectionViewDataSource, ASCollectionViewDelegate, CHTCollectionViewDelegateWaterfallLayout>
@property(strong, nonatomic) ASCollectionView * collectionView;
@end


@implementation YoutubeGridLayoutViewController

- (void)viewDidLoad {
   [self.view addSubview:[self getCollectionView]];

   self.placeHolderImage = [UIImage imageNamed:@"mt_cell_cover_placeholder"];

   [self setUICollectionView:self.collectionView];

   [super viewDidLoad];
}


- (void)viewWillAppear:(BOOL)animated {
   [super viewDidAppear:animated];

   NSAssert(self.nextPageDelegate, @"not found YoutubeCollectionNextPageDelegate!");
   NSAssert(self.numbersPerLineArray, @"not found numbersPerLineArray!");

   [self.nextPageDelegate executeNextPageTask]; // test
}


- (UICollectionView *)getCollectionView {
   if (!self.collectionView) {
      self.layout = [[KRLCollectionViewGridLayout alloc] init];
      self.layout.aspectRatio = 1;
      self.layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
      self.layout.interitemSpacing = 30;
      self.layout.lineSpacing = 10;
      self.layout.aspectRatio = 1.1;
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
   return [self getYoutubeRequestInfo].videoList.count;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
   return 1;
}


- (ASCellNode *)collectionView:(ASCollectionView *)collectionView nodeForItemAtIndexPath:(NSIndexPath *)indexPath {
   ASCellNode * node;

   node = [self getCellNodeAtIndexPath:indexPath];

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

//      videoCellNode.backgroundColor = [UIColor redColor];

      node = videoCellNode;
   }

   return node;
}


@end

