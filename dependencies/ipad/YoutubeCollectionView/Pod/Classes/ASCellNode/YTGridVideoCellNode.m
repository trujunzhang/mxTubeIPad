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
#import "ImageViewEffect.h"


@interface YTGridVideoCellNode () {
   CGSize _kittenSize;

   ASImageNode * _imageNode;

   ASDisplayNode * _infoContainerNode;

   ASImageNode * _channelImageNode;
   ASTextNode * _videoTitleNode;
   ASTextNode * _channelTitleNode;
}
@end


@implementation YTGridVideoCellNode


- (instancetype)initWithCellNodeOfSize:(CGSize)size { //242,242
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
   _videoTitleNode = [[ASTextNode alloc] init];
   [_infoContainerNode addSubnode:_videoTitleNode];

   // 2.3
   _channelTitleNode = [[ASTextNode alloc] init];
   [_infoContainerNode addSubnode:_channelTitleNode];
}


- (CGSize)calculateSizeThatFits:(CGSize)constrainedSize {
   return _kittenSize;
}


- (NSDictionary *)textStyleForVideoTitle {
   NSString * fontName = @"HelveticaNeue";
//   fontName = @"ChalkboardSE-Regular";
   UIFont * font = [UIFont fontWithName:fontName size:12.0f];

   NSMutableParagraphStyle * style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
   style.paragraphSpacing = 0.5 * font.lineHeight;
   style.hyphenationFactor = 1.0;
//   style.lineBreakMode = NSLineBreakByTruncatingTail;


   return @{ NSFontAttributeName : font, NSParagraphStyleAttributeName : style };
}


- (NSDictionary *)textStyleForChannelTitle {
   UIFont * font = [UIFont fontWithName:@"HelveticaNeue" size:12.0f];

   NSMutableParagraphStyle * style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
   style.paragraphSpacing = 0.5 * font.lineHeight;
   style.hyphenationFactor = 1.0;
   style.lineBreakMode = NSLineBreakByTruncatingTail;

   return @{
    NSFontAttributeName : font,
    NSParagraphStyleAttributeName : style,
    NSForegroundColorAttributeName : [UIColor lightGrayColor]
   };
}


- (void)layout {
   // 1
   CGFloat thumbnailHeight = 142;
   _imageNode.frame = CGRectMake(0, 0, _kittenSize.width, thumbnailHeight);

   // 2
   CGFloat infoContainerHeight = _kittenSize.height - thumbnailHeight;
   _infoContainerNode.frame = CGRectMake(0, thumbnailHeight + 8, _kittenSize.width, infoContainerHeight - 4);

   // 2.1
   CGFloat titleLeftX = 58;
   _channelImageNode.frame = CGRectMake(0, 0, titleLeftX - 8, titleLeftX - 4);
   CGFloat titleWidth = _kittenSize.width - titleLeftX;
   _videoTitleNode.frame = CGRectMake(titleLeftX, 0, titleWidth, 32);
   _channelTitleNode.frame = CGRectMake(titleLeftX, 32, titleWidth, 32);
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
   NSString * channelId = video.snippet.channelId;

   [self showChannelThumbnail:channelId];

   // 2.2
   _videoTitleNode.attributedString = [[NSAttributedString alloc] initWithString:videoTitleValue
                                                                      attributes:[self textStyleForVideoTitle]];

   _channelTitleNode.attributedString = [[NSAttributedString alloc] initWithString:channelTitleValue
                                                                        attributes:[self textStyleForChannelTitle]];
}


- (void)showChannelThumbnail:(NSString *)channelId {
   YoutubeResponseBlock completionBlock = ^(NSArray * array, NSObject * respObject) {
//       [ImageViewEffect setEffectImage:_channelImageNode.view withCornerRadius:10.0f];
       [ImageCacheImplement CacheWithImageView:_channelImageNode
                                           key:[YoutubeParser getThumbnailKeyWithChannelId:channelId]
                                       withUrl:respObject
                               withPlaceholder:nil
       ];
   };
   [[GYoutubeHelper getInstance] fetchChannelThumbnailsWithChannelId:channelId
                                                          completion:completionBlock
                                                        errorHandler:nil];

   _channelImageNode.imageModificationBlock = ^UIImage *(UIImage * image) {
       UIImage * modifiedImage = nil;
       CGRect rect = (CGRect) { CGPointZero, image.size };

       UIGraphicsBeginImageContextWithOptions(image.size, NO, [UIScreen mainScreen].scale);

       [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:10.0] addClip];
       [image drawInRect:rect];
       modifiedImage = UIGraphicsGetImageFromCurrentImageContext();

       UIGraphicsEndImageContext();

       return modifiedImage;
   };
}


- (void)buttonTapped:(id)buttonTapped {
   if (self.delegate)
      [self.delegate gridViewCellTap:self.video sender:self.delegate];
}

@end
