//
//  LeftRevealHelper.m
//  IOSTemplate
//
//  Created by djzhang on 11/4/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//


#import "LeftRevealHelper.h"

#import <SWRevealViewController/SWRevealViewController.h>

LeftRevealHelper * instance;


@implementation LeftRevealHelper

+ (LeftRevealHelper *)sharedLeftRevealHelper {
   if (instance == nil) {
      instance = [[LeftRevealHelper alloc] init];
   }
   return instance;
}


#pragma mark -
#pragma mark -


- (void)setupHelper:(SWRevealViewController *)controller {
   // 1
   self.revealController = controller;

   // 2
   self.isRearOpen = YES;
   [self openLeftMenu];
}


#pragma mark -
#pragma mark -


- (void)toggleReveal {
   if (self.isRearOpen) {
      [self hideLeftMenu];
   } else {
      [self openLeftMenu];
   }
   self.isRearOpen = !self.isRearOpen;
}


- (void)hideLeftMenu {
   [self.revealController setFrontViewPosition:FrontViewPositionLeft animated:YES];
}


- (void)openLeftMenu {
   [self.revealController setFrontViewPosition:FrontViewPositionRight animated:YES];
}


#pragma mark - 
#pragma mark - 


- (void)beginTabBarToggleWithSelectedIndex:(NSUInteger)selectedIndex withViewCount:(NSUInteger)count {
   self.lastTabBarSelectedIndex = selectedIndex;
   self.isLastTabBarSelectedInRoot = (count == 1);
}


- (void)endTabBarToggleWithSelectedIndex:(NSUInteger)selectedIndex {
   if (selectedIndex != 0)
      return;

   if (selectedIndex != self.lastTabBarSelectedIndex)
      return;

   if (!self.isLastTabBarSelectedInRoot)
      return;

   [self toggleReveal];
}

@end
