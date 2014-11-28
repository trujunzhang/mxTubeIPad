//
//  ImageCacheImplement.m
//  IOSTemplate
//
//  Created by djzhang on 10/24/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import <AsyncDisplayKit/ASImageNode.h>
#import "ImageCacheImplement.h"
#import "JMImageCache.h"
#import "UIImage+Resize.h"


@implementation ImageCacheImplement

+ (void)CacheWithImageView:(ASImageNode *)node key:(NSString *)key withUrl:(NSString *)url withPlaceholder:(UIImage *)placeHolder size:(CGSize)resize {
   [ImageCacheImplement CacheWithImageView:node
                                       key:key
                                   withUrl:url
                           withPlaceholder:placeHolder
                                completion:^(UIImage * downloadedImage) {
                                    UIImage * image = [downloadedImage resizedImageToSize:resize];
                                    node.image = image;
                                }];
}


+ (void)CacheWithImageView:(ASImageNode *)node key:(NSString *)key withUrl:(NSString *)url withPlaceholder:(UIImage *)placeholder {
   [ImageCacheImplement CacheWithImageView:node
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
   UIImage * cacheImage = [self getImageWithKey:imageKey];
   if (cacheImage) {
      view.image = [cacheImage resizedImageToSize:resize];
      return;
   }

   view.image = placeholder;
   [ImageCacheImplement CacheWithImageView:view
                                       key:key
                                   withUrl:url
                           withPlaceholder:placeholder
                                completion:^(UIImage * downloadedImage) {
                                    view.image = [downloadedImage resizedImageToSize:resize];
                                }];
}


+ (UIImage *)getImageWithKey:(NSString *)imageKey {
   UIImage * cacheImage = [[JMImageCache sharedCache] cachedImageForKey:imageKey];
   return cacheImage;
}


+ (void)CacheWithUrl:(NSString *)url key:(NSString *)key withCompletionBlock:(CacheCompletionBlock)completionBlock {
   [[JMImageCache sharedCache] imageForURL:[NSURL URLWithString:url]
                           completionBlock:^(UIImage * downloadedImage) {
                               completionBlock(downloadedImage);
                           }];
}


+ (void)CacheWithImageView:(UIImageView *)view withUrl:(NSString *)url withPlaceholder:(UIImage *)placeholder withCompletionBlock:(CacheCompletionBlock)completionBlock {
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
