//
//  LeftRevealHelper.h
//  IOSTemplate
//
//  Created by djzhang on 11/4/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SWRevealViewController;


@interface LeftRevealHelper : NSObject

@property(nonatomic, strong) SWRevealViewController * revealController;

@property(nonatomic) BOOL isRearOpen;

+ (LeftRevealHelper *)sharedLeftRevealHelper;
@end
