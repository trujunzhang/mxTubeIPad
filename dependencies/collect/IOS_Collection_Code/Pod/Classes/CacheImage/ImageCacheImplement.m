//
//  ImageCacheImplement.m
//  IOSTemplate
//
//  Created by djzhang on 10/24/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import "ImageCacheImplement.h"
#import "JMImageCache.h"
#import "UIImage+Resize.h"


@implementation ImageCacheImplement


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
   [self CacheWithImageView:view
                    withUrl:url
            withPlaceholder:placeHolder
        withCompletionBlock:^(UIImage * downloadedImage) {
            view.image = [downloadedImage resizedImageToSize:size];
        }];
}


+ (void)removeAllObjects {
   [[JMImageCache sharedCache] removeAllObjects];
}
@end
