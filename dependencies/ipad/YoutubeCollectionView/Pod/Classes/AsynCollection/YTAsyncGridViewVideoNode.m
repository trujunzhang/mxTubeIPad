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
      [self layoutSubNodes];

      [self setupAllNodesEffect];
   }

   return self;
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


- (void)layoutSubNodes {
   //MARK: Node Layout Section
   self.frame = [FrameCalculator frameForContainer:self.nodeCellSize];

   [self layoutFirstForChannelClover];
   [self layoutSecondForChannelTitle];

//   self.descriptionTextNode.frame = [FrameCalculator frameForDescriptionText:self.bounds
//                                                           featureImageFrame:self.featureImageNode.frame];
//   self.gradientNode.frame = [FrameCalculator frameForGradient:self.featureImageNode.frame];
}


- (void)setupContainerNode {
   [self rowFirstForChannelClover];
   [self rowSecondForChannelTitle];
}


#pragma mark -
#pragma mark first row for channel clover


- (void)rowFirstForChannelClover {
   NSString * videoThumbnailsUrl = [YoutubeParser getVideoSnippetThumbnails:self.cardInfo];

   // 1
   ASCacheNetworkImageNode * videoChannelThumbnailsNode = [[ASCacheNetworkImageNode alloc] initForImageCache];
   [videoChannelThumbnailsNode startFetchImageWithString:videoThumbnailsUrl];

   // configure the button
   videoChannelThumbnailsNode.userInteractionEnabled = YES; // opt into touch handling
   [videoChannelThumbnailsNode addTarget:self
                                  action:@selector(channelThumbnailsTapped:)
                        forControlEvents:ASControlNodeEventTouchUpInside];

   self.videoCoverThumbnailsNode = videoChannelThumbnailsNode;
   [self addSubnode:self.videoCoverThumbnailsNode];
}


- (void)layoutFirstForChannelClover {
   self.videoCoverThumbnailsNode.frame = [FrameCalculator frameForChannelThumbnails:self.nodeCellSize
                                                                    nodeFrameHeight:142.0f];
}


#pragma mark -
#pragma mark second row for channel title


- (void)rowSecondForChannelTitle {
   NSString * videoTitleValue = self.cardInfo.snippet.title;
   NSString * channelTitleValue = self.cardInfo.snippet.channelTitle;
   // 2
   ASTextNode * titleTextNode = [[ASTextNode alloc] init];
   titleTextNode.attributedString = [NSAttributedString attributedStringForTitleText:videoTitleValue];


   ASTextNode * descriptionTextNode = [[ASTextNode alloc] init];
   descriptionTextNode.layerBacked = true;
   descriptionTextNode.backgroundColor = [UIColor clearColor];
   descriptionTextNode.attributedString =
    [NSAttributedString attributedStringForDescriptionText:channelTitleValue];

   //MARK: Container Node Creation Section
   self.titleTextNode = titleTextNode;
   [self addSubnode:self.titleTextNode];
}


- (void)layoutSecondForChannelTitle {
   self.titleTextNode.frame = [FrameCalculator frameForTitleText:self.bounds
                                               featureImageFrame:self.videoCoverThumbnailsNode.frame];
}


- (void)channelThumbnailsTapped:(id)buttonTapped {
   [self.delegate gridViewCellTap:self.cardInfo];
}


@end
