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
#import "ASDisplayNode+Subclasses.h"


@interface YTAsyncGridViewVideoNode ()<ASImageCacheProtocol, ASImageDownloaderProtocol> {

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
   NSString * videoTitleValue = self.cardInfo.snippet.title;
   NSString * channelTitleValue = self.cardInfo.snippet.channelTitle;

   YTYouTubeVideoCache * video = self.cardInfo;

   // 1
   ASNetworkImageNode * videoChannelThumbnailsNode = [[ASNetworkImageNode alloc] initWithCache:self downloader:self];
   videoChannelThumbnailsNode.URL = [NSURL URLWithString:videoThumbnailsUrl];

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
   [self.delegate gridViewCellTap:self.cardInfo];
}


#pragma mark -
#pragma mark ASImageCacheProtocol


- (void)fetchCachedImageWithURL:(NSURL *)URL
                  callbackQueue:(dispatch_queue_t)callbackQueue
                     completion:(void (^)(CGImageRef imageFromCache))completion {
   UIImage * cacheImage = [ImageCacheImplement getCacheImageWithURL:URL];
   completion([cacheImage CGImage]);
}


#pragma mark -
#pragma mark ASImageDownloaderProtocol


- (id)downloadImageWithURL:(NSURL *)URL
             callbackQueue:(dispatch_queue_t)callbackQueue
     downloadProgressBlock:(void (^)(CGFloat progress))downloadProgressBlock
                completion:(void (^)(CGImageRef image, NSError * error))completion {
   // if no callback queue is supplied, run on the main thread
   if (callbackQueue == nil) {
      callbackQueue = dispatch_get_main_queue();
   }

   CacheCompletionBlock downloadCompletion = ^(UIImage * downloadedImage) {
       // ASMultiplexImageNode callbacks
       dispatch_async(callbackQueue, ^{
           if (downloadProgressBlock) {
              downloadProgressBlock(1.0f);
           }

           if (completion) {
              completion([downloadedImage CGImage], nil);
           }
       });
   };
   [ImageCacheImplement CacheWithUrl:URL withCompletionBlock:downloadCompletion];

   return nil;
}


- (void)cancelImageDownloadForIdentifier:(id)downloadIdentifier {

}


@end
