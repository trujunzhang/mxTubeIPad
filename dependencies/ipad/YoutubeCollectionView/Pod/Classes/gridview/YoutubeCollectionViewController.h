//
//  YoutubeCollectionViewController.h
//  YoutubePlayApp
//
//  Created by djzhang on 10/15/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YoutubeGridLayoutViewController.h"


@interface YoutubeCollectionViewController : UIViewController

@property(nonatomic) NSUInteger hasLoadingMore;
@property(nonatomic, strong) NSMutableArray * videoList;
@property(strong, nonatomic) UICollectionView * collectionView;

- (void)search:(NSString *)text;
- (void)search:(NSString *)text withQueryType:(NSString *)queryType;
- (void)cleanup;
@end
