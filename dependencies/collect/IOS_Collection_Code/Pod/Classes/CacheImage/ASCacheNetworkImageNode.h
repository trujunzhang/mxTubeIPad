//
//  ASCacheNetworkImageNode.h
//  IOSTemplate
//
//  Created by djzhang on 10/24/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AsyncDisplayKit.h"


@interface ASCacheNetworkImageNode : ASNetworkImageNode


- (void)startFetchImageWithString:(NSString *)urlString;
@end
