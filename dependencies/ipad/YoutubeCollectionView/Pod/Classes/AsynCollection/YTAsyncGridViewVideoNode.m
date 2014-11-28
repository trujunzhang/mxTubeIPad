//
//  YTAsyncGridViewVideoNode.m
//  Layers
//
//  Created by djzhang on 11/25/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

#import <IOS_Collection_Code/ImageCacheImplement.h>
#import <YoutubeCollectionView/IpadGridViewCell.h>
#import "YTAsyncGridViewVideoNode.h"
#import "FrameCalculator.h"
#import "AnimatedContentsDisplayLayer.h"
#import "GradientNode.h"
#import "Foundation.h"
#import "HexColor.h"
#import "UIColor+iOS8Colors.h"
#import "YoutubeParser.h"
#import "ASCacheNetworkImageNode.h"


@interface YTAsyncGridViewVideoNode () {

}
@end


@implementation YTAsyncGridViewVideoNode

- (instancetype)initWithCardInfo:(YTYouTubeVideoCache *)cardInfo cellSize:(CGSize)cellSize delegate:(id<IpadGridViewCellDelegate>)delegate {
   self = [super initWithLayerClass:[AnimatedContentsDisplayLayer class]];
   if (self) {
      self.nodeCellSize = cellSize;
      self.cardInfo = cardInfo;
      self.delegate = delegate;

      [self setupContainerNode];
      [self addAllSubNodes];
      [self layoutNode];

      [self initContentNode];
   }

   return self;
}


- (void)initContentNode {
   // 1
   self.layerBacked = true;

   // 1.1
   self.backgroundColor = [UIColor whiteColor];

   // 1.2
   self.shadowColor = [UIColor colorWithHexString:@"B5B5B5" alpha:0.8].CGColor;
   self.shadowOffset = CGSizeMake(1, 3);
   self.shadowOpacity = 1.0;
   self.shadowRadius = 2.0;

   // 2
   self.videoCoverThumbnailsNode.layerBacked = true;
   self.videoCoverThumbnailsNode.contentMode = UIViewContentModeScaleAspectFit;// .ScaleAspectFit

   // 2.1
   self.videoCoverThumbnailsNode.backgroundColor = [UIColor iOS8silverGradientStartColor];

   // 2.2
   self.videoCoverThumbnailsNode.borderColor = [UIColor colorWithHexString:@"DDD"].CGColor;
   self.videoCoverThumbnailsNode.borderWidth = 1;

   self.videoCoverThumbnailsNode.shadowColor = [UIColor colorWithHexString:@"B5B5B5"].CGColor;
   self.videoCoverThumbnailsNode.shadowOffset = CGSizeMake(1, 3);
   self.videoCoverThumbnailsNode.shadowRadius = 2.0;

   // 3
   self.titleTextNode.layerBacked = true;
   self.titleTextNode.backgroundColor = [UIColor clearColor];
}


- (void)layoutNode {
   //MARK: Node Layout Section
   self.frame = [FrameCalculator frameForContainer:self.nodeCellSize];

   self.videoCoverThumbnailsNode.frame = [FrameCalculator frameForChannelThumbnails:self.nodeCellSize
                                                                      nodeFrameHeight:142.0f];

   self.titleTextNode.frame = [FrameCalculator frameForTitleText:self.bounds
                                               featureImageFrame:self.videoCoverThumbnailsNode.frame];

//   self.descriptionTextNode.frame = [FrameCalculator frameForDescriptionText:self.bounds
//                                                           featureImageFrame:self.featureImageNode.frame];
//   self.gradientNode.frame = [FrameCalculator frameForGradient:self.featureImageNode.frame];
}


- (void)setupContainerNode {

   NSString * videoThumbnailsUrl = [YoutubeParser getVideoSnippetThumbnails:self.cardInfo];
   NSString * videoTitleValue = self.cardInfo.snippet.title;
   NSString * channelTitleValue = self.cardInfo.snippet.channelTitle;

   YTYouTubeVideoCache * video = self.cardInfo;

   // 1
   ASCacheNetworkImageNode * videoChannelThumbnailsNode = [[ASCacheNetworkImageNode alloc] initForImageCache];
   [videoChannelThumbnailsNode startFetchImageWithString:videoThumbnailsUrl];

   // configure the button
   videoChannelThumbnailsNode.userInteractionEnabled = YES; // opt into touch handling
   [videoChannelThumbnailsNode addTarget:self
                                  action:@selector(channelThumbnailsTapped:)
                        forControlEvents:ASControlNodeEventTouchUpInside];

   // 2
   ASTextNode * titleTextNode = [[ASTextNode alloc] init];
   titleTextNode.attributedString = [NSAttributedString attributedStringForTitleText:videoTitleValue];


   ASTextNode * descriptionTextNode = [[ASTextNode alloc] init];
   descriptionTextNode.layerBacked = true;
   descriptionTextNode.backgroundColor = [UIColor clearColor];
   descriptionTextNode.attributedString =
    [NSAttributedString attributedStringForDescriptionText:channelTitleValue];

   GradientNode * gradientNode = [[GradientNode alloc] init];
   gradientNode.opaque = false;
   gradientNode.layerBacked = true;

   //MARK: Container Node Creation Section
   self.videoCoverThumbnailsNode = videoChannelThumbnailsNode;
   self.titleTextNode = titleTextNode;
//   self.descriptionTextNode = descriptionTextNode;
}


//MARK: Node Hierarchy Section
- (void)addAllSubNodes {
   [self addSubnode:self.videoCoverThumbnailsNode];
   [self addSubnode:self.titleTextNode];
//   [self addSubnode:self.descriptionTextNode];
}


- (void)channelThumbnailsTapped:(id)buttonTapped {
   [self.delegate gridViewCellTap:self.cardInfo];
}


@end
