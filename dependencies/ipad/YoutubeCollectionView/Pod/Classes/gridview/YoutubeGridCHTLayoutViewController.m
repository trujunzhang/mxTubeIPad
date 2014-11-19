//
//  YoutubeGridCHTLayoutViewController.m
//  YoutubePlayApp
//
//  Created by djzhang on 10/15/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import "YoutubeGridCHTLayoutViewController.h"
#import "CHTCollectionViewWaterfallLayout.h"
#import "YoutubeFooterView.h"
#import "YTGridViewVideoCell.h"
#import "YTGridVideoCellNode.h"


#define FOOTER_IDENTIFIER @"WaterfallFooter"
#define DEFAULT_LOADING_MORE_HEIGHT 140;


@interface YoutubeGridCHTLayoutViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, CHTCollectionViewDelegateWaterfallLayout, CHTCollectionViewDelegateWaterfallLayout>
@property(strong, nonatomic) UICollectionView * collectionView;
@property(nonatomic, strong) CHTCollectionViewWaterfallLayout * layout;
@property(nonatomic, strong) UIImage * placeHolderImage;
@end


@implementation YoutubeGridCHTLayoutViewController

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

}


- (UICollectionView *)getCollectionView {
   if (!self.collectionView) {
      self.layout = [[CHTCollectionViewWaterfallLayout alloc] init];

      self.layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
      self.layout.footerHeight = DEFAULT_LOADING_MORE_HEIGHT;
      self.layout.minimumColumnSpacing = 20;
      self.layout.minimumInteritemSpacing = 30;


      self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
      self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
      self.collectionView.dataSource = self;
      self.collectionView.delegate = self;
      self.collectionView.backgroundColor = [UIColor whiteColor];

      [self.collectionView registerClass:[YTGridViewVideoCell class]
              forCellWithReuseIdentifier:[GYoutubeRequestInfo getIdentifyByItemType:YTSegmentItemVideo]];

      [self.collectionView registerClass:[YoutubeFooterView class]
              forSupplementaryViewOfKind:CHTCollectionElementKindSectionFooter
                     withReuseIdentifier:FOOTER_IDENTIFIER];
   }
   return self.collectionView;
}


#pragma mark - Life Cycle


- (void)dealloc {
   self.collectionView.delegate = nil;
   self.collectionView.dataSource = nil;
}


- (void)viewDidLayoutSubviews {
   [super viewDidLayoutSubviews];
   _collectionView.frame = self.view.bounds;
   [self updateLayout:[UIApplication sharedApplication].statusBarOrientation];
}


- (void)updateLayout:(UIInterfaceOrientation)orientation {
   self.layout.columnCount = [(self.numbersPerLineArray[UIInterfaceOrientationIsPortrait(orientation) ? 0 : 1]) intValue];
}


#pragma mark - UICollectionViewDataSource


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
   return [self getYoutubeRequestInfo].videoList.count;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
   return 1;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
   NSString * cell_identifier = [self getYoutubeRequestInfo].itemIdentify;
   YTSegmentItemType itemType = [self getYoutubeRequestInfo].itemType;

   UICollectionViewCell * viewCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:cell_identifier
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


//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//   NSString * cell_identifier = [self getYoutubeRequestInfo].itemIdentify;
//   UICollectionViewCell * viewCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:cell_identifier
//                                                                                    forIndexPath:indexPath];
//   CGSize size = [self cellSize];
//   viewCell.frame = CGRectMake(0, 0, size.width, size.height);
//   ASCellNode * node = [self getCellNodeAtIndexPath:indexPath size:size];
//   UIView * view = node.view;
//   [viewCell addSubview:view];
//
//   return viewCell;
//}


- (ASCellNode *)getCellNodeAtIndexPath:(NSIndexPath *)indexPath size:(CGSize)size {

   ASCellNode * node;

   YTSegmentItemType itemType = [self getYoutubeRequestInfo].itemType;

   if (itemType == YTSegmentItemVideo) {
      YTYouTubeVideo * video = [[self getYoutubeRequestInfo].videoList objectAtIndex:indexPath.row];

      YTGridVideoCellNode * videoCellNode = [[YTGridVideoCellNode alloc] initWithCellNodeOfSize:size];
      [videoCellNode bind:video
         placeholderImage:self.placeHolderImage
                 delegate:self.delegate];

      node = videoCellNode;
   }

   return node;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
   UICollectionReusableView * reusableView = nil;

   if ([kind isEqualToString:CHTCollectionElementKindSectionFooter]) {
      YoutubeFooterView * footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                          withReuseIdentifier:FOOTER_IDENTIFIER
                                                                                 forIndexPath:indexPath];
      footerView.hidden = NO;

      if ([self getYoutubeRequestInfo].hasLoadingMore) {
         [footerView startAnimation];
         [self.nextPageDelegate executeNextPageTask];
      } else {
         footerView.hidden = YES;
         [footerView stopAnimation];
      }

      reusableView = footerView;
   }

   return reusableView;
}


#pragma mark - CHTCollectionViewDelegateWaterfallLayout


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
   return [self cellSize];
}


- (CGSize)cellSize {
   CGFloat usableSpace = [self usableSpace];
   CGFloat cellLength = usableSpace / self.layout.columnCount;

   CGSize size = CGSizeMake(cellLength, cellLength + 12);
   return size;
}


- (CGFloat)usableSpace {
   return (self.layout.collectionViewContentSize.width
    - self.layout.sectionInset.left
    - self.layout.sectionInset.right
    - ((self.layout.columnCount - 1) * self.layout.minimumColumnSpacing));
}


@end

