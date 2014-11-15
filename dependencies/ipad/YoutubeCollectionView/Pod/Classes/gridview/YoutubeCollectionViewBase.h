//
//  YoutubeCollectionViewBase.h
//  YoutubePlayApp
//
//  Created by djzhang on 10/15/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YoutubeConstants.h"
@class GYoutubeRequestInfo;


@interface YoutubeCollectionViewBase : UIViewController
@property(nonatomic, strong) GYoutubeRequestInfo * youtubeRequestInfo;

@property(nonatomic) NSUInteger hasLoadingMore;
@property(nonatomic, strong) NSMutableArray * videoList;
@property(strong, nonatomic) UICollectionView * collectionView;

- (void)search:(NSString *)text;
- (void)search:(NSString *)text withItemType:(YTSegmentItemType)itemType;
- (void)searchByPageToken;
- (void)endPullToRefreshWithResponse:(NSArray *)array;
- (void)cleanup;
- (void)cleanupAndStartPullToRefreshWithItemType:(YTSegmentItemType)itemType;
- (void)fetchListByType:(enum YTSegmentItemType)type withChannelId:(NSString * )channelId;
@end
