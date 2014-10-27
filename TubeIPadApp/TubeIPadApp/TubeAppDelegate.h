//
//  TubeAppDelegate.h
//  TubeIPadApp
//
//  Created by djzhang on 10/23/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SWRevealViewController/SWRevealViewController.h>


@interface TubeAppDelegate : UIResponder <UIApplicationDelegate,SWRevealViewControllerDelegate>

@property (strong, nonatomic) UIWindow *window;


@property(nonatomic, strong) UITabBarController * tabBarController;
@property(nonatomic, strong) SWRevealViewController * revealController;
@end

