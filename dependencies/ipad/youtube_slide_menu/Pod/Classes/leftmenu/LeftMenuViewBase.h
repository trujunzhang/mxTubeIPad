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
- (void)startToggleLeftMenuWithTitle:(NSString *)title withType:(enum YTPlaylistItemsType)playlistItemsType;
- (void)endToggleLeftMenuEventForChannelPageWithSubscription:(YTYouTubeSubscription *)subscription withTitle:(id)title;
@end


@interface LeftMenuViewBase : UIViewController

@property(nonatomic, strong) GYoutubeAuthUser * authUser;
@property(nonatomic, strong) UIImage * placeholderImage;
@property(nonatomic, strong) NSArray * tableSectionArray;

- (UIView *)getUserHeaderView:(YoutubeAuthInfo *)user;

- (void)bind:(UITableViewCell *)cell atSection:(NSInteger)section atRow:(NSInteger)row;

- (NSArray *)defaultCategories;
- (NSArray *)signUserCategories;

@property(nonatomic, assign) id<LeftMenuViewBaseDelegate> delegate;

@end
