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


static const int THIRD_ROW_HEIGHT = 28;


@interface YTLeftRowTableViewCellNode () {

}

@property(nonatomic, strong) ASCacheNetworkImageNode * videoChannelThumbnailsNode;
@property(nonatomic, strong) ASTextNode * channelTitleTextNode;

@property(nonatomic, strong) ASDisplayNode * divider;

@end


@implementation YTLeftRowTableViewCellNode

- (instancetype)initWithNodeCellSize:(struct CGSize const)nodeCellSize lineTitle:(NSString *)lineTitle lineIconUrl:(NSString *)lineIconUrl isRemoteImage:(BOOL)isRemoteImage {
   self = [super init];
   if (self) {
      self.nodeCellSize = nodeCellSize;
      self.lineTitle = lineTitle;
      self.lineIconUrl = lineIconUrl;
      self.isRemoteImage = isRemoteImage;


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
   self.backgroundColor = [UIColor clearColor];

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
   [self showSubscriptionThumbnail];
   // 2
   ASTextNode * channelTitleTextNode = [[ASTextNode alloc] init];
   channelTitleTextNode.attributedString = [NSAttributedString attributedStringForChannelTitleText:self.lineTitle];

   //MARK: Container Node Creation Section
   self.channelTitleTextNode = channelTitleTextNode;
   [self addSubnode:self.channelTitleTextNode];
}


- (void)showSubscriptionThumbnail {
   if (self.isRemoteImage) {
      ASCacheNetworkImageNode * cacheNetworkImageNode = [[ASCacheNetworkImageNode alloc] initForImageCache];
      [self.videoChannelThumbnailsNode startFetchImageWithString:self.lineIconUrl];

      self.videoChannelThumbnailsNode = cacheNetworkImageNode;
   } else {
      ASImageNode * localImageNode = [[ASImageNode alloc] init];
      NSString * iconUrl = self.lineIconUrl;
      UIImage * image = [UIImage imageNamed:iconUrl];
      self.videoChannelThumbnailsNode.image = image;

      self.videoChannelThumbnailsNode = localImageNode;
   }

   [self addSubnode:self.videoChannelThumbnailsNode];
}


- (void)layoutThirdForChannelInfo {
   self.videoChannelThumbnailsNode.frame = [FrameCalculator frameForLeftMenuSubscriptionThumbnail:self.bounds
                                                                                   thirdRowHeight:THIRD_ROW_HEIGHT];

   self.channelTitleTextNode.frame = [FrameCalculator frameForLeftMenuSubscriptionTitleText:self.bounds
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
