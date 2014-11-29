//
// Created by djzhang on 11/24/14.
// Copyright (c) 2014 djzhang. All rights reserved.
//

#import "FrameCalculator.h"
#import "YoutubeParser.h"

#define textAreaHeight 300.0

#define textAreaPaddingX 8.0

//#define cardWidth 320.0


@implementation FrameCalculator {

}
- (instancetype)init {
   self = [super init];
   if (self) {

   }

   return self;
}


//+ (CGFloat)cardWidth {
//   return 320.0;
//}


+ (CGRect)frameForDescriptionText:(CGRect)containerBounds featureImageFrame:(CGRect)featureImageFrame {

   return CGRectMake(24.0, CGRectGetMaxY(featureImageFrame) + 20.0, containerBounds.size.width - 48.0, textAreaHeight);
}


+ (CGRect)frameForDivider:(CGRect)containerBounds thirdRowHeight:(CGFloat)thirdRowHeight {
   CGFloat divY = containerBounds.size.height - thirdRowHeight - 1;
   return CGRectMake(0.0f, divY, containerBounds.size.width, 1);
}


+ (CGRect)frameForChannelThumbnail:(CGRect)containerBounds thirdRowHeight:(CGFloat)thirdRowHeight {
   CGFloat titlePaddingTop = 2;

   CGFloat divX = 4;
   CGFloat divY = containerBounds.size.height - thirdRowHeight + titlePaddingTop;
   return CGRectMake(divX, divY, 20, 20);
}


+ (CGRect)frameForChannelTitleText:(CGRect)containerBounds thirdRowHeight:(CGFloat)thirdRowHeight leftNodeFrame:(CGRect)leftNodeFrame {
   CGFloat titlePaddingTop = 7;

   CGFloat divX = leftNodeFrame.origin.x + leftNodeFrame.size.width + 3;
   CGFloat divY = containerBounds.size.height - thirdRowHeight + titlePaddingTop;
   return CGRectMake(divX, divY, 180.0f, thirdRowHeight);
}


+ (CGRect)frameForTitleText:(CGRect)containerBounds featureImageFrame:(CGRect)featureImageFrame {
   CGFloat tY = featureImageFrame.origin.y + featureImageFrame.size.height + 6;
   return CGRectMake(textAreaPaddingX, tY, containerBounds.size.width - textAreaPaddingX * 2, 48);
}


+ (CGRect)frameForGradient:(CGRect)featureImageFrame {
   return featureImageFrame;
}


+ (CGRect)frameForFeatureImage:(CGSize)cellSize containerFrameWidth:(CGFloat)containerFrameWidth {
   CGSize imageFrameSize = [FrameCalculator aspectSizeForWidth:containerFrameWidth originalSize:cellSize];
   return CGRectMake(0, 0, imageFrameSize.width, imageFrameSize.height);
}


+ (CGRect)frameForChannelThumbnails:(CGSize)cellSize nodeFrameHeight:(CGFloat)nodeFrameHeight {
   return CGRectMake(0, 0, cellSize.width, nodeFrameHeight);
}


+ (CGFloat)calculateWidthForDurationLabel:(NSString *)labelText {
   float widthIs =
    [labelText
     boundingRectWithSize:CGSizeZero
                  options:NSStringDrawingUsesLineFragmentOrigin
               attributes:@{ NSFontAttributeName : [UIFont boldSystemFontOfSize:12] }
                  context:nil].size.width;

   return widthIs;
}


+ (CGRect)frameForDurationWithCloverSize:(CGSize)cloverSize withDurationWidth:(CGFloat)durationWidthIs {
   CGFloat durationHeight = 18;
   return CGRectMake(cloverSize.width - durationWidthIs, cloverSize.height - durationHeight - 2, durationWidthIs, durationHeight);
}


+ (CGRect)frameForBackgroundImage:(CGRect)containerBounds {
   return containerBounds;
}


+ (CGRect)frameForContainer:(CGSize)cellSize {
//   CGFloat containerWidth = [FrameCalculator cardWidth];
//   CGSize size = [FrameCalculator sizeThatFits:CGSizeMake(containerWidth, CGFLOAT_MAX)
//                                 withImageSize:cellSize];
   return CGRectMake(0, 0, cellSize.width, cellSize.height);
}


+ (CGSize)sizeThatFits:(CGSize)size withImageSize:(CGSize)imageSize {
   CGSize imageFrameSize = [FrameCalculator aspectSizeForWidth:size.width originalSize:imageSize];
   return CGSizeMake(size.width, imageFrameSize.height + textAreaHeight);
}


+ (CGSize)aspectSizeForWidth:(CGFloat)width originalSize:(CGSize)originalSize {
   CGFloat height = ceil((originalSize.height / originalSize.width) * width);
   return CGSizeMake(width, height);
}


@end