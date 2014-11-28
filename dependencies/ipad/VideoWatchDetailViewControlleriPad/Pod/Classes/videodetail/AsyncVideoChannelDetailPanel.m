//
//  AsyncVideoChannelDetailPanel.m
//  YoutubePlayApp
//
//  Created by djzhang on 10/14/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import "AsyncVideoChannelDetailPanel.h"
#import "YoutubeVideoCache.h"
#import "YoutubeParser.h"
#import <AsyncDisplayKit/ASDisplayNode+Subclasses.h>
#import <AsyncDisplayKit/ASHighlightOverlayLayer.h>
#import <IOS_Collection_Code/ImageCacheImplement.h>
#import <google-api-services-youtube/GYoutubeHelper.h>


static CGFloat kTextPadding = 10.0f;


@interface AsyncVideoChannelDetailPanel ()<ASImageCacheProtocol, ASImageDownloaderProtocol> {
   ASTextNode * _textNode;
   ASDisplayNode * _divider;
}

@property(nonatomic, strong) ASNetworkImageNode * videoChannelThumbnailsNode;
@end


@implementation AsyncVideoChannelDetailPanel


- (instancetype)initWithVideo:(YoutubeVideoCache *)videoCache {
   if (!(self = [super init]))
      return nil;

   self.cardInfo = videoCache;

   self.backgroundColor = [UIColor whiteColor];

   [self setupContainerNode];
   [self addSubnode:self.videoChannelThumbnailsNode];

   // create a text node
   _textNode = [[ASTextNode alloc] init];

   // generate an attributed string using the custom link attribute specified above
//   NSString * blurb = @"kittens courtesy placekitten.com kittens courtesy placekitten.com kittens courtesy placekitten.com \U0001F638";
   NSString * blurb = videoCache.snippet.channelTitle;
   NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:blurb];
   [string addAttribute:NSFontAttributeName
                  value:[UIFont fontWithName:@"HelveticaNeue-Light" size:16.0f]
                  range:NSMakeRange(0, blurb.length)];
   [string addAttributes:@{
     NSForegroundColorAttributeName : [UIColor grayColor],
     NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle | NSUnderlinePatternDot),
    }
                   range:[blurb rangeOfString:@"placekitten.com"]];
   _textNode.attributedString = string;

   // add it as a subnode, and we're done
   [self addSubnode:_textNode];

   // hairline cell separator
   _divider = [[ASDisplayNode alloc] init];
   _divider.backgroundColor = [UIColor lightGrayColor];
   [self addSubnode:_divider];

   return self;
}


- (void)setupContainerNode {
   NSString * videoTitleValue = self.cardInfo.snippet.title;
   NSString * channelTitleValue = self.cardInfo.snippet.channelTitle;
   NSString * channelId = [YoutubeParser getChannelIdByVideo:self.cardInfo];
   // 1
   ASNetworkImageNode * videoChannelThumbnailsNode = [[ASNetworkImageNode alloc] initWithCache:self downloader:self];

   // configure the button
   videoChannelThumbnailsNode.userInteractionEnabled = YES; // opt into touch handling
   [videoChannelThumbnailsNode addTarget:self
                                  action:@selector(channelThumbnailsTapped:)
                        forControlEvents:ASControlNodeEventTouchUpInside];


   [self showChannelThumbnail:channelId];

   self.videoChannelThumbnailsNode = videoChannelThumbnailsNode;
}


- (void)showChannelThumbnail:(NSString *)channelId {
   if (self.cardInfo.channelThumbnailUrl) {
      self.videoChannelThumbnailsNode.URL = [NSURL URLWithString:self.cardInfo.channelThumbnailUrl];
      return;
   }

   YoutubeResponseBlock completionBlock = ^(NSArray * array, NSObject * respObject) {
       self.cardInfo.channelThumbnailUrl = respObject;
       self.videoChannelThumbnailsNode.URL = [NSURL URLWithString:respObject];
   };
   [[GYoutubeHelper getInstance] fetchChannelThumbnailsWithChannelId:channelId
                                                          completion:completionBlock
                                                        errorHandler:nil];
}


- (void)didLoad {
   // enable highlighting now that self.layer has loaded -- see ASHighlightOverlayLayer.h
   self.layer.as_allowsHighlightDrawing = YES;

   [super didLoad];
}


- (CGSize)calculateSizeThatFits:(CGSize)constrainedSize {
   // called on a background thread.  custom nodes must call -measure: on their subnodes in -calculateSizeThatFits:
   CGSize measuredSize = [_textNode measure:CGSizeMake(constrainedSize.width - 2 * kTextPadding,
    constrainedSize.height - 2 * kTextPadding)];
   return CGSizeMake(constrainedSize.width, measuredSize.height + 2 * kTextPadding);
}


- (void)layout {
   _videoChannelThumbnailsNode.frame = CGRectMake(2, 2, 40, 40);

   // called on the main thread.  we'll use the stashed size from above, instead of blocking on text sizing
   CGSize textNodeSize = _textNode.calculatedSize;
   _textNode.frame = CGRectMake(
    50, kTextPadding, textNodeSize.width, textNodeSize.height);

   CGFloat pixelHeight = 1.0f / [[UIScreen mainScreen] scale];
   _divider.frame = CGRectMake(0.0f, 0.0f, self.calculatedSize.width, pixelHeight);
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
