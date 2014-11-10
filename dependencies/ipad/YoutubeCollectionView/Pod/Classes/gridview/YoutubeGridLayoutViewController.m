//
//  YoutubeGridLayoutViewController.m
//  YoutubePlayApp
//
//  Created by djzhang on 10/15/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import "YoutubeGridLayoutViewController.h"
#import "IpadGridViewCell.h"
#import "CHTCollectionViewWaterfallLayout.h"
#import "YoutubeFooterView.h"


#define CELL_IDENTIFIER @"WaterfallCell"
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
      layout.minimumColumnSpacing = 20;
      layout.minimumInteritemSpacing = 30;

      self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
      self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
      self.collectionView.dataSource = self;
      self.collectionView.delegate = self;
      self.collectionView.backgroundColor = [UIColor whiteColor];
      [self.collectionView registerClass:[IpadGridViewCell class]
              forCellWithReuseIdentifier:CELL_IDENTIFIER];
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


- (void)viewDidAppear:(BOOL)animated {
   [super viewDidAppear:animated];
   [self updateLayoutForOrientation:[UIApplication sharedApplication].statusBarOrientation];
}


- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
   [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
   [self updateLayoutForOrientation:toInterfaceOrientation];
}


- (void)updateLayoutForOrientation:(UIInterfaceOrientation)orientation {
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
   IpadGridViewCell * cell = (IpadGridViewCell *) [self.collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFIER
                                                                                                 forIndexPath:indexPath];

   GTLYouTubeVideo * video = [self.videoList objectAtIndex:indexPath.row];
   [cell bind:video placeholderImage:[UIImage imageNamed:@"mt_cell_cover_placeholder"] delegate:self.delegate];

   return cell;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
   UICollectionReusableView * reusableView = nil;

   if ([kind isEqualToString:CHTCollectionElementKindSectionFooter]) {
      YoutubeFooterView * footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                          withReuseIdentifier:FOOTER_IDENTIFIER
                                                                                 forIndexPath:indexPath];
      footerView.hidden = NO;
      if (self.hasLoadingMore) {
         [footerView startAnimation];
         [self searchByPageToken];
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
   return [[NSValue valueWithCGSize:CGSizeMake(20, 20)] CGSizeValue];
}


@end

