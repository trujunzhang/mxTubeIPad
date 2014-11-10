//
//  YoutubeGridLayoutViewController.h
//  YoutubePlayApp
//
//  Created by djzhang on 10/15/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YoutubeCollectionViewController.h"
@protocol IpadGridViewCellDelegate;


@interface YoutubeGridLayoutViewController :YoutubeCollectionViewController
@property(nonatomic, assign) id<IpadGridViewCellDelegate> delegate;
@property(nonatomic, strong) NSArray * numbersPerLineArray;

@end
