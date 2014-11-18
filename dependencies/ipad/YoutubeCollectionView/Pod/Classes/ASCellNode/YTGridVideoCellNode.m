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
   ASTextNode * _titleNode;
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

   // 2.2
   _titleNode = [[ASTextNode alloc] init];
   [_infoContainerNode addSubnode:_titleNode];
}


- (CGSize)calculateSizeThatFits:(CGSize)constrainedSize {
   return _kittenSize;
}


- (NSDictionary *)textStyle {
   UIFont * font = [UIFont fontWithName:@"HelveticaNeue" size:12.0f];

   NSMutableParagraphStyle * style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
   style.paragraphSpacing = 0.5 * font.lineHeight;
   style.hyphenationFactor = 1.0;

   return @{ NSFontAttributeName : font, NSParagraphStyleAttributeName : style };
}


- (void)layout {
   // 1
   CGFloat thumbnailHeight = 142;
   _imageNode.frame = CGRectMake(0, 0, _kittenSize.width, thumbnailHeight);

   // 2
   CGFloat infoContainerHeight = _kittenSize.height - thumbnailHeight;
   _infoContainerNode.frame = CGRectMake(0, thumbnailHeight + 4, _kittenSize.width, infoContainerHeight - 4);

   // 2.1
   _channelImageNode.frame = CGRectMake(0, 0, 32, 32);

   // 2.2
   _titleNode.frame = CGRectMake(40, 0, 102, 32);
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

   // configure the button
   _imageNode.userInteractionEnabled = YES; // opt into touch handling
   [_imageNode addTarget:self
                  action:@selector(buttonTapped:)
        forControlEvents:ASControlNodeEventTouchUpInside];

   // 2.1
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

   // 2.2
   _titleNode.attributedString = [[NSAttributedString alloc] initWithString:videoTitleValue
                                                                 attributes:[self textStyle]];

}


- (void)buttonTapped:(id)buttonTapped {
   if (self.delegate)
      [self.delegate gridViewCellTap:self.video sender:self.delegate];
}

@end
