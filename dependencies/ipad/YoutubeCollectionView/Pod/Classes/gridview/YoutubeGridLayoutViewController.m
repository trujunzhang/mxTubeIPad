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


#define FOOTER_IDENTIFIER @"WaterfallFooter"
#define DEFAULT_LOADING_MORE_HEIGHT 140;


@interface YoutubeGridLayoutViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, CHTCollectionViewDelegateWaterfallLayout>

@end


@implementation YoutubeGridLayoutViewController

- (void)viewDidLoad {
   self.hasLoadingMore = NO;
   [self.view addSubview:[self getCollectionView]];

   [super viewDidLoad];
}


- (UICollectionView *)getCollectionView {
   if (!self.collectionView) {
      CHTCollectionViewWaterfallLayout * layout = [[CHTCollectionViewWaterfallLayout alloc] init];

      layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
      layout.footerHeight = DEFAULT_LOADING_MORE_HEIGHT;
      layout.minimumColumnSpacing = 10;
      layout.minimumInteritemSpacing = 10;

      self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
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
   [self updateLayout:[UIApplication sharedApplication].statusBarOrientation];
}


- (void)updateLayout:(UIInterfaceOrientation)orientation {
   CHTCollectionViewWaterfallLayout * layout =
    (CHTCollectionViewWaterfallLayout *) self.collectionView.collectionViewLayout;
   layout.columnCount = [(self.numbersPerLineArray[UIInterfaceOrientationIsPortrait(orientation) ? 0 : 1]) intValue];
}


#pragma mark - UICollectionViewDataSource


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
   return self.videoList.count;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
   return 1;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
   YTYouTubeVideo * video = [self.videoList objectAtIndex:indexPath.row];

   NSString * cell_identifier = self.searchInfo.itemIdentify;
   YTSegmentItemType itemType = self.searchInfo.itemType;

   UICollectionView * viewCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:cell_identifier
                                                                                forIndexPath:indexPath];


   if (itemType == YTSegmentItemVideo) {
      YTGridViewVideoCell * gridViewVideoCell = (YTGridViewVideoCell *) viewCell;
      [gridViewVideoCell bind:video
             placeholderImage:[UIImage imageNamed:@"mt_cell_cover_placeholder"]
                     delegate:self.delegate];
   }

   return viewCell;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:
            (NSString *)kind
                                 atIndexPath:
                                  (NSIndexPath *)indexPath {
   UICollectionReusableView * reusableView = nil;

   if ([kind isEqualToString:CHTCollectionElementKindSectionFooter]) {
      YoutubeFooterView * footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                          withReuseIdentifier:FOOTER_IDENTIFIER
                                                                                 forIndexPath:indexPath];
      footerView.hidden = NO;
      if (self.hasLoadingMore == YES) {
         [footerView startAnimation];
         [self searchByPageToken]; // Check no pageToken,set hasLoadingMore is No.
      }

      if (self.hasLoadingMore == NO) {
         footerView.hidden = YES;
         [footerView stopAnimation];
      }

      reusableView = footerView;
   }

   return reusableView;
}


@end

