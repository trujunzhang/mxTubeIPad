//
//  LeftMenuItemTree.h
//  STCollapseTableViewDemo
//
//  Created by Thomas Dupont on 09/08/13.
//  Copyright (c) 2013 iSofTom. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LeftMenuItemTree : NSObject


@property(nonatomic, copy) NSString * title;
@property(nonatomic, strong) NSArray * rowsArray;

@property(nonatomic) BOOL hideTitle;

@property(nonatomic) BOOL remoteImage;
- (instancetype)initWithTitle:(NSString *)title rowsArray:(NSArray *)rowsArray hideTitle:(BOOL)hideTitle remoteImage:(BOOL)remoteImage;


@end
