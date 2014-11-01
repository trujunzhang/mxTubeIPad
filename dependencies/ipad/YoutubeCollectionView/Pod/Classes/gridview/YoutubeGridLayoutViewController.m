//
//  YoutubeGridLayoutViewController.m
//  YoutubePlayApp
//
//  Created by djzhang on 10/15/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import "YoutubeGridLayoutViewController.h"

#import "KRLCollectionViewGridLayout.h"
#import "IpadGridViewCell.h"
#import "GYoutubeHelper.h"
#import "SearchImplementation.h"
#import "DebugUtils.h"


static NSString * const identifier = @"GridViewCellIdentifier";


//NSString * lastSearch = @"yosemite";
NSString * lastSearch = nil;


@interface YoutubeGridLayoutViewController ()
@end


@implementation YoutubeGridLayoutViewController

- (instancetype)initWithVideoList:(NSArray *)videoList {
   self = [super init];
   if (self) {
      self.videoList = videoList;
      [[self collectionView] reloadData];
   }

   return self;
}


- (void)viewDidLoad {
   [super viewDidLoad];

   if (lastSearch)
      [self search:lastSearch];

   // Do any additional setup after loading the view.
   self.view.backgroundColor = [UIColor clearColor];

   self.placeHoderImage = [UIImage imageNamed:@"mt_cell_cover_placeholder"];

   [self setupCollectionView:self.view];
}


- (void)setupCollectionView:(UIView *)pView {
   self.collectionViewGridLayout = [[KRLCollectionViewGridLayout alloc] init];
   self.collectionView = [[UICollectionView alloc] initWithFrame:pView.frame
                                            collectionViewLayout:self.collectionViewGridLayout];

   [self.collectionView setAutoresizesSubviews:YES];
   [self.collectionView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];

   [self.collectionView registerNib:[UINib nibWithNibName:@"IpadGridViewCell" bundle:nil]
         forCellWithReuseIdentifier:identifier];

   self.collectionView.dataSource = self;
   self.collectionView.delegate = self;
   self.collectionView.backgroundColor = [UIColor clearColor];

   [pView addSubview:self.collectionView];

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


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
   return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
   return self.videoList.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
   IpadGridViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
   cell.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;


   [cell    bind:[self.videoList objectAtIndex:indexPath.row]
placeholderImage:self.placeHoderImage
        delegate:self.delegate];

   return cell;
}


- (void)viewDidLayoutSubviews {
   [super viewDidLayoutSubviews];

//   [DebugUtils printFrameInfo:self.view.frame withControllerName:@"YoutubeGridLayoutViewController"];// TODO test(log)

   [self updateLayout:[UIApplication sharedApplication].statusBarOrientation];
}


- (void)updateLayout:(UIInterfaceOrientation)toInterfaceOrientation {
   BOOL isPortrait = (toInterfaceOrientation == UIInterfaceOrientationPortrait) || (toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);

   NSAssert(self.numbersPerLineArray, @"Please initialize numbersPerLineArray first.");

   self.layout.numberOfItemsPerLine = [(self.numbersPerLineArray[isPortrait ? 0 : 1]) intValue];
}


- (void)search:(NSString *)text {
   [self cleanup];

   lastSearch = text;
   YoutubeResponseBlock completion = ^(NSArray * array) {
       self.videoList = array;
       [[self collectionView] reloadData];
   };
   ErrorResponseBlock error = ^(NSError * error) {
       NSString * debug = @"debug";
   };
   [[SearchImplementation getInstance] searchByQueryWithQueryTerm:text
                                                completionHandler:completion
                                                     errorHandler:error];
}


- (void)cleanup {
   self.videoList = [[NSArray alloc] init];
   [[self collectionView] reloadData];
}
@end
