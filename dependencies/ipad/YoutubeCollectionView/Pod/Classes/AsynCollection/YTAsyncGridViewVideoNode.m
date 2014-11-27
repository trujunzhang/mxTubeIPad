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
   self.shouldRasterizeDescendants = true;

   // 1.1
   self.backgroundColor = [UIColor whiteColor];

   // 1.2
//   self.borderColor = [UIColor colorWithHexString:@"DDD"].CGColor;
//   self.borderWidth = 1;

   self.shadowColor = [UIColor colorWithHexString:@"B5B5B5" alpha:0.6].CGColor;
   self.shadowOffset = CGSizeMake(1, 3);
   self.shadowRadius = 2.0;

   // 2
   self.videoChannelThumbnailsNode.layerBacked = true;
   self.videoChannelThumbnailsNode.contentMode = UIViewContentModeScaleAspectFit;// .ScaleAspectFit

   // 2.1
   self.videoChannelThumbnailsNode.backgroundColor = [UIColor iOS8silverGradientStartColor];

   // 2.2
   self.videoChannelThumbnailsNode.borderColor = [UIColor colorWithHexString:@"DDD"].CGColor;
   self.videoChannelThumbnailsNode.borderWidth = 1;

   self.videoChannelThumbnailsNode.shadowColor = [UIColor colorWithHexString:@"B5B5B5"].CGColor;
   self.videoChannelThumbnailsNode.shadowOffset = CGSizeMake(1, 3);
   self.videoChannelThumbnailsNode.shadowRadius = 2.0;

   // 3
   self.titleTextNode.layerBacked = true;
   self.titleTextNode.backgroundColor = [UIColor clearColor];
}


- (void)layout {

}


- (void)layoutNode {
   //MARK: Node Layout Section
   self.frame = [FrameCalculator frameForContainer:self.nodeCellSize];

   self.videoChannelThumbnailsNode.frame = [FrameCalculator frameForChannelThumbnails:self.nodeCellSize
                                                                      nodeFrameHeight:142.0f];

   self.titleTextNode.frame = [FrameCalculator frameForTitleText:self.bounds
                                               featureImageFrame:self.videoChannelThumbnailsNode.frame];

//   self.descriptionTextNode.frame = [FrameCalculator frameForDescriptionText:self.bounds
//                                                           featureImageFrame:self.featureImageNode.frame];
//   self.gradientNode.frame = [FrameCalculator frameForGradient:self.featureImageNode.frame];
}


- (void)setupContainerNode {

   NSString * videoThumbnailsUrl = [YoutubeParser getVideoSnippetThumbnails:self.cardInfo];
//    self.cardInfo.snippet.thumbnails.medium.url;
   NSString * videoTitleValue = self.cardInfo.snippet.title;
   NSString * channelTitleValue = self.cardInfo.snippet.channelTitle;

   YTYouTubeVideoCache * video = self.cardInfo;

   ASImageNode * videoChannelThumbnailsNode = [[ASImageNode alloc] init];
   if (video.hasImage) {
      videoChannelThumbnailsNode.image = video.image;
   } else {
      void (^downloadCompletion)(UIImage *) = ^(UIImage * image) {
          video.hasImage = YES;
          video.image = image;
          videoChannelThumbnailsNode.image = video.image;
      };
      [ImageCacheImplement CacheWithImageView:videoChannelThumbnailsNode
                                          key:video.identifier
                                      withUrl:videoThumbnailsUrl
                              withPlaceholder:nil
                                   completion:downloadCompletion
      ];
   }

   // configure the button
   videoChannelThumbnailsNode.userInteractionEnabled = YES; // opt into touch handling
   [videoChannelThumbnailsNode addTarget:self
                                  action:@selector(channelThumbnailsTapped:)
                        forControlEvents:ASControlNodeEventTouchUpInside];


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
   self.videoChannelThumbnailsNode = videoChannelThumbnailsNode;
   self.titleTextNode = titleTextNode;
//   self.descriptionTextNode = descriptionTextNode;
}


//MARK: Node Hierarchy Section
- (void)addAllSubNodes {
   [self addSubnode:self.videoChannelThumbnailsNode];
   [self addSubnode:self.titleTextNode];
//   [self addSubnode:self.descriptionTextNode];
}


- (void)channelThumbnailsTapped:(id)buttonTapped {
   [self.delegate gridViewCellTap:self.cardInfo sender:self.delegate];
}


@end
