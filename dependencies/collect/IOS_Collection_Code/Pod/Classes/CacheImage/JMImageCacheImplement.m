//
//  JMImageCacheImplement.m
//  IOSTemplate
//
//  Created by djzhang on 10/24/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//


#import "JMImageCacheImplement.h"

#import <AsyncDisplayKit/ASImageNode.h>
#import "JMImageCache.h"
#import "UIImage+Resize.h"


@implementation JMImageCacheImplement

+ (void)CacheWithImageView:(ASImageNode *)node key:(NSString *)key withUrl:(NSString *)url withPlaceholder:(UIImage *)placeHolder size:(CGSize)resize {
   [ImageCacheInterface CacheWithImageView:node
                                       key:key
                                   withUrl:url
                           withPlaceholder:placeHolder
                                completion:^(UIImage * downloadedImage) {
                                    UIImage * image = [downloadedImage resizedImageToSize:resize];
                                    node.image = image;
                                }];
}


+ (void)CacheWithImageView:(ASImageNode *)node key:(NSString *)key withUrl:(NSString *)url withPlaceholder:(UIImage *)placeholder {
   [ImageCacheInterface CacheWithImageView:node
                                       key:key
                                   withUrl:url
                           withPlaceholder:placeholder
                                completion:^(UIImage * downloadedImage) {
                                    node.image = downloadedImage;
                                }];
}


+ (void)CacheWithImageView:(ASImageNode *)node key:(NSString *)key withUrl:(NSString *)url withPlaceholder:(UIImage *)placeHolder completion:(void (^)(UIImage *))completion {
   NSString * imageKey = key;
   UIImage * cacheImage = [[JMImageCache sharedCache] cachedImageForKey:imageKey];
   if (cacheImage) {
      node.image = cacheImage;
      return;
   }

   node.image = placeHolder;
   [[JMImageCache sharedCache] imageForURL:[NSURL URLWithString:url]
                                       key:imageKey
                           completionBlock:completion];
}


+ (void)CacheWithImageView:(UIImageView *)view key:(NSString *)key withUrl:(id)url withPlaceholder:(UIImage *)placeholder resize:(CGSize)resize {
   NSString * imageKey = key;
   UIImage * cacheImage = [self getCacheImageWithKey:imageKey];
   if (cacheImage) {
      view.image = [cacheImage resizedImageToSize:resize];
      return;
   }

   view.image = placeholder;
   [ImageCacheInterface CacheWithImageView:view
                                       key:key
                                   withUrl:url
                           withPlaceholder:placeholder
                                completion:^(UIImage * downloadedImage) {
                                    view.image = [downloadedImage resizedImageToSize:resize];
                                }];
}


+ (UIImage *)getCacheImageWithKey:(NSString *)imageKey {
   return [[JMImageCache sharedCache] cachedImageForKey:imageKey];
}


+ (UIImage *)getCacheImageWithURL:(NSURL *)url {
   return [[JMImageCache sharedCache] cachedImageForURL:url];
}


+ (void)CacheWithUrl:(NSURL *)url withCompletionBlock:(void (^)(UIImage *))completionBlock {
   [[JMImageCache sharedCache] imageForURL:url
                           completionBlock:^(UIImage * downloadedImage) {
                               completionBlock(downloadedImage);
                           }];
}


+ (void)CacheWithImageView:(UIImageView *)view withUrl:(NSString *)url withPlaceholder:(UIImage *)placeholder withCompletionBlock:(void (^)(UIImage *))completionBlock {
   view.image = placeholder;

   [[JMImageCache sharedCache] imageForURL:[NSURL URLWithString:url]
                           completionBlock:^(UIImage * downloadedImage) {
                               completionBlock(downloadedImage);
                           }];
}


+ (void)CacheWithImageView:(UIImageView *)view withUrl:(NSString *)url withPlaceholder:(UIImage *)placeHolder {
   [self CacheWithImageView:view
                    withUrl:url
            withPlaceholder:placeHolder
        withCompletionBlock:^(UIImage * downloadedImage) {
            view.image = downloadedImage;
        }
   ];
}


+ (void)CacheWithImageView:(UIImageView *)view withUrl:(NSString *)url withPlaceholder:(UIImage *)placeHolder size:(CGSize)size {
   view.image = placeHolder;

   [[JMImageCache sharedCache] imageForURL:[NSURL URLWithString:url]
                           completionBlock:^(UIImage * downloadedImage) {
                               view.image = [downloadedImage resizedImageToSize:size];
                           }];
}


+ (void)removeAllObjects {
   [[JMImageCache sharedCache] removeAllObjects];
}


@end
