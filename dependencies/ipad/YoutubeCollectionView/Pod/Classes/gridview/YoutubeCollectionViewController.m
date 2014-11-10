//
//  YoutubeCollectionViewController.m
//  YoutubePlayApp
//
//  Created by djzhang on 10/15/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import "YoutubeCollectionViewController.h"

#import "KRLCollectionViewGridLayout.h"
#import "IpadGridViewCell.h"
#import "GYoutubeSearchInfo.h"


NSString * youtubeGridIdentifier = @"YoutubeGridLayoutViewIdentifier";


@interface YoutubeCollectionViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>


@property(nonatomic, strong) KRLCollectionViewGridLayout * collectionViewGridLayout;


@end


@implementation YoutubeCollectionViewController

- (void)viewDidLoad {
   [super viewDidLoad];

   // Do any additional setup after loading the view.
   self.view.backgroundColor = [UIColor clearColor];

   self.hasLoadingMore = NO;

   [self setupCollectionView];

}


- (void)setupCollectionView {
   self.collectionViewGridLayout = [[KRLCollectionViewGridLayout alloc] init];
   self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds
                                            collectionViewLayout:self.collectionViewGridLayout];

   [self.collectionView registerClass:[IpadGridViewCell class] forCellWithReuseIdentifier:youtubeGridIdentifier];
//   [self.collectionView registerClass:[UICollectionReusableView class]
//           forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
//                  withReuseIdentifier:@"FooterView"];

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


#pragma mark -
#pragma mark UICollectionViewDataSource


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
   return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
   return self.videoList.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
   IpadGridViewCell * cell = (IpadGridViewCell *) [self.collectionView dequeueReusableCellWithReuseIdentifier:youtubeGridIdentifier
                                                                                                 forIndexPath:indexPath];

   YTYouTubeVideo * video = [self.videoList objectAtIndex:indexPath.row];
   [cell bind:video placeholderImage:[UIImage imageNamed:@"mt_cell_cover_placeholder"] delegate:self.delegate];

   return cell;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {

   UICollectionReusableView * reusableview = nil;
   if (kind == UICollectionElementKindSectionFooter) {
      UICollectionReusableView * footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                                                                 withReuseIdentifier:@""
                                                                                        forIndexPath:indexPath];

      footerview.backgroundColor = [UIColor redColor];
      reusableview = footerview;
   }

   return reusableview;
}


#pragma mark -
#pragma mark Rotate subviews


- (void)viewDidLayoutSubviews {
   [super viewDidLayoutSubviews];

   [self updateLayout:[UIApplication sharedApplication].statusBarOrientation];
}


- (void)updateLayout:(UIInterfaceOrientation)toInterfaceOrientation {
   BOOL isPortrait = (toInterfaceOrientation == UIInterfaceOrientationPortrait) || (toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);

   NSAssert(self.numbersPerLineArray, @"Please initialize numbersPerLineArray first.");

   self.layout.numberOfItemsPerLine = [(self.numbersPerLineArray[isPortrait ? 0 : 1]) intValue];
}


@end
