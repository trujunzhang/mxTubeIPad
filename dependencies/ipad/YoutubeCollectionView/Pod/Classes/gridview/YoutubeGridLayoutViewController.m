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
   [self.view addSubview:[self getCollectionView]];

   self.placeHolderImage = [UIImage imageNamed:@"mt_cell_cover_placeholder"];

   [super viewDidLoad];
}


- (void)viewWillAppear:(BOOL)animated {
   [super viewDidAppear:animated];

   NSAssert(self.nextPageDelegate, @"not found YoutubeCollectionNextPageDelegate!");
   NSAssert(self.numbersPerLineArray, @"not found numbersPerLineArray!");

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
   return [self getYoutubeRequestInfo].videoList.count;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
   return 1;
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


@end

