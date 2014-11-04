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
   @synchronized (self) {
      if (instance == nil) {
         instance = [[self alloc] init];
      }
   }
   return (instance);
}


- (instancetype)init {
   self = [super init];
   if (self) {
      self.isRearOpen = YES;
   }

   return self;
}


#pragma mark -
#pragma mark -


- (void)setRevealController:(SWRevealViewController *)controller {
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
