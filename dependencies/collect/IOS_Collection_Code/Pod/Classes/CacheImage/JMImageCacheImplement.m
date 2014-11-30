//
//  JMImageCacheImplement.m
//  IOSTemplate
//
//  Created by djzhang on 10/24/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//


#import "JMImageCacheImplement.h"

#import "JMImageCache.h"
#import "UIImage+Resize.h"


@implementation JMImageCacheImplement


+ (UIImage *)getCacheImageWithKey:(NSString *)imageKey {
   return [[JMImageCache sharedCache] cachedImageForKey:imageKey];
}


+ (UIImage *)getCacheImageWithURL:(NSURL *)url {
   return [[JMImageCache sharedCache] cachedImageForURL:url];
}


+ (void)CacheWithUrl:(NSURL *)url withCompletionBlock:(void (^)(UIImage *))completionBlock {
   [[JMImageCache sharedCache] imageForURL:url completionBlock:completionBlock];
}


+ (void)CacheWithImageView:(UIImageView *)view withUrl:(NSString *)url withPlaceholder:(UIImage *)placeHolder {
   view.image = placeHolder;
   [JMImageCacheImplement CacheWithUrl:[NSURL URLWithString:url] withCompletionBlock:^(UIImage * downloadedImage) {
       view.image = downloadedImage;
   }];
}


+ (void)CacheWithImageView:(UIImageView *)view withUrl:(NSString *)url withPlaceholder:(UIImage *)placeHolder size:(CGSize)size {
   view.image = placeHolder;

   [JMImageCacheImplement CacheWithUrl:[NSURL URLWithString:url] withCompletionBlock:^(UIImage * downloadedImage) {
       view.image = [downloadedImage resizedImageToSize:size];
   }];
}


+ (void)removeAllObjects {
   [[JMImageCache sharedCache] removeAllObjects];
}


@end
