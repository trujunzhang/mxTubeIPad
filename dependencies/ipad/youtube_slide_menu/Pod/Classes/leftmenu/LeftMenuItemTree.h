//
//  LeftMenuItemTree.h
//  STCollapseTableViewDemo
//
//  Created by Thomas Dupont on 09/08/13.
//  Copyright (c) 2013 iSofTom. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSUInteger, LeftMenuItemTreeType) {
   // Playlist pop-up menu item tags.
    LMenuTreeUser = 0,
   LMenuTreeSubscriptions = 1,
   LMenuTreeCategories = 2,
};


@interface LeftMenuItemTree : NSObject

@property(nonatomic, copy) NSString * title;
@property(nonatomic) enum LeftMenuItemTreeType itemType;
@property(nonatomic, strong) NSArray * rowsArray;
@property(nonatomic) BOOL hideTitle;
@property(nonatomic) BOOL remoteImage;
@property(nonatomic, copy) NSString * cellIdentifier;


- (id)initWithTitle:(NSString *)string itemType:(enum LeftMenuItemTreeType)type rowsArray:(NSArray *)array hideTitle:(BOOL)title remoteImage:(BOOL)image cellIdentifier:(NSString *)identifier;
@end
