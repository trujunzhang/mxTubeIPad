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

+ (void)CacheWithImageView:(ASImageNode *)node key:(NSString *)key withUrl:(NSString *)url withPlaceholder:(UIImage *)placeHolder {
   [ImageCacheImplement CacheWithImageView:node
                                       key:key
                                   withUrl:url
                           withPlaceholder:placeHolder
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


+ (void)CacheWithImageView:(UIImageView *)view key:(id)key withUrl:(id)url withPlaceholder:(UIImage *)placeHolder resize:(CGSize)resize {
   NSString * imageKey = key;
   UIImage * cacheImage = [[JMImageCache sharedCache] cachedImageForKey:imageKey];
   if (cacheImage) {
      view.image = [cacheImage resizedImageToSize:resize];
      return;
   }

   view.image = placeHolder;
   [ImageCacheImplement CacheWithImageView:view
                                       key:key
                                   withUrl:url
                           withPlaceholder:placeHolder
                                completion:^(UIImage * downloadedImage) {
                                    view.image = [downloadedImage resizedImageToSize:resize];
                                }];
}


+ (void)CacheWithImageView:(UIImageView *)view withUrl:(NSString *)url withPlaceholder:(UIImage *)placeHolder withCompletionBlock:(CacheCompletionBlock)completionBlock {
   view.image = placeHolder;

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
