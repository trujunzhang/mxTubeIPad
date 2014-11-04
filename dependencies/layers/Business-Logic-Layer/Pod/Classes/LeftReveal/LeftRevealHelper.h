//
//  LeftRevealHelper.h
//  IOSTemplate
//
//  Created by djzhang on 11/4/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

@class SWRevealViewController;


@interface LeftRevealHelper : NSObject

@property(nonatomic) BOOL isRearOpen;
@property(nonatomic) NSUInteger lastTabBarSelectedIndex;

@property(nonatomic, strong) SWRevealViewController * revealController;

+ (LeftRevealHelper *)sharedLeftRevealHelper;

- (void)toggleReveal;
@end
