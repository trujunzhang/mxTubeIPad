//
//  LeftRevealHelper.h
//  IOSTemplate
//
//  Created by djzhang on 11/4/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

@class SWRevealViewController;


static const int TAB_INDEX_SUBSCRIPTIONS = 0;


@interface LeftRevealHelper : NSObject

@property(nonatomic) BOOL isRearOpen;
@property(nonatomic) NSUInteger lastTabBarSelectedIndex;
@property(nonatomic) BOOL isLastTabBarSelectedInRoot;

@property(nonatomic, strong) SWRevealViewController * revealController;

+ (LeftRevealHelper *)sharedLeftRevealHelper;

- (void)toggleReveal;
- (void)closeLeftMenu;
- (void)openLeftMenu;

- (void)setupHelper:(SWRevealViewController *)controller;

- (void)beginTabBarToggleWithSelectedIndex:(NSUInteger)selectedIndex withViewCount:(NSUInteger)count;
- (void)endTabBarToggleWithSelectedIndex:(NSUInteger)selectedIndex;
@end
