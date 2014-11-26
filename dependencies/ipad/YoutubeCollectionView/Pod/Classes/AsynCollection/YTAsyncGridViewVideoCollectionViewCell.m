//
//  YTAsyncGridViewVideoCollectionViewCell.m
//  Layers
//
//  Created by djzhang on 11/25/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//


#import <YoutubeCollectionView/IpadGridViewCell.h>
#import "YTAsyncGridViewVideoCollectionViewCell.h"
#import "FrameCalculator.h"
#import "YTAsyncGridViewVideoNode.h"


@implementation YTAsyncGridViewVideoCollectionViewCell

- (void)awakeFromNib {
   [super awakeFromNib];

   CALayer * placeholderLayer = [[CALayer alloc] init];
   placeholderLayer.contents = [UIImage imageNamed:@"cardPlaceholder"];
   placeholderLayer.contentsGravity = kCAGravityCenter;
   placeholderLayer.contentsScale = [UIScreen mainScreen].scale;
   placeholderLayer.backgroundColor = [UIColor colorWithHue:0
                                                 saturation:0
                                                 brightness:0.85
                                                      alpha:1].CGColor;
   [self.contentView.layer addSublayer:placeholderLayer];
}


- (CGSize)sizeThatFits:(CGSize)size {
   CGSize featureImageSize = self.featureImageSizeOptional;
   if (!CGSizeEqualToSize(CGSizeZero, featureImageSize))
      return [FrameCalculator sizeThatFits:size withImageSize:featureImageSize];

   return CGSizeZero;
}


- (void)layoutSubviews {
   [super layoutSubviews];

   [CATransaction begin];
   [CATransaction setValue:(id) kCFBooleanTrue
                    forKey:kCATransactionDisableActions];
   self.placeholderLayer.frame = self.bounds;
   [CATransaction commit];
}


//MARK: Cell Reuse
- (void)prepareForReuse {
   [super prepareForReuse];

   NSOperation * operation = _nodeConstructionOperation;
   if (operation)
      [operation cancel];

   [_containerNode recursiveSetPreventOrCancelDisplay:YES];
   [_contentLayer removeFromSuperlayer];
   _contentLayer = nil;
   _containerNode = nil;
}


- (void)bind:(YTYouTubeVideoCache *)videoInfo placeholderImage:(UIImage *)placeholder cellSize:(CGSize)cellSize delegate:(id<IpadGridViewCellDelegate>)delegate nodeConstructionQueue:(NSOperationQueue *)nodeConstructionQueue {
   self.featureImageSizeOptional=cellSize;
   NSOperation * oldNodeConstructionOperation = _nodeConstructionOperation;
   if (oldNodeConstructionOperation)
      [oldNodeConstructionOperation cancel];


   NSOperation * newNodeConstructionOperation = [self nodeConstructionOperationWithCardInfo:videoInfo
                                                                                      image:placeholder];

   _nodeConstructionOperation = newNodeConstructionOperation;
   [nodeConstructionQueue addOperation:newNodeConstructionOperation];
}


- (NSOperation *)nodeConstructionOperationWithCardInfo:(YTYouTubeVideoCache *)cardInfo image:(UIImage *)image {
   NSBlockOperation * nodeConstructionOperation = [[NSBlockOperation alloc] init];

   void (^cellExecutionBlock)() = ^{
       if (nodeConstructionOperation.cancelled)
          return;

       YTAsyncGridViewVideoNode * containerNode = [[YTAsyncGridViewVideoNode alloc] initWithCardInfo:cardInfo
                                                                                            cellSize:self.featureImageSizeOptional];

       if (nodeConstructionOperation.cancelled)
          return;

       __weak typeof(self) weakSelf = self;
       dispatch_async(dispatch_get_main_queue(), ^{
           __strong typeof(weakSelf) strongSelf = weakSelf;
           NSBlockOperation * strongNodeConstructionOperation = strongSelf.nodeConstructionOperation;
           if (strongNodeConstructionOperation.cancelled)
              return;

           if (self.nodeConstructionOperation != strongNodeConstructionOperation)
              return;

           if (containerNode.preventOrCancelDisplay)
              return;

           //MARK: Node Layer and Wrap Up Section
           [self.contentView.layer addSublayer:containerNode.layer];
           [containerNode setNeedsDisplay];
           self.contentLayer = containerNode.layer;
           self.containerNode = containerNode;
       });
   };

   [nodeConstructionOperation addExecutionBlock:cellExecutionBlock];
   [nodeConstructionOperation start];

   return nodeConstructionOperation;
}


@end
