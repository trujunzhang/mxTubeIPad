//
//  YoutubeGridLayoutViewController.h
//  YoutubePlayApp
//
//  Created by djzhang on 10/15/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YoutubeCollectionViewBase.h"

@protocol IpadGridViewCellDelegate;


@interface YoutubeGridLayoutViewController : YoutubeCollectionViewBase

@property(nonatomic, assign) id<IpadGridViewCellDelegate> delegate;


@property(nonatomic, strong) NSArray * numbersPerLineArray;
@property(nonatomic, strong) UIImage * placeHolderImage;
@end
