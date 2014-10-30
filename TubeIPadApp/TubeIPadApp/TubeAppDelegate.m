//
//  TubeAppDelegate.m
//  TubeIPadApp
//
//  Created by djzhang on 10/23/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import "TubeAppDelegate.h"

#import <SWRevealViewController/SWRevealViewController.h>

#import "LeftMenuViewController.h"
#import "SubscriptionsViewController.h"


@interface TubeAppDelegate ()<UIApplicationDelegate, SWRevealViewControllerDelegate, UITabBarControllerDelegate>
@property(nonatomic) NSUInteger lastTabBarSelectedIndex;

@property(nonatomic, strong) SWRevealViewController * revealController;

@property(nonatomic, strong) LeftMenuViewController * leftViewController; // left
@property(nonatomic, strong) UITabBarController * tabBarController; // right

@property(nonatomic, strong) SubscriptionsViewController * subscriptionsViewController; // the first right tab bar item

@end


@implementation TubeAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   //1
   self.tabBarController = (UITabBarController *) self.window.rootViewController;
   self.tabBarController.view.backgroundColor = [UIColor whiteColor];
   self.tabBarController.delegate = self;
   self.tabBarController.tabBar.tintColor = [UIColor redColor];

   //2. the first right tab bar item
   self.subscriptionsViewController = self.tabBarController.viewControllers[0];
   self.subscriptionsViewController.revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"mt_side_tab_button"]
                                                                                        style:UIBarButtonItemStyleBordered
                                                                                       target:self
                                                                                       action:@selector(leftRevealToggle:)];
   self.subscriptionsViewController.isRearOpen = YES;

   //3
   self.leftViewController = [[LeftMenuViewController alloc] init];

   //6
   self.revealController = [[SWRevealViewController alloc] initWithRearViewController:self.leftViewController
                                                                  frontViewController:self.tabBarController];
   self.revealController.delegate = self;

   [self.revealController setFrontViewPosition:FrontViewPositionRight animated:YES];

   //7
   self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
   self.window.rootViewController = self.revealController;
   self.window.backgroundColor = [UIColor whiteColor];
   [self.window makeKeyAndVisible];

   return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
   // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
   // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
   // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
   // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
   // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
   // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
   // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark -
#pragma mark SWRevealViewControllerDelegate


// This will be called inside the reveal animation, thus you can use it to place your own code that will be animated in sync
- (void)revealController:(SWRevealViewController *)revealController animateToPosition:(FrontViewPosition)position {
   if (position == FrontViewPositionRight) {
      NSString * debug = @"debug";
   } else if (position == FrontViewPositionLeft) {
      NSString * debug = @"debug";
   }

   NSString * debug = @"debug";
}


#pragma mark -
#pragma mark UITabBarControllerDelegate


- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
   NSUInteger integer = tabBarController.selectedIndex;

   if (integer == 0) {
      [self setSubscriptionButtonEvent:integer];
   } else {
      if (self.subscriptionsViewController.isRearOpen) {
         [self closeRearPanel];
      }
   }

   self.lastTabBarSelectedIndex = integer;
}


- (void)closeRearPanel {
   [self.revealController setFrontViewPosition:FrontViewPositionLeft animated:YES];
   self.subscriptionsViewController.isRearOpen = NO;
   self.lastTabBarSelectedIndex = -1;
}


- (void)setSubscriptionButtonEvent:(NSUInteger)integer {
   if (integer == self.lastTabBarSelectedIndex) {
      [[self revealController] revealToggleAnimated:YES];
      self.subscriptionsViewController.isRearOpen = !self.subscriptionsViewController.isRearOpen;
   }
   else if (self.subscriptionsViewController.isRearOpen) {
      [self.revealController setFrontViewPosition:FrontViewPositionRight animated:YES];
   }
}


#pragma mark -
#pragma mark - Provided acction methods


- (void)leftRevealToggle:(id)sender {
   [self setSubscriptionButtonEvent:self.lastTabBarSelectedIndex];
}


@end