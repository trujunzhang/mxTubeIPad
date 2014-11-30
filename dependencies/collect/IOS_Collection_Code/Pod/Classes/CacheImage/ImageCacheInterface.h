//
//  ImageCacheInterface.h
//  IOSTemplate
//
//  Created by djzhang on 10/24/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AsyncDisplayKit/AsyncDisplayKit.h>


@interface ImageCacheInterface : NSObject


+ (UIImage *)getCacheImageWithKey:(NSString *)imageKey;
+ (UIImage *)getCacheImageWithURL:(NSURL *)url;
+ (void)CacheWithUrl:(NSURL *)url withCompletionBlock:(void (^)(UIImage *))completionBlock;
+ (void)CacheWithImageView:(UIImageView *)view withUrl:(NSString *)url withPlaceholder:(UIImage *)placeHolder;
+ (void)CacheWithImageView:(UIImageView *)view withUrl:(NSString *)url withPlaceholder:(UIImage *)placeHolder size:(CGSize)size;

+ (void)removeAllObjects;

@end
