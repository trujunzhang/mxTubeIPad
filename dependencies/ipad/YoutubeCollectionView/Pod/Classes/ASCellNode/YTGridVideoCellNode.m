//
//  YTGridVideoCellNode.m
//  IOSTemplate
//
//  Created by djzhang on 11/17/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import <YoutubeCollectionView/IpadGridViewCell.h>
#import "YTGridVideoCellNode.h"
#import "YoutubeParser.h"
#import "ImageCacheImplement.h"


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

   [self setupUI];

   return self;
}


- (void)setupUI {

   // kitten image, with a purple background colour serving as placeholder
   _imageNode = [[ASImageNode alloc] init];
   _imageNode.backgroundColor = [UIColor purpleColor];
   [self addSubnode:_imageNode];
}


- (CGSize)calculateSizeThatFits:(CGSize)constrainedSize {
//   CGSize availableSize = CGSizeMake(constrainedSize.width - 2 * kHorizontalPadding, constrainedSize.height - 2 * kVerticalPadding);
//   CGSize textNodeSize = [_textNode measure:availableSize];

//   return CGSizeMake(textNodeSize.width), ceilf(2 * kVerticalPadding + textNodeSize.height));
   return _kittenSize;
}


- (void)layout {
   _imageNode.frame = CGRectMake(0, 0, _kittenSize.width, 142);
//   _textNode.frame = CGRectInset(self.bounds, kHorizontalPadding, kVerticalPadding);
}


- (void)bind:(YTYouTubeVideo *)video placeholderImage:(UIImage *)placeholder delegate:(id<IpadGridViewCellDelegate>)delegate {
   self.video = video;
   self.delegate = delegate;

//   [YoutubeParser getChannelId:video];
   NSString * videoThumbnailsUrl = video.snippet.thumbnails.medium.url;
   NSString * videoTitleValue = video.snippet.title;
   NSString * channelTitleValue = video.snippet.channelTitle;

   [ImageCacheImplement CacheWithImageView:_imageNode
                                       key:video.identifier
                                   withUrl:videoThumbnailsUrl
                           withPlaceholder:placeholder
   ];

   self.backgroundColor = [UIColor redColor];

}

@end
