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
@class LeftMenuItemTree;


@protocol LeftMenuViewBaseDelegate<NSObject>
@optional
- (void)leftMenuEventReponse:(NSArray *)array withModel:(LeftMenuItemTree *)menuItemTree withTitle:(NSString *)title;

@end


@interface LeftMenuViewBase : UIViewController

@property(nonatomic, strong) UIImage * placeholderImage;
@property(nonatomic, strong) NSArray * tableSectionArray;

- (UIView *)getUserHeaderView:(YoutubeAuthInfo *)user;

- (void)bind:(UITableViewCell *)cell atSection:(NSInteger)section atRow:(NSInteger)row;
- (void)tableViewEvent:(LeftMenuItemTree *)menuItemTree atIndexPath:(NSIndexPath *)path;
- (NSArray *)defaultCategories;
- (NSArray *)signUserCategories;

@property(nonatomic, assign) id<LeftMenuViewBaseDelegate> delegate;

@end
