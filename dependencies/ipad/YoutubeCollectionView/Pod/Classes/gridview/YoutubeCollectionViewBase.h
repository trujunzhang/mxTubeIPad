//
//  YoutubeCollectionViewBase.h
//  YoutubePlayApp
//
//  Created by djzhang on 10/15/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GYoutubeRequestInfo.h"


@class GYoutubeRequestInfo;


@protocol YoutubeCollectionNextPageDelegate<NSObject>

@optional
- (void)executeRefreshTask;
- (void)executeNextPageTask;
@end


@interface YoutubeCollectionViewBase : UIViewController
@property(nonatomic, strong) GYoutubeRequestInfo * youtubeRequestInfo;


@property(nonatomic, assign) id<YoutubeCollectionNextPageDelegate> nextPageDelegate;

- (GYoutubeRequestInfo *)getYoutubeRequestInfo;
- (void)setUICollectionView:(UICollectionView *)collectionView;
- (void)search:(NSString *)text withItemType:(YTSegmentItemType)itemType;
- (void)searchByPageToken;
- (void)cleanup;
- (void)fetchActivityListByType:(YTSegmentItemType)type withChannelId:(NSString *)channelId;
- (void)fetchActivityListByPageToken;
- (void)fetchPlayListByType:(YTPlaylistItemsType)playlistItemsType;
- (void)fetchPlayListByPageToken;
- (void)fetchSuggestionListByVideoId:(NSString *)videoId;
- (void)fetchSuggestionListByPageToken;
@end
