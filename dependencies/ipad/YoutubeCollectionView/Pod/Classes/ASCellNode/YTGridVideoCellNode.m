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
#import "GYoutubeHelper.h"


@interface YTGridVideoCellNode () {
   CGSize _kittenSize;

   ASImageNode * _imageNode;

   ASDisplayNode * _infoContainerNode;
   ASImageNode * _channelImageNode;
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
   // 1
   _imageNode = [[ASImageNode alloc] init];
   _imageNode.backgroundColor = [UIColor clearColor];
   [self addSubnode:_imageNode];

   // 2
   _infoContainerNode = [[ASDisplayNode alloc] init];
   _infoContainerNode.backgroundColor = [UIColor clearColor];
   [self addSubnode:_infoContainerNode];

   // 2.1
   _channelImageNode = [[ASImageNode alloc] init];
   [_infoContainerNode addSubnode:_channelImageNode];
}


- (CGSize)calculateSizeThatFits:(CGSize)constrainedSize {
   return _kittenSize;
}


- (void)layout {
   // 1
   CGFloat thumbnailHeight = 142;
   _imageNode.frame = CGRectMake(0, 0, _kittenSize.width, thumbnailHeight);

   // 2
   CGFloat infoContainerHeight = _kittenSize.height - thumbnailHeight;
   _infoContainerNode.frame = CGRectMake(0, thumbnailHeight, _kittenSize.width, infoContainerHeight);

   // 2.1
   _channelImageNode.frame = CGRectMake(0, 0, 32, 32);
}


- (void)bind:(YTYouTubeVideo *)video placeholderImage:(UIImage *)placeholder delegate:(id<IpadGridViewCellDelegate>)delegate {
   self.video = video;
   self.delegate = delegate;

   // 1
   NSString * videoThumbnailsUrl = [YoutubeParser getVideoSnippetThumbnails:video];
   NSString * videoTitleValue = video.snippet.title;
   NSString * channelTitleValue = video.snippet.channelTitle;

   [ImageCacheImplement CacheWithImageView:_imageNode
                                       key:video.identifier
                                   withUrl:videoThumbnailsUrl
                           withPlaceholder:placeholder
   ];

   self.backgroundColor = [UIColor clearColor];

   // 2
   NSString * channelIdentifier = video.snippet.channelId;

   YoutubeResponseBlock completionBlock = ^(NSArray * array, NSObject * respObject) {
       [ImageCacheImplement CacheWithImageView:_channelImageNode
                                           key:[YoutubeParser getThumbnailKeyWithChannelId:channelIdentifier]
                                       withUrl:respObject
                               withPlaceholder:nil
       ];
   };
   [[GYoutubeHelper getInstance] fetchChannelThumbnailsWithChannelId:channelIdentifier
                                                          completion:completionBlock
                                                        errorHandler:nil];

}

@end
