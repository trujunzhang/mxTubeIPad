//
//  YoutubeCollectionViewBase.h
//  YoutubePlayApp
//
//  Created by djzhang on 10/15/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GYoutubeSearchInfo;


@interface YoutubeCollectionViewBase : UIViewController
@property(nonatomic, strong) GYoutubeSearchInfo * searchInfo;

@property(nonatomic) NSUInteger hasLoadingMore;
@property(nonatomic, strong) NSMutableArray * videoList;
@property(strong, nonatomic) UICollectionView * collectionView;

- (void)search:(NSString *)text;
- (void)search:(NSString *)text withQueryType:(NSString *)queryType;
- (void)searchByPageToken;
- (void)cleanup;
@end
