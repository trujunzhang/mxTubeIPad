//
//  YoutubeGridLayoutViewController.h
//  YoutubePlayApp
//
//  Created by djzhang on 10/15/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KRLCollectionViewGridLayout;
@protocol IpadGridViewCellDelegate;


@interface YoutubeGridLayoutViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic, assign) id<IpadGridViewCellDelegate> delegate;

@property(nonatomic, strong) NSArray * numbersPerLineArray;

- (void)search:(NSString *)text;
- (void)search:(NSString *)text withQueryType:(NSString *)queryType;
- (void)cleanup;
@end
