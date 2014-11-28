//
//  ImageCacheImplement.h
//  IOSTemplate
//
//  Created by djzhang on 10/24/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AsyncDisplayKit/AsyncDisplayKit.h>

typedef void (^CacheCompletionBlock)(UIImage * downloadedImage);


@interface ImageCacheImplement : NSObject

+ (void)CacheWithImageView:(ASImageNode *)node key:(NSString *)key withUrl:(NSString *)url withPlaceholder:(UIImage *)placeholder;
+ (void)CacheWithImageView:(ASImageNode *)node key:(NSString *)key withUrl:(NSString *)url withPlaceholder:(UIImage *)placeholder completion:(void (^)(UIImage *))completion;
+ (UIImage *)getCacheImageWithKey:(NSString *)imageKey;
+ (UIImage *)getCacheImageWithURL:(NSURL *)url;
+ (void)CacheWithUrl:(NSURL *)url withCompletionBlock:(CacheCompletionBlock)completionBlock;
+ (void)CacheWithImageView:(UIImageView *)view withUrl:(NSString *)url withPlaceholder:(UIImage *)placeholder withCompletionBlock:(CacheCompletionBlock)completionBlock;
+ (void)CacheWithImageView:(UIImageView *)view withUrl:(NSString *)url withPlaceholder:(UIImage *)placeHolder;
+ (void)CacheWithImageView:(UIImageView *)view withUrl:(NSString *)url withPlaceholder:(UIImage *)placeHolder size:(CGSize)size;

+ (void)removeAllObjects;

+ (void)CacheWithImageView:(UIImageView *)view key:(NSString *)key withUrl:(id)url withPlaceholder:(UIImage *)placeholder resize:(CGSize)resize;
+ (void)CacheWithImageView:(ASImageNode *)node key:(NSString *)key withUrl:(NSString *)url withPlaceholder:(UIImage *)placeholder size:(CGSize)resize;
@end
