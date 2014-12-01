//
//  SDWebImageCacheImplement.m
//  IOSTemplate
//
//  Created by djzhang on 10/24/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import <ASImageResize/UIImage+Resize.h>
#import "SDWebImageCacheImplement.h"
#import "SDImageCache.h"
#import "SDWebImageManager.h"
#import "JMImageCache.h"


@implementation SDWebImageCacheImplement

+ (UIImage *)getCacheImageWithURL:(NSURL *)url {
   NSString * cacheKeyForURL = [[SDWebImageManager sharedManager] cacheKeyForURL:url];

   UIImage * uiImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:cacheKeyForURL];
//   if (uiImage) {
//      NSLog(@"url = %@", url);
//   }
   return uiImage;
}


+ (void)CacheWithUrl:(NSURL *)url withCompletionBlock:(void (^)(UIImage *))completionBlock {
   SDWebImageManager * manager = [SDWebImageManager sharedManager];
   SDWebImageCompletionWithFinishedBlock cacheCompletedBlock = ^(UIImage * image, NSError * error, SDImageCacheType cacheType, BOOL finished, NSURL * imageURL) {
       if (image) {
          completionBlock(image);
       }
   };
   [manager downloadImageWithURL:url
                         options:0
                        progress:nil
                       completed:cacheCompletedBlock];
}


+ (void)CacheWithImageView:(UIImageView *)view withUrl:(NSString *)url withPlaceholder:(UIImage *)placeHolder {
   [SDWebImageCacheImplement CacheWithImageView:view
                                        withUrl:url
                                withPlaceholder:placeHolder
                                           size:CGSizeZero];
}


+ (void)CacheWithImageView:(UIImageView *)view withUrl:(NSString *)url withPlaceholder:(UIImage *)placeHolder size:(CGSize)size {
   view.image = placeHolder;

   [SDWebImageCacheImplement CacheWithUrl:[NSURL URLWithString:url] withCompletionBlock:^(UIImage * downloadedImage) {
       if (CGSizeEqualToSize(size, CGSizeZero)) {
          view.image = downloadedImage;
       } else {
          view.image = [downloadedImage resizedImageToSize:size];
       }
   }];
}


+ (void)removeAllObjects {
   [[SDImageCache sharedImageCache] cleanDisk];
}


@end