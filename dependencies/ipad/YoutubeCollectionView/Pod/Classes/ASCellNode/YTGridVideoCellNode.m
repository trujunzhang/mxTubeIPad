//
//  YTGridVideoCellNode.m
//  IOSTemplate
//
//  Created by djzhang on 11/17/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import <YoutubeCollectionView/IpadGridViewCell.h>
#import "YTGridVideoCellNode.h"


@implementation YTGridVideoCellNode


- (instancetype)init {
   if (!(self = [super init]))
      return nil;

//   _textNode = [[ASTextNode alloc] init];
//   [self addSubnode:_textNode];

   return self;
}


- (CGSize)calculateSizeThatFits:(CGSize)constrainedSize {
//   CGSize availableSize = CGSizeMake(constrainedSize.width - 2 * kHorizontalPadding, constrainedSize.height - 2 * kVerticalPadding);
//   CGSize textNodeSize = [_textNode measure:availableSize];

//   return CGSizeMake(textNodeSize.width), ceilf(2 * kVerticalPadding + textNodeSize.height));
   CGSize size;
   return size;
}


- (void)layout {
//   _textNode.frame = CGRectInset(self.bounds, kHorizontalPadding, kVerticalPadding);
}


- (void)bind:(YTYouTubeVideo *)video placeholderImage:(UIImage *)placeholder delegate:(id<IpadGridViewCellDelegate>)delegate {
   self.video = video;
   self.delegate = delegate;


}

@end
