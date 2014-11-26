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
#import "YTGridViewPlaylistCell.h"
#import "YTAsyncGridViewVideoCollectionViewCell.h"


#define FOOTER_IDENTIFIER @"WaterfallFooter"
#define DEFAULT_LOADING_MORE_HEIGHT 140;

#define  CollectionVideoReuseCell YTAsyncGridViewVideoCollectionViewCell
//#define  CollectionVideoReuseCell YTGridViewVideoCell


@interface YoutubeGridCHTLayoutViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, CHTCollectionViewDelegateWaterfallLayout, CHTCollectionViewDelegateWaterfallLayout>
@property(strong, nonatomic) UICollectionView * collectionView;
@property(nonatomic, strong) CHTCollectionViewWaterfallLayout * layout;
@property(nonatomic, strong) UIImage * placeHolderImage;

@end


//YoutubeGridFlowLayoutViewController
@implementation YoutubeGridCHTLayoutViewController

- (void)viewDidLoad {
   [self.view addSubview:[self getCollectionView]];
   self.placeHolderImage = [UIImage imageNamed:@"mt_cell_cover_placeholder"];
   [self setUICollectionView:self.collectionView];

   [super viewDidLoad];
}


- (UICollectionView *)getCollectionView {
   if (!self.collectionView) {
      self.layout = [[CHTCollectionViewWaterfallLayout alloc] init];

      UIEdgeInsets uiEdgeInsets = [self getUIEdgeInsetsForLayout];
      self.layout.sectionInset = uiEdgeInsets;
      self.layout.footerHeight = DEFAULT_LOADING_MORE_HEIGHT;
      self.layout.minimumColumnSpacing = LAYOUT_MINIMUMCOLUMNSPACING;
      self.layout.minimumInteritemSpacing = 10;


      self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
      self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
      self.collectionView.dataSource = self;
      self.collectionView.delegate = self;
      self.collectionView.backgroundColor = [UIColor lightGrayColor];

      [self.collectionView registerClass:[CollectionVideoReuseCell class]
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
   self.layout.columnCount = [self getCurrentColumnCount:orientation];
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


   switch (itemType) {
      case YTSegmentItemVideo: {
         YTYouTubeVideoCache * video = [[self getYoutubeRequestInfo].videoList objectAtIndex:indexPath.row];
         CollectionVideoReuseCell * gridViewVideoCell = (CollectionVideoReuseCell *) viewCell;
         [gridViewVideoCell bind:video
                placeholderImage:self.placeHolderImage
                        cellSize:[self cellSize]
                        delegate:self.delegate
           nodeConstructionQueue:self.nodeConstructionQueue
         ];
      }
         break;
      case YTSegmentItemPlaylist: {
         YTYouTubePlayList * video = [[self getYoutubeRequestInfo].videoList objectAtIndex:indexPath.row];
         YTGridViewPlaylistCell * gridViewVideoCell = (YTGridViewPlaylistCell *) viewCell;
         [gridViewVideoCell bind:video
                placeholderImage:self.placeHolderImage
                        delegate:self.delegate];
      }
         break;
   }


   return viewCell;
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


@end

