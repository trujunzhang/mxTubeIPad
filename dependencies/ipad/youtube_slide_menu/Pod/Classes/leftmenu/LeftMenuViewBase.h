//
//  LeftMenuViewBase.h
//  STCollapseTableViewDemo
//
//  Created by Thomas Dupont on 09/08/13.
//  Copyright (c) 2013 iSofTom. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "YoutubeConstants.h"
@class GYoutubeAuthUser;
@class YoutubeAuthInfo;
@class LeftMenuItemTree;


@protocol LeftMenuViewBaseDelegate<NSObject>
@optional
- (void)startToggleLeftMenuWithTitle:(NSString *)title;
- (void)endToggleLeftMenuEventWithResponse:(NSArray *)array withModel:(LeftMenuItemTree *)menuItemTree withTitle:(NSString *)title;
- (void)endToggleLeftMenuEventForChannelPageWithSubscription:(GTLYouTubeSubscription *)subscription;
@end


@interface LeftMenuViewBase : UIViewController

@property(nonatomic, strong) GYoutubeAuthUser * authUser;
@property(nonatomic, strong) UIImage * placeholderImage;
@property(nonatomic, strong) NSArray * tableSectionArray;

- (UIView *)getUserHeaderView:(YoutubeAuthInfo *)user;

- (void)bind:(UITableViewCell *)cell atSection:(NSInteger)section atRow:(NSInteger)row;
- (void)tableViewEvent:(LeftMenuItemTree *)menuItemTree atIndexPath:(NSIndexPath *)path;
- (NSArray *)defaultCategories;
- (NSArray *)signUserCategories;

@property(nonatomic, assign) id<LeftMenuViewBaseDelegate> delegate;

@end
