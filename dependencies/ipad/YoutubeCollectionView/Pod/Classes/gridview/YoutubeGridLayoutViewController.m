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

   [self.nextPageDelegate executeNextPageTask];
}


- (UICollectionView *)getCollectionView {
   if (!self.collectionView) {
//      UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
//      layout.scrollDirection = UICollectionViewScrollDirectionVertical;


      self.layout = [[KRLCollectionViewGridLayout alloc] init];
      self.layout.aspectRatio = 1;
      self.layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
      self.layout.interitemSpacing = 10;
      self.layout.lineSpacing = 10;
      self.layout.scrollDirection = UICollectionViewScrollDirectionVertical;
//
//      layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
//      layout.footerHeight = 0;
//      layout.minimumColumnSpacing = 10;
//      layout.minimumInteritemSpacing = 10;

      self.collectionView = [[ASCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
      self.collectionView.asyncDataSource = self;
      self.collectionView.asyncDelegate = self;

//      self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
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
//   CHTCollectionViewWaterfallLayout * layout =
//    (CHTCollectionViewWaterfallLayout *) self.collectionView.collectionViewLayout;
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
   YTSegmentItemType itemType = [self getYoutubeRequestInfo].itemType;
   ASCellNode * node;
//   ASCellNode * node = [[ASCellNode alloc] init];
//
//   ASImageNode * imageNode = [[ASImageNode alloc] init];
//   imageNode.backgroundColor = [UIColor lightGrayColor];
//   imageNode.image = [UIImage imageNamed:@"mt_cell_cover_placeholder"];
//   imageNode.frame = CGRectMake(10.0f, 10.0f, 40.0f, 40.0f);
//
//   [node addSubnode:imageNode];

//   NSString * text = [NSString stringWithFormat:@"[%ld.%ld] says hi", indexPath.section, indexPath.item];
//   ASTextCellNode * node = [[ASTextCellNode alloc] init];
//   node.text = text;
//   node.backgroundColor = [UIColor redColor];

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


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
   NSString * cell_identifier = [self getYoutubeRequestInfo].itemIdentify;
   YTSegmentItemType itemType = [self getYoutubeRequestInfo].itemType;

   UICollectionView * viewCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:cell_identifier
                                                                                forIndexPath:indexPath];


   if (itemType == YTSegmentItemVideo) {
      YTYouTubeVideo * video = [[self getYoutubeRequestInfo].videoList objectAtIndex:indexPath.row];
      YTGridViewVideoCell * gridViewVideoCell = (YTGridViewVideoCell *) viewCell;
      [gridViewVideoCell bind:video
             placeholderImage:self.placeHolderImage
                     delegate:self.delegate];
   }

   return viewCell;
}


//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
//           viewForSupplementaryElementOfKind:(NSString *)kind
//                                 atIndexPath:(NSIndexPath *)indexPath {
//   UICollectionReusableView * reusableView = nil;
//
//   if ([kind isEqualToString:CHTCollectionElementKindSectionFooter]) {
//      YoutubeFooterView * footerView = nil;
//      footerView.hidden = NO;
//
//      if ([self getYoutubeRequestInfo].hasLoadingMore) {
//         [footerView startAnimation];
//         [self.nextPageDelegate executeNextPageTask];
//      } else {
//         footerView.hidden = YES;
//         [footerView stopAnimation];
//      }
//
//      reusableView = footerView;
//   }
//
//   return reusableView;
//}


@end

