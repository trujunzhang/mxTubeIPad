//
//  AppDelegate.m
//  TubeIPadApp
//
//  Created by djzhang on 10/23/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import "AppDelegate.h"
#import "SWRevealViewController.h"


@interface AppDelegate ()

@end


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {


   //1
   self.tabBarController = (UITabBarController *) self.window.rootViewController;
   self.tabBarController.tabBar.tintColor = [UIColor redColor];

   //2
   [[UITabBar appearance] setBackgroundColor:[UIColor blackColor]];

   //3
   UIViewController * leftViewController = [self getLeftMenuController];


   //6
   self.revealController = [[SWRevealViewController alloc] initWithRearViewController:leftViewController
                                                                  frontViewController:self.tabBarController];
   self.revealController.delegate = self;

   //7
   UIWindow * window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
   self.window = window;

   self.window.rootViewController = self.revealController;

   self.window.backgroundColor = [UIColor whiteColor];
   [self.window makeKeyAndVisible];

   return YES;
}


- (UIViewController *)getLeftMenuController {
   UIViewController * leftViewController = [[UIViewController alloc] init];
   leftViewController.view.backgroundColor = [UIColor blueColor];

   // ボタンを作成
   UIButton * button =
    [UIButton buttonWithType:UIButtonTypeRoundedRect];

   // ボタンの位置を設定
   button.center = CGPointMake(100, 200);

   // キャプションを設定
   [button setTitle:@"What to Watch"
           forState:UIControlStateNormal];

   // キャプションに合わせてサイズを設定
   [button sizeToFit];

   // ボタンがタップされたときに呼ばれるメソッドを設定
   [button addTarget:self
              action:@selector(button_Tapped:)
    forControlEvents:UIControlEventTouchUpInside];

   // ボタンをビューに追加
   [leftViewController.view addSubview:button];

   return leftViewController;
}


- (void)button_Tapped:(id)sender {
   NSString * debug = @"debug";
//   [self.mainViewController search:@"sketch 3"];
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
#pragma mark - SWRevealViewControllerDelegate


// This will be called inside the reveal animation, thus you can use it to place your own code that will be animated in sync
- (void)revealController:(SWRevealViewController *)revealController animateToPosition:(FrontViewPosition)position {
   if (position == FrontViewPositionRight) {
      NSString * debug = @"debug";
   } else if (position == FrontViewPositionLeft) {
      NSString * debug = @"debug";
   }

   NSString * debug = @"debug";
}


@end
