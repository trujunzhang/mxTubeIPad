//
//  YoutubeCollectionViewController.h
//  YoutubePlayApp
//
//  Created by djzhang on 10/15/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KRLCollectionViewGridLayout;
@protocol IpadGridViewCellDelegate;


@interface YoutubeCollectionViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic, assign) id<IpadGridViewCellDelegate> delegate;

@property(nonatomic, strong) NSArray * numbersPerLineArray;

@property(strong, nonatomic) UICollectionView * collectionView;

@property(nonatomic) NSUInteger hasLoadingMore;
@property(nonatomic, strong) NSMutableArray * videoList;

@end
