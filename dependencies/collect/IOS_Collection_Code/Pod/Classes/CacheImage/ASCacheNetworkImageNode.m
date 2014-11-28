//
//  ASCacheNetworkImageNode.m
//  IOSTemplate
//
//  Created by djzhang on 10/24/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import <IOS_Collection_Code/ImageCacheImplement.h>
#import "ASCacheNetworkImageNode.h"


@interface ASCacheNetworkImageNode ()<ASImageCacheProtocol, ASImageDownloaderProtocol> {

}

@end


@implementation ASCacheNetworkImageNode

- (instancetype)init {
   self = [super initWithCache:self downloader:self];
   if (self) {

   }

   return self;
}


- (void)startFetchImageWithString:(NSString *)urlString {
   self.URL = [NSURL URLWithString:urlString];
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
