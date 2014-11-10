//
//  YoutubeCollectionViewController.m
//  YoutubePlayApp
//
//  Created by djzhang on 10/15/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import "YoutubeCollectionViewController.h"

#import "IpadGridViewCell.h"
#import "CHTCollectionViewWaterfallLayout.h"


#define CELL_IDENTIFIER @"WaterfallCell"
#define FOOTER_IDENTIFIER @"WaterfallFooter"


@interface YoutubeCollectionViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, CHTCollectionViewDelegateWaterfallLayout>

@end


@implementation YoutubeCollectionViewController

- (void)viewDidLoad {
   [super viewDidLoad];

   self.hasLoadingMore = NO;
   [self.view addSubview:self.collectionView];
}


- (UICollectionView *)collectionView {
   if (!_collectionView) {
      CHTCollectionViewWaterfallLayout * layout = [[CHTCollectionViewWaterfallLayout alloc] init];

      layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
      layout.footerHeight = 210;
      layout.minimumColumnSpacing = 20;
      layout.minimumInteritemSpacing = 30;

      _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
      _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
      _collectionView.dataSource = self;
      _collectionView.delegate = self;
      _collectionView.backgroundColor = [UIColor whiteColor];
      [_collectionView registerClass:[IpadGridViewCell class]
          forCellWithReuseIdentifier:CELL_IDENTIFIER];
      [_collectionView registerClass:[UICollectionReusableView class]
          forSupplementaryViewOfKind:CHTCollectionElementKindSectionFooter
                 withReuseIdentifier:FOOTER_IDENTIFIER];
   }
   return _collectionView;
}


#pragma mark - Life Cycle


- (void)dealloc {
   _collectionView.delegate = nil;
   _collectionView.dataSource = nil;
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
      reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                        withReuseIdentifier:FOOTER_IDENTIFIER
                                                               forIndexPath:indexPath];
      reusableView.backgroundColor = [UIColor redColor];
   }

   return reusableView;
}


#pragma mark - CHTCollectionViewDelegateWaterfallLayout


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
   return [[NSValue valueWithCGSize:CGSizeMake(20, 20)] CGSizeValue];
}


@end
