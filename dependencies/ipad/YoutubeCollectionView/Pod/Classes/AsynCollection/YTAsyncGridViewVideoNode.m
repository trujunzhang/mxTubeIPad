//
//  YTAsyncGridViewVideoNode.m
//  Layers
//
//  Created by djzhang on 11/25/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

#import "YTAsyncGridViewVideoNode.h"
#import "FrameCalculator.h"
#import "AnimatedContentsDisplayLayer.h"
#import "GradientNode.h"
#import "Foundation.h"
#import "HexColor.h"


@implementation YTAsyncGridViewVideoNode

- (instancetype)initWithCardInfo:(YTYouTubeVideoCache *)cardInfo cellSize:(CGSize)cellSize {
   self = [super initWithLayerClass:[AnimatedContentsDisplayLayer class]];
   if (self) {
      self.nodeCellSize = cellSize;
      self.cardInfo = cardInfo;

      [self initContentNode];
      [self setupContainerNode];
      [self addAllSubNodes];
      [self layoutNode];
   }

   return self;
}


- (CGSize)calculateSizeThatFits:(CGSize)constrainedSize {
   return CGSizeZero;
}


- (void)initContentNode {
   self.layerBacked = true;
   self.shouldRasterizeDescendants = true;

   self.backgroundColor = [UIColor whiteColor];

   self.borderColor = [UIColor colorWithHexString:@"DDD"].CGColor;
   self.borderWidth = 1;

   self.shadowColor = [UIColor colorWithHexString:@"B5B5B5"].CGColor;
   self.shadowOffset = CGSizeMake(1, 3);
   self.shadowRadius = 2.0;
}


- (void)layout {

}


- (void)layoutNode {
   //MARK: Node Layout Section
   self.frame = [FrameCalculator frameForContainer:self.nodeCellSize];

   self.featureImageNode.frame = [FrameCalculator frameForFeatureImage:self.nodeCellSize
                                                   containerFrameWidth:self.frame.size.width];
   self.titleTextNode.frame = [FrameCalculator frameForTitleText:self.bounds
                                               featureImageFrame:self.featureImageNode.frame];

   self.descriptionTextNode.frame = [FrameCalculator frameForDescriptionText:self.bounds
                                                           featureImageFrame:self.featureImageNode.frame];
   self.gradientNode.frame = [FrameCalculator frameForGradient:self.featureImageNode.frame];
}


- (ASDisplayNode *)setupContainerNode {
   NSString * videoThumbnailsUrl = self.cardInfo.snippet.thumbnails.medium.url;
   NSString * videoTitleValue = self.cardInfo.snippet.title;
   NSString * channelTitleValue = self.cardInfo.snippet.channelTitle;

   ASImageNode * featureImageNode = [[ASImageNode alloc] init];
   featureImageNode.layerBacked = true;
   featureImageNode.contentMode = UIViewContentModeScaleAspectFit;// .ScaleAspectFit
//   featureImageNode.image = self.image;

   ASTextNode * titleTextNode = [[ASTextNode alloc] init];
   titleTextNode.layerBacked = true;
   titleTextNode.backgroundColor = [UIColor clearColor];
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
   self.gradientNode = gradientNode;
   self.featureImageNode = featureImageNode;
   self.titleTextNode = titleTextNode;
   self.descriptionTextNode = descriptionTextNode;

   return self;
}


//MARK: Node Hierarchy Section
- (void)addAllSubNodes {
//   [self addSubnode:self.featureImageNode];
//   [self addSubnode:self.gradientNode];
//   [self addSubnode:self.titleTextNode];
//   [self addSubnode:self.descriptionTextNode];
}


@end
