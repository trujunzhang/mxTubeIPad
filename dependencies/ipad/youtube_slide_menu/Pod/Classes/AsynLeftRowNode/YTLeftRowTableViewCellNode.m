//
//  YTLeftRowTableViewCellNode.m
//  Layers
//
//  Created by djzhang on 11/25/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

#import <IOS_Collection_Code/ImageCacheImplement.h>
#import <YoutubeCollectionView/IpadGridViewCell.h>
#import "YTLeftRowTableViewCellNode.h"
#import "FrameCalculator.h"
#import "AnimatedContentsDisplayLayer.h"
#import "Foundation.h"
#import "HexColor.h"
#import "UIColor+iOS8Colors.h"
#import "YoutubeParser.h"
#import "ASCacheNetworkImageNode.h"
#import "GYoutubeHelper.h"


static const int FIRST_ROW_HEIGHT = 142;
static const int THIRD_ROW_HEIGHT = 28;


@interface YTLeftRowTableViewCellNode () {

}

@property(nonatomic, strong) ASCacheNetworkImageNode * videoChannelThumbnailsNode;
@property(nonatomic, strong) ASTextNode * channelTitleTextNode;

@property(nonatomic, strong) ASDisplayNode * divider;

@end


@implementation YTLeftRowTableViewCellNode

- (instancetype)initWithCardInfo:(YTYouTubeVideoCache *)cardInfo cellSize:(CGSize)cellSize delegate:(id<IpadGridViewCellDelegate>)delegate {
   self = [super initWithLayerClass:[AnimatedContentsDisplayLayer class]];
   if (self) {
      self.nodeCellSize = cellSize;
      self.cardInfo = cardInfo;

      [self rowThirdForChannelInfo];
      [self layoutSubNodes];

      [self setupAllNodesEffect];
   }

   return self;
}


#pragma mark -
#pragma mark Setup sub nodes.


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

   [self effectThirdForChannelInfo];
}


- (void)layoutSubNodes {
   //MARK: Node Layout Section
   self.frame = [FrameCalculator frameForContainer:self.nodeCellSize];

   [self layoutThirdForChannelInfo];
}


#pragma mark -
#pragma mark third row for channel title.(Row N03)


- (void)rowThirdForChannelInfo {
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


- (void)showChannelThumbnail:(NSString *)channelId {
   // 1
   self.videoChannelThumbnailsNode = [[ASCacheNetworkImageNode alloc] initForImageCache];
   if (self.cardInfo.channelThumbnailUrl) {
      [self.videoChannelThumbnailsNode startFetchImageWithString:self.cardInfo.channelThumbnailUrl];
      return;
   }

   YoutubeResponseBlock completionBlock = ^(NSArray * array, NSObject * respObject) {
       self.cardInfo.channelThumbnailUrl = respObject;
       [self.videoChannelThumbnailsNode startFetchImageWithString:self.cardInfo.channelThumbnailUrl];
   };
   [[GYoutubeHelper getInstance] fetchChannelThumbnailsWithChannelId:channelId
                                                          completion:completionBlock
                                                        errorHandler:nil];

   [self addSubnode:self.videoChannelThumbnailsNode];
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
