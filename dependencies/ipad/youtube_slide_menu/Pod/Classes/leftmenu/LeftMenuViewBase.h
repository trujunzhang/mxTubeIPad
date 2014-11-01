//
//  LeftMenuViewBase.h
//  STCollapseTableViewDemo
//
//  Created by Thomas Dupont on 09/08/13.
//  Copyright (c) 2013 iSofTom. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UserInfoView;


@interface LeftMenuViewBase : UIViewController

@property(nonatomic, strong) NSArray * tableSectionArray;

- (UserInfoView *)getUserInfoPanel;
- (NSArray *)defaultCategories;
@end
