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
   self.isRearOpen = YES;
   self.revealController = controller;
}


#pragma mark -
#pragma mark -


- (void)toggleReveal {
   if (self.isRearOpen) {
      [self showLeftMenu];
   } else {
      [self hideLeftMenu];
   }
   self.isRearOpen = !self.isRearOpen;
}


- (void)hideLeftMenu {
   [self.revealController setFrontViewPosition:FrontViewPositionRight animated:YES];
}


- (void)showLeftMenu {
   [self.revealController setFrontViewPosition:FrontViewPositionLeft animated:YES];
}


@end
