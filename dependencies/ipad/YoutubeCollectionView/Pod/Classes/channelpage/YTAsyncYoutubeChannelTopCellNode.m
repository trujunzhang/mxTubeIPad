//
//  YTAsyncYoutubeChannelTopCellNode.m
//  IOSTemplate
//
//  Created by djzhang on 11/12/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import <google-api-services-youtube/GYoutubeHelper.h>
#import "YTAsyncYoutubeChannelTopCellNode.h"

#import "YoutubeParser.h"
#import "FrameCalculator.h"
#import "ASCacheNetworkImageNode.h"
#import "HexColor.h"
#import "UIColor+iOS8Colors.h"
#import "Foundation.h"

static const int TOP_CHANNEL_SECOND_ROW_HEIGHT = 42;


@interface YTAsyncYoutubeChannelTopCellNode () {
}
@property(nonatomic) CGSize nodeCellSize;

// line01
@property(nonatomic, strong) ASCacheNetworkImageNode * channelBannerThumbnailNode;
@property(nonatomic, strong) ASCacheNetworkImageNode * channelThumbnailsNode;

// line02
@property(nonatomic, strong) ASTextNode * channelTitleTextNode;
@end


@implementation YTAsyncYoutubeChannelTopCellNode

- (instancetype)initWithSubscription:(GTLYouTubeSubscription *)subscription cellSize:(CGSize)cellSize {
   self = [super init];
   if (self) {
      self.subscription = subscription;
      self.nodeCellSize = cellSize;

      [self setupContainerNode];
      [self setupAllNodesEffect];

      [self setupAllBackup];
   }

   return self;
}


- (void)setupAllBackup {
//   self.layerBacked = true;

//   self.channelBannerThumbnailNode.layerBacked = true;
//   self.channelThumbnailsNode.layerBacked = true;
//   self.channelTitleTextNode.layerBacked = true;
}


// perform expensive sizing operations on a background thread
//- (CGSize)calculateSizeThatFits:(CGSize)constrainedSize {// used
////   return CGSizeMake(constrainedSize.width, self.nodeCellSize.height);
//   return constrainedSize;
//}


// do as little work as possible in main-thread layout
//856,135 (horizontal)
//600,135 (vertical)
- (void)layoutNodes:(CGSize)cellSize {
   self.nodeCellSize = cellSize;
   [self layoutSubNodes];

   NSLog(@"Pretty printed size: %@", NSStringFromCGSize(cellSize));
   NSString * debug = @"debug";
}


#pragma mark -
#pragma mark Setup sub nodes.


- (void)setupContainerNode {
   [self rowFirstForChannelBanner];
   [self rowSecondForChannelInfo];
}


- (void)setupAllNodesEffect {

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
   ASCacheNetworkImageNode * channelBannerThumbnailNode = [[ASCacheNetworkImageNode alloc] initForImageCache];

   YoutubeResponseBlock completion = ^(NSArray * array, NSObject * respObject) {
       self.currentChannel = array[0];
       NSString * videoThumbnailsUrl = [YoutubeParser getChannelBannerImageUrl:self.currentChannel];

       [channelBannerThumbnailNode startFetchImageWithString:videoThumbnailsUrl];
   };
   ErrorResponseBlock error = ^(NSError * error) {
       NSString * debug = @"debug";
   };
   [[GYoutubeHelper getInstance] fetchChannelBrandingWithChannelId:[YoutubeParser getChannelIdBySubscription:self.subscription]
                                                        completion:completion
                                                      errorHandler:error];

   // 1

//   NSString * videoThumbnailsUrl = @"https://yt3.ggpht.com/-0lqcsLOqjOw/VDzgY9uZdvI/AAAAAAAAAHU/1QBKBB6DI8I/w1060-fcrop64=1,00005a57ffffa5a8-nd/tv_youtube_channel_big.png";
   channelBannerThumbnailNode.contentMode = UIViewContentModeScaleAspectFill;

   self.channelBannerThumbnailNode = channelBannerThumbnailNode;
   [self addSubnode:self.channelBannerThumbnailNode];

   // 2
   [self showChannelThumbnail:[YoutubeParser getSubscriptionSnippetThumbnailUrl:self.subscription]];
}


- (void)showChannelThumbnail:(NSString *)channelThumbnailUrl {
   self.channelThumbnailsNode = [[ASCacheNetworkImageNode alloc] initForImageCache];
   [self.channelThumbnailsNode startFetchImageWithString:channelThumbnailUrl];

   [self addSubnode:self.channelThumbnailsNode];
}


- (void)layoutFirstForChannelBanner {
   self.channelBannerThumbnailNode.frame = [FrameCalculator frameForPageChannelBannerThumbnails:self.nodeCellSize
                                                                            secondRowFrameHeight:TOP_CHANNEL_SECOND_ROW_HEIGHT];

   self.channelThumbnailsNode.frame = [FrameCalculator frameForPageChannelThumbnails:self.channelBannerThumbnailNode.frame.size];
}


- (void)effectFirstForChannelBanner {
   // 2
   self.channelBannerThumbnailNode.contentMode = UIViewContentModeScaleAspectFit;// .ScaleAspectFit

   // 2.1
   self.channelBannerThumbnailNode.backgroundColor = [UIColor iOS8silverGradientStartColor];

   // 2.2
   self.channelBannerThumbnailNode.borderColor = [UIColor colorWithHexString:@"DDD"].CGColor;
   self.channelBannerThumbnailNode.borderWidth = 1;

   self.channelBannerThumbnailNode.shadowColor = [UIColor colorWithHexString:@"B5B5B5"].CGColor;
   self.channelBannerThumbnailNode.shadowOffset = CGSizeMake(1, 3);
   self.channelBannerThumbnailNode.shadowRadius = 2.0;
}


#pragma mark -
#pragma mark second row for channel title.(Row N02)


- (void)rowSecondForChannelInfo {
   NSString * channelTitleValue = self.subscription.snippet.title;
   // 1
   ASTextNode * channelTitleTextNode = [[ASTextNode alloc] init];
   channelTitleTextNode.attributedString = [NSAttributedString attributedStringForChannelTitleText:channelTitleValue];

   //MARK: Container Node Creation Section
   self.channelTitleTextNode = channelTitleTextNode;
   [self addSubnode:self.channelTitleTextNode];
}


- (void)layoutThirdForChannelInfo {
   self.channelTitleTextNode.frame = [FrameCalculator frameForPageChannelTitle:self.nodeCellSize
                                                          secondRowFrameHeight:TOP_CHANNEL_SECOND_ROW_HEIGHT];

}


- (void)effectThirdForChannelInfo {

   // 3
   self.channelTitleTextNode.backgroundColor = [UIColor clearColor];
}


@end
