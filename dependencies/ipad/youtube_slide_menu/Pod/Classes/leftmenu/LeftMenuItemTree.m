//
//  LeftMenuItemTree.m
//  STCollapseTableViewDemo
//
//  Created by Thomas Dupont on 09/08/13.
//  Copyright (c) 2013 iSofTom. All rights reserved.
//

#import "LeftMenuItemTree.h"


@interface LeftMenuItemTree ()<UITableViewDataSource, UITableViewDelegate>

@end


@implementation LeftMenuItemTree

- (instancetype)initWithTitle:(NSString *)title rowsArray:(NSArray *)rowsArray {
   self = [super init];
   if (self) {
      self.title = title;
      self.rowsArray = rowsArray;
   }

   return self;
}



@end
