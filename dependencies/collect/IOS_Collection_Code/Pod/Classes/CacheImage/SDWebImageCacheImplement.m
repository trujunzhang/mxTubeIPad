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


@implementation SDWebImageCacheImplement



//
//
//+ (UIImage *)getCacheImageWithKey:(NSString *)imageKey {
//   return [[JMImageCache sharedCache] cachedImageForKey:imageKey];
//}
//
//
//+ (UIImage *)getCacheImageWithURL:(NSURL *)url {
//   return [[JMImageCache sharedCache] cachedImageForURL:url];
//}
//
//
//+ (void)CacheWithUrl:(NSURL *)url withCompletionBlock:(void (^)(UIImage *))completionBlock {
//   [[JMImageCache sharedCache] imageForURL:url
//                           completionBlock:^(UIImage * downloadedImage) {
//                               completionBlock(downloadedImage);
//                           }];
//}
//
//
//+ (void)CacheWithImageView:(UIImageView *)view withUrl:(NSString *)url withPlaceholder:(UIImage *)placeholder withCompletionBlock:(void (^)(UIImage *))completionBlock {
//   view.image = placeholder;
//   [ImageCacheInterface CacheWithUrl:[NSURL URLWithString:url] withCompletionBlock:completionBlock];
//}
//
//
//+ (void)CacheWithImageView:(UIImageView *)view withUrl:(NSString *)url withPlaceholder:(UIImage *)placeHolder {
//   [self CacheWithImageView:view
//                    withUrl:url
//            withPlaceholder:placeHolder
//        withCompletionBlock:^(UIImage * downloadedImage) {
//            view.image = downloadedImage;
//        }
//   ];
//}


+ (void)CacheWithImageView:(UIImageView *)view withUrl:(NSString *)url withPlaceholder:(UIImage *)placeHolder size:(CGSize)size {
   view.image = placeHolder;

   [ImageCacheInterface CacheWithUrl:[NSURL URLWithString:url] withCompletionBlock:^(UIImage * downloadedImage) {
       view.image = [downloadedImage resizedImageToSize:size];
   }];
}


+ (void)removeAllObjects {
   [[SDImageCache sharedImageCache] cleanDisk];
}


@end
