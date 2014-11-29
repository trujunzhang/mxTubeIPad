//
// Created by djzhang on 11/24/14.
// Copyright (c) 2014 djzhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface FrameCalculator : NSObject

+ (CGFloat)cardWidth;
+ (CGRect)frameForDescriptionText:(CGRect)containerBounds featureImageFrame:(CGRect)featureImageFrame;
+ (CGRect)frameForChannelThumbnails:(CGRect)containerBounds featureImageFrame:(CGRect)featureImageFrame;
+ (CGRect)frameForTitleText:(CGRect)containerBounds featureImageFrame:(CGRect)featureImageFrame;
+ (CGRect)frameForGradient:(CGRect)featureImageFrame;

+ (CGRect)frameForFeatureImage:(CGSize)featureImageSize containerFrameWidth:(CGFloat)containerFrameWidth;

+ (CGRect)frameForChannelThumbnails:(CGSize)featureImageSize nodeFrameHeight:(CGFloat)nodeFrameHeight;
+ (CGFloat)calculateWidthForDurationLabel:(NSString *)labelText;
+ (CGRect)frameForDurationWithCloverSize:(CGSize)cloverSize withDurationWidth:(CGFloat)durationWidthIs;
+ (CGRect)frameForBackgroundImage:(CGRect)containerBounds;
+ (CGRect)frameForContainer:(CGSize)featureImageSize;
+ (CGSize)sizeThatFits:(CGSize)size withImageSize:(CGSize)imageSize;
+ (CGSize)aspectSizeForWidth:(CGFloat)width originalSize:(CGSize)originalSize;
@end