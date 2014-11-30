//
//  ASCacheNetworkImageNode.m
//  IOSTemplate
//
//  Created by djzhang on 10/24/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//


#import "ASCacheNetworkImageNode.h"


@interface ASCacheNetworkImageNode ()<ASImageCacheProtocol, ASImageDownloaderProtocol> {

}

@end


@implementation ASCacheNetworkImageNode

- (instancetype)initForImageCache {
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
   UIImage * cacheImage = [YTCacheImplement getCacheImageWithURL:URL];
   completion([cacheImage CGImage]);
}


#pragma mark -
#pragma mark ASImageDownloaderProtocol


- (id)downloadImageWithURL123:(NSURL *)URL
             callbackQueue:(dispatch_queue_t)callbackQueue
     downloadProgressBlock:(void (^)(CGFloat progress))downloadProgressBlock
                completion:(void (^)(CGImageRef image, NSError * error))completion {
   // if no callback queue is supplied, run on the main thread
   if (callbackQueue == nil) {
      callbackQueue = dispatch_get_main_queue();
   }

   // call completion blocks
   void (^handler)(NSURLResponse *, NSData *, NSError *) = ^(NSURLResponse * response, NSData * data, NSError * connectionError) {
       // add an artificial delay
       usleep(1.0 * USEC_PER_SEC);

       // ASMultiplexImageNode callbacks
       dispatch_async(callbackQueue, ^{
           if (downloadProgressBlock) {
              downloadProgressBlock(1.0f);
           }

           if (completion) {
              completion([[UIImage imageWithData:data] CGImage], connectionError);
           }
       });
   };

   // let NSURLConnection do the heavy lifting
   NSURLRequest * request = [NSURLRequest requestWithURL:URL];
   [NSURLConnection sendAsynchronousRequest:request
                                      queue:[[NSOperationQueue alloc] init]
                          completionHandler:handler];

   // return nil, don't support cancellation
   return nil;
}


//- (id)downloadImageWithURL_error:(NSURL *)URL
- (id)downloadImageWithURL:(NSURL *)URL
                   callbackQueue:(dispatch_queue_t)callbackQueue
           downloadProgressBlock:(void (^)(CGFloat progress))downloadProgressBlock
                      completion:(void (^)(CGImageRef image, NSError * error))completion {
   // if no callback queue is supplied, run on the main thread
   if (callbackQueue == nil) {
      callbackQueue = dispatch_get_main_queue();
   }

   void (^downloadCompletion)(UIImage *) = ^(UIImage * downloadedImage) {
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
   [YTCacheImplement CacheWithUrl:URL withCompletionBlock:downloadCompletion];

   return nil;
}


- (void)cancelImageDownloadForIdentifier:(id)downloadIdentifier {

}


@end
