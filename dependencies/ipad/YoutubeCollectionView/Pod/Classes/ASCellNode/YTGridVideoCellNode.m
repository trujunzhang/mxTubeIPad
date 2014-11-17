//
//  YTGridVideoCellNode.m
//  IOSTemplate
//
//  Created by djzhang on 11/17/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import <YoutubeCollectionView/IpadGridViewCell.h>
#import "YTGridVideoCellNode.h"


@interface YTGridVideoCellNode () {
   CGSize _kittenSize;

   ASImageNode * _imageNode;
   ASTextNode * _textNode;
   ASDisplayNode * _divider;
}
@end


@implementation YTGridVideoCellNode


- (instancetype)initWithCellNodeOfSize:(CGSize)size {
   if (!(self = [super init]))
      return nil;

   _kittenSize = size;

   return self;
}


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
   return _kittenSize;
}


- (void)layout {
//   _textNode.frame = CGRectInset(self.bounds, kHorizontalPadding, kVerticalPadding);
}


- (void)bind:(YTYouTubeVideo *)video placeholderImage:(UIImage *)placeholder delegate:(id<IpadGridViewCellDelegate>)delegate {
   self.video = video;
   self.delegate = delegate;

   self.backgroundColor = [UIColor redColor];

}

@end
