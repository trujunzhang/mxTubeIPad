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
+ (void)CacheWithImageView:(UIImageView *)view withUrl:(NSString *)url withPlaceholder:(UIImage *)placeHolder withCompletionBlock:(CacheCompletionBlock)completionBlock;
+ (void)CacheWithImageView:(UIImageView *)view withUrl:(NSString *)url withPlaceholder:(UIImage *)placeHolder;
+ (void)CacheWithImageView:(UIImageView *)view withUrl:(NSString *)url withPlaceholder:(UIImage *)placeHolder size:(CGSize)size;

+ (void)removeAllObjects;

@end
