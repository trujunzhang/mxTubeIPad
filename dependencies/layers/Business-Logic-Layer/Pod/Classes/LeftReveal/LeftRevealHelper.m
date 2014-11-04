//
//  LeftRevealHelper.m
//  IOSTemplate
//
//  Created by djzhang on 11/4/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import <SWRevealViewController/SWRevealViewController.h>
#import "LeftRevealHelper.h"

LeftRevealHelper * instance;


@implementation LeftRevealHelper

+ (LeftRevealHelper *)sharedLeftRevealHelper{
   @synchronized (self) {
      if (instance == nil) {
         instance = [[self alloc] init];
      }
   }
   return (instance);
}


@end
