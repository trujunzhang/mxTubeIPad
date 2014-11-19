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


@protocol YoutubeCollectionNextPageDelegate<NSObject>

@optional
- (void)executeRefreshTask;
- (void)executeNextPageTask;
@end


@interface YoutubeCollectionViewBase : UIViewController
@property(nonatomic, strong) GYoutubeRequestInfo * youtubeRequestInfo;


@property(nonatomic, assign) id<YoutubeCollectionNextPageDelegate> nextPageDelegate;

- (GYoutubeRequestInfo *)getYoutubeRequestInfo;
- (void)search:(NSString *)text withItemType:(YTSegmentItemType)itemType;
- (void)searchByPageToken;
- (void)cleanup;
- (void)fetchActivityListByType:(enum YTSegmentItemType)type withChannelId:(NSString *)channelId;
- (void)fetchActivityListByPageToken;
- (void)fetchPlayListByType:(enum YTPlaylistItemsType)playlistItemsType;
- (void)fetchPlayListByPageToken;
- (void)fetchSuggestionListByVideoId:(NSString *)videoId;
- (void)fetchSuggestionListByPageToken;
@end
