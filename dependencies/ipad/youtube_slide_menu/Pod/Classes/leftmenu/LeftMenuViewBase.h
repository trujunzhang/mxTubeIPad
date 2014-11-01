//
//  LeftMenuViewBase.h
//  STCollapseTableViewDemo
//
//  Created by Thomas Dupont on 09/08/13.
//  Copyright (c) 2013 iSofTom. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GYoutubeAuthUser;


@interface LeftMenuViewBase : UIViewController

@property(nonatomic, strong) NSArray * tableSectionArray;

- (UIView *)getUserHeaderView:(GYoutubeAuthUser *)user;
- (NSArray *)defaultCategories;
- (NSArray *)signUserCategories;
@end
