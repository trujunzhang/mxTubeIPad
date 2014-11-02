//
//  LeftMenuViewBase.m
//  STCollapseTableViewDemo
//
//  Created by Thomas Dupont on 09/08/13.
//  Copyright (c) 2013 iSofTom. All rights reserved.
//

#import <IOS_Collection_Code/ImageCacheImplement.h>
#import "LeftMenuViewBase.h"
#import "UserInfoView.h"
#import "SearchImplementation.h"
#import "GYoutubeAuthUser.h"
#import "LeftMenuItemTree.h"


@interface LeftMenuViewBase ()<UITableViewDataSource, UITableViewDelegate>

@end


@implementation LeftMenuViewBase


- (void)viewDidLoad {
   [super viewDidLoad];

   // 1
   [self setupBackground];

   // 2
   self.placeholderImage = [self imageWithColor:[UIColor clearColor]];
}


#pragma mark -
#pragma mark Youtube auth login events


- (UIView *)getUserHeaderView:(GYoutubeAuthUser *)user {

   BOOL isSignedIn = [[SearchImplementation getInstance] isSignedIn];

   UIView * headerView = nil;
   if (isSignedIn) {
      UserInfoView * userInfoView = [[[NSBundle mainBundle] loadNibNamed:@"UserInfoView"
                                                                   owner:nil
                                                                 options:nil] lastObject];

      headerView = [userInfoView bind:user];
   } else {
      headerView = [[[NSBundle mainBundle] loadNibNamed:@"UserLoginView" owner:nil options:nil] lastObject];

      //The setup code (in viewDidLoad in your view controller)
      UITapGestureRecognizer * singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                         action:@selector(handleSingleTap:)];
      [headerView addGestureRecognizer:singleFingerTap];
   }

   headerView.frame = CGRectMake(0, 0, 256, 80);

   return headerView;
}


//The event handling method
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
   [self loginInTouch];
   NSString * debug = @"debug";
}


- (void)loginInTouch {
   GTMOAuth2ViewControllerTouch * viewController =
    [[GYoutubeHelper getInstance] getYoutubeOAuth2ViewControllerTouchWithTouchDelegate:self
                                                                       leftBarDelegate:self
                                                                          cancelAction:@selector(cancelGdriveSignIn:)];

   UINavigationController * navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
   navigationController.view.backgroundColor = [UIColor whiteColor];

   [self presentViewController:navigationController animated:YES completion:nil];
}


- (void)viewController:(GTMOAuth2ViewControllerTouch *)viewController
      finishedWithAuth:(GTMOAuth2Authentication *)auth
                 error:(NSError *)error {
   [self cancelGdriveSignIn:nil];

   if (error != nil) {
      // Authentication failed
      NSLog(@"failed");
   } else {
      // Authentication succeeded
      NSLog(@"Success");

      [[GYoutubeHelper getInstance] saveAuthorizer:auth];
   }
}


- (void)cancelGdriveSignIn:(id)cancelGdriveSignIn {
   [self dismissViewControllerAnimated:YES completion:^(void) {
   }];
}


#pragma mark -
#pragma mark cell


//"https://yt3.ggpht.com/-NvptLtFVHnM/AAAAAAAAAAI/AAAAAAAAAAA/glOMyY45o-0/s240-c-k-no/photo.jpg"
- (void)bind:(UITableViewCell *)cell atSection:(NSInteger)section atRow:(NSInteger)row {
   LeftMenuItemTree * menuItemTree = self.tableSectionArray[section];
   NSArray * line = menuItemTree.rowsArray[row];

   cell.backgroundColor = [UIColor clearColor];

   // 3
   cell.textLabel.text = line[0];
   if (menuItemTree.remoteImage) {
      [ImageCacheImplement CacheWithImageView:cell.imageView
//                                   withUrl:@"https://yt3.ggpht.com/-NvptLtFVHnM/AAAAAAAAAAI/AAAAAAAAAAA/glOMyY45o-0/s240-c-k-no/photo.jpg"
                                      withUrl:line[1]
                              withPlaceholder:self.placeholderImage
                                         size:CGSizeMake(32, 32)];
   } else {
      cell.imageView.image = [UIImage imageNamed:line[1]];
   }
   cell.imageView.contentMode = UIViewContentModeScaleAspectFit;

   // 4
   cell.selectedBackgroundView = [
    [UIImageView alloc] initWithImage:[[UIImage imageNamed:@"mt_side_menu_selected_bg"]
     stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0]];
}


- (UIImage *)imageWithColor:(UIColor *)color {
   CGRect rect = CGRectMake(0, 0, 26, 26);
   // Create a 1 by 1 pixel context
   UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
   [color setFill];
   UIRectFill(rect);   // Fill it with your color
   UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
   UIGraphicsEndImageContext();

   return image;
}


#pragma mark -
#pragma mark View methods


- (void)setupBackground {
   UIImageView * imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
   imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
   imageView.contentMode = UIViewContentModeScaleAspectFit;
   imageView.image = [UIImage imageNamed:@"mt_side_menu_bg"];

   [self.view addSubview:imageView];
}


- (NSArray *)defaultCategories {
   NSArray * array = @[
    @[ @"Autos & Vehicles", @"Autos" ],
    @[ @"Comedy", @"Comedy" ],
    @[ @"Education", @"Education" ],
    @[ @"Entertainment", @"Entertainment" ],
    @[ @"File & Animation", @"Film" ],
    @[ @"Gaming", @"Games" ],
    @[ @"Howto & Style", @"Howto" ],
    @[ @"Music", @"Music" ],
    @[ @"News & Politics", @"News" ],
    @[ @"Nonprofits & Activism", @"Nonprofit" ],
    @[ @"People & Blogs", @"People" ],
    @[ @"Pets & Animals", @"Animals" ],
    @[ @"Science & Technology", @"Tech" ],
    @[ @"Sports", @"Sports" ],
    @[ @"Travel & Events", @"Travel" ],
   ];


   return array;
}


- (NSArray *)signUserCategories {
   NSArray * array = @[
    @[ @"Subscriptions", @"subscriptions" ],
    @[ @"What to Watch", @"recommended" ],
    @[ @"Favorite", @"favorites" ],
    @[ @"Watch Later", @"watch_later" ],
    @[ @"Playlists", @"playlists" ],
   ];


   return array;
}


@end
