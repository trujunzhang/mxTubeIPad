//
//  LeftRevealHelper.m
//  IOSTemplate
//
//  Created by djzhang on 11/4/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import "LeftRevealHelper.h"
#import "SWRevealViewController.h"

LeftRevealHelper * _sharedCache = nil;


@interface LeftRevealHelper ()<SWRevealViewControllerDelegate>

@property(nonatomic) NSUInteger lastTabBarSelectedIndex;

@end


@implementation LeftRevealHelper

+ (LeftRevealHelper *)sharedLeftRevealHelper {
   if (!_sharedCache) {
      _sharedCache = [[LeftRevealHelper alloc] init];
   }

   return _sharedCache;
}


#pragma mark -
#pragma mark SWRevealViewControllerDelegate


// This will be called inside the reveal animation, thus you can use it to place your own code that will be animated in sync
- (void)revealController:(SWRevealViewController *)revealController animateToPosition:(FrontViewPosition)position {
   if (position == FrontViewPositionRight) {
      NSString * debug = @"debug";
   } else if (position == FrontViewPositionLeft) {
      NSString * debug = @"debug";
   }

   NSString * debug = @"debug";
}


#pragma mark -
#pragma mark - Provided acction methods


- (void)leftRevealToggle:(id)sender {
//   [self setSubscriptionButtonEvent:self.lastTabBarSelectedIndex];
}


@end
