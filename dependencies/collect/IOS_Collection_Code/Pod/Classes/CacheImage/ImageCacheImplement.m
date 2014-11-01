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
//   [[JMImageCache sharedCache] imageForURL:[NSURL URLWithString:@"http://dundermifflin.com/i/MichaelScott.png"]
   view.image = placeHolder;
   [[JMImageCache sharedCache] imageForURL:[NSURL URLWithString:url]
                           completionBlock:^(UIImage * downloadedImage) {
                               [downloadedImage resizedImageToSize:CGSizeMake(26, 26)];
                               view.image = downloadedImage;
                               view.contentMode = UIViewContentModeScaleAspectFit;
//                               completionBlock(downloadedImage);
                           }];
}


+ (void)CacheWithImageView:(UIImageView *)view withUrl:(NSString *)url withPlaceholder:(UIImage *)placeHolder {
   [self CacheWithImageView:view
                    withUrl:url
            withPlaceholder:placeHolder
        withCompletionBlock:nil];
}

@end
