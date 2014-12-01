//
//  YTAsyncYoutubeChannelTopCellNode.m
//  IOSTemplate
//
//  Created by djzhang on 11/12/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import "YTAsyncYoutubeChannelTopCellNode.h"

#import <google-api-services-youtube/GYoutubeHelper.h>
#import "YoutubeParser.h"
#import "FrameCalculator.h"
#import "ASCacheNetworkImageNode.h"
#import "HexColor.h"
#import "UIColor+iOS8Colors.h"


@interface YTAsyncYoutubeChannelTopCellNode () {
}
// line01
@property(nonatomic, strong) ASCacheNetworkImageNode * channelBannerThumbnailNodse;
@property(nonatomic, strong) ASCacheNetworkImageNode * videoChannelThumbnailsNode;

@end


@implementation YTAsyncYoutubeChannelTopCellNode

- (instancetype)initWithSubscription:(YTYouTubeSubscription *)subscription {
   self = [super init];
   if (self) {
      self.subscription = subscription;

      [self setupContainerNode];
      [self layoutSubNodes];

      [self setupAllNodesEffect];
   }

   return self;
}


#pragma mark -
#pragma mark Setup sub nodes.


- (void)setupContainerNode {
   [self rowFirstForChannelBanner];
   [self rowSecondForChannelInfo];
}


- (void)setupAllNodesEffect {

   // 1
   self.layerBacked = true;

   // 1.1
   self.backgroundColor = [UIColor whiteColor];

   // 1.2
   self.shadowColor = [UIColor colorWithHexString:@"B5B5B5" alpha:0.8].CGColor;
   self.shadowOffset = CGSizeMake(1, 3);
   self.shadowOpacity = 1.0;
   self.shadowRadius = 2.0;

   [self effectFirstForChannelBanner];
   [self effectThirdForChannelInfo];
}


- (void)layoutSubNodes {
   //MARK: Node Layout Section
   self.frame = [FrameCalculator frameForContainer:self.nodeCellSize];

   [self layoutFirstForChannelBanner];
   [self layoutThirdForChannelInfo];
}


#pragma mark -
#pragma mark first row for channel clover.(Row N01)


- (void)rowFirstForChannelBanner {
   // 1
   ASCacheNetworkImageNode * channelBannerThumbnailNodse = [[ASCacheNetworkImageNode alloc] initForImageCache];
//   [channelBannerThumbnailNodse startFetchImageWithString:videoThumbnailsUrl];

   // configure the button
   channelBannerThumbnailNodse.userInteractionEnabled = YES; // opt into touch handling
   [channelBannerThumbnailNodse addTarget:self
                                   action:@selector(channelThumbnailsTapped:)
                         forControlEvents:ASControlNodeEventTouchUpInside];

   self.channelBannerThumbnailNodse = channelBannerThumbnailNodse;
   [self addSubnode:self.channelBannerThumbnailNodse];

   // 2
   [self showChannelThumbnail:[YoutubeParser getSubscriptionSnippetThumbnailUrl:self.subscription]];
}


- (void)showChannelThumbnail:(NSString *)channelThumbnailUrl {
   self.videoChannelThumbnailsNode = [[ASCacheNetworkImageNode alloc] initForImageCache];
   [self.videoChannelThumbnailsNode startFetchImageWithString:channelThumbnailUrl];

   [self addSubnode:self.videoChannelThumbnailsNode];
}


- (void)layoutFirstForChannelBanner {
//   self.channelBannerThumbnailNodse.frame = [FrameCalculator frameForChannelThumbnails:self.nodeCellSize
//                                                                       nodeFrameHeight:142.0f];

//   self.videoChannelThumbnailsNode.frame = [FrameCalculator frameForDurationWithCloverSize:self.channelBannerThumbnailNodse.frame.size
//                                                                         withDurationWidth:self.durationLabelWidth];
}


- (void)effectFirstForChannelBanner {
   // 2
   self.channelBannerThumbnailNodse.layerBacked = true;
   self.channelBannerThumbnailNodse.contentMode = UIViewContentModeScaleAspectFit;// .ScaleAspectFit

   // 2.1
   self.channelBannerThumbnailNodse.backgroundColor = [UIColor iOS8silverGradientStartColor];

   // 2.2
   self.channelBannerThumbnailNodse.borderColor = [UIColor colorWithHexString:@"DDD"].CGColor;
   self.channelBannerThumbnailNodse.borderWidth = 1;

   self.channelBannerThumbnailNodse.shadowColor = [UIColor colorWithHexString:@"B5B5B5"].CGColor;
   self.channelBannerThumbnailNodse.shadowOffset = CGSizeMake(1, 3);
   self.channelBannerThumbnailNodse.shadowRadius = 2.0;


   // 3
   self.durationTextNode.layerBacked = true;
}


#pragma mark -
#pragma mark second row for channel title.(Row N02)


- (void)rowSecondForChannelInfo {
   // 1
   [self showChannelThumbnail:[YoutubeParser getChannelIdByVideo:self.cardInfo]];

   NSString * channelTitleValue = self.cardInfo.snippet.channelTitle;
   // 2
   ASTextNode * channelTitleTextNode = [[ASTextNode alloc] init];
   channelTitleTextNode.attributedString = [NSAttributedString attributedStringForChannelTitleText:channelTitleValue];

   //MARK: Container Node Creation Section
   self.channelTitleTextNode = channelTitleTextNode;
   [self addSubnode:self.channelTitleTextNode];
}


- (void)layoutThirdForChannelInfo {
   self.videoChannelThumbnailsNode.frame = [FrameCalculator frameForChannelThumbnail:self.bounds
                                                                      thirdRowHeight:THIRD_ROW_HEIGHT];

   self.channelTitleTextNode.frame = [FrameCalculator frameForChannelTitleText:self.bounds
                                                                thirdRowHeight:THIRD_ROW_HEIGHT
                                                                 leftNodeFrame:self.videoChannelThumbnailsNode.frame];
}


- (void)effectThirdForChannelInfo {
   // 4
   self.videoChannelThumbnailsNode.layerBacked = true;

   // 3
   self.channelTitleTextNode.layerBacked = true;
   self.channelTitleTextNode.backgroundColor = [UIColor clearColor];
}


@end
