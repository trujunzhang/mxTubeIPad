//
//  LeftMenuViewBase.h
//  STCollapseTableViewDemo
//
//  Created by Thomas Dupont on 09/08/13.
//  Copyright (c) 2013 iSofTom. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GYoutubeAuthUser;
@class YoutubeAuthInfo;


@interface LeftMenuViewBase : UIViewController

@property(nonatomic, strong) UIImage * placeholderImage;
@property(nonatomic, strong) NSArray * tableSectionArray;

- (UIView *)getUserHeaderView:(YoutubeAuthInfo *)user;

- (void)bind:(UITableViewCell *)cell atSection:(NSInteger)section atRow:(NSInteger)row;
- (NSArray *)defaultCategories;
- (NSArray *)signUserCategories;
@end
