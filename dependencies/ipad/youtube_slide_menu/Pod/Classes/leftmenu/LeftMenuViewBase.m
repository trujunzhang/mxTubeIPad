//
//  LeftMenuViewBase.m
//  STCollapseTableViewDemo
//
//  Created by Thomas Dupont on 09/08/13.
//  Copyright (c) 2013 iSofTom. All rights reserved.
//

#import <IOS_Collection_Code/ImageCacheImplement.h>
#import <Business-Logic-Layer/YoutubeAuthInfo.h>
#import <google-api-services-youtube/GYoutubeHelper.h>
#import "LeftMenuViewBase.h"
#import "UserInfoView.h"
#import "LeftMenuItemTree.h"
#import "ImageViewEffect.h"
#import "LeftMenuTableHeaderView.h"


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
#pragma mark setup


- (void)setupViewController:(NSArray *)subscriptionsArray {
   LeftMenuItemTree * defaultMenuItemTree =
    [[LeftMenuItemTree alloc] initWithTitle:@"  Categories"
                                   itemType:LMenuTreeCategories
                                  rowsArray:[self defaultCategories]
                                  hideTitle:NO
                                remoteImage:NO
                             cellIdentifier:@"CategoriesCellIdentifier"];


   self.tableSectionArray = @[ defaultMenuItemTree ];
   if ([[GYoutubeHelper getInstance] isSignedIn]) {
      LeftMenuItemTree * signUserMenuItemTree =
       [[LeftMenuItemTree alloc] initWithTitle:@"  "
                                      itemType:LMenuTreeUser
                                     rowsArray:[self signUserCategories]
                                     hideTitle:YES
                                   remoteImage:NO
                                cellIdentifier:@"SignUserCellIdentifier"];
      LeftMenuItemTree * subscriptionsMenuItemTree =
       [[LeftMenuItemTree alloc] initWithTitle:@"  Subscriptions"
                                      itemType:LMenuTreeSubscriptions
                                     rowsArray:subscriptionsArray
                                     hideTitle:NO
                                   remoteImage:YES
                                cellIdentifier:@"SubscriptionsCellIdentifier"];
      self.tableSectionArray = @[ signUserMenuItemTree, subscriptionsMenuItemTree, defaultMenuItemTree ];
//      self.tableSectionArray = @[ subscriptionsMenuItemTree, defaultMenuItemTree ];
   }


   self.headers = [[NSMutableArray alloc] init];

   for (int i = 0; i < [self.tableSectionArray count]; i++) {
      LeftMenuItemTree * menuItemTree = self.tableSectionArray[i];

      LeftMenuTableHeaderView * header = [[[NSBundle mainBundle] loadNibNamed:@"LeftMenuTableHeaderView"
                                                                        owner:nil
                                                                      options:nil] lastObject];
      [header setupUI:menuItemTree.title];
      [self.headers addObject:header];
   }

}


#pragma mark -
#pragma mark Youtube auth login events


- (UIView *)getUserHeaderView:(YoutubeAuthInfo *)user {

   UIView * headerView = nil;
   if ([[GYoutubeHelper getInstance] isSignedIn]) {
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

   headerView.frame = CGRectMake(0, 0, 256, 70);

   return headerView;
}


//The event handling method
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
   [self loginInTouch];
}


- (void)loginInTouch {
   GTMOAuth2ViewControllerTouch * viewController =
    [[GYoutubeHelper getInstance] getYoutubeOAuth2ViewControllerTouchWithTouchDelegate:self
                                                                       leftBarDelegate:self
                                                                          cancelAction:@selector(cancelGdriveSignIn:)];

   UINavigationController * navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
   navigationController.view.backgroundColor = [UIColor whiteColor];
   navigationController.modalPresentationStyle = UIModalPresentationPageSheet;

   [self presentViewController:navigationController animated:YES completion:nil];
}


- (void)viewController:(UIViewController *)viewController
      finishedWithAuth:(YTOAuth2Authentication *)auth
                 error:(NSError *)error {
   [self cancelGdriveSignIn:nil];

   if (error != nil) {
      // Authentication failed
      NSLog(@"failed");
   } else {
      // Authentication succeeded
      NSLog(@"Success");

      [[GYoutubeHelper getInstance] saveAuthorizeAndFetchUserInfo:auth];
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

   // 1
   cell.textLabel.text = line[0];
   cell.textLabel.textColor = [UIColor whiteColor];

   // 2
   if (menuItemTree.remoteImage) {
      [ImageViewEffect setEffectImage:cell.imageView withCornerRadius:3.0f];
      [ImageCacheImplement CacheWithImageView:cell.imageView
                                          key:line[2]
                                      withUrl:line[1]
                              withPlaceholder:self.placeholderImage
                                       resize:CGSizeMake(32, 32)
      ];
   } else {
      cell.imageView.image = [UIImage imageNamed:line[1]];
   }
   cell.imageView.contentMode = UIViewContentModeScaleAspectFit;

   // 3
   cell.selectedBackgroundView = [
    [UIImageView alloc] initWithImage:[[UIImage imageNamed:@"mt_side_menu_selected_bg"]
     stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0]];
}


- (UIImage *)imageWithColor:(UIColor *)color {
   CGRect rect = CGRectMake(0, 0, 32, 32);
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
    @[ @"Autos & Vehicles", @"Autos", [[NSNumber alloc] initWithInt:kUploadsTag] ],
    @[ @"Comedy", @"Comedy", [[NSNumber alloc] initWithInt:kUploadsTag] ],
    @[ @"Education", @"Education", [[NSNumber alloc] initWithInt:kUploadsTag] ],
    @[ @"Entertainment", @"Entertainment", [[NSNumber alloc] initWithInt:kUploadsTag] ],
    @[ @"File & Animation", @"Film", [[NSNumber alloc] initWithInt:kUploadsTag] ],
    @[ @"Gaming", @"Games", [[NSNumber alloc] initWithInt:kUploadsTag] ],
    @[ @"Howto & Style", @"Howto", [[NSNumber alloc] initWithInt:kUploadsTag] ],
    @[ @"Music", @"Music", [[NSNumber alloc] initWithInt:kUploadsTag] ],
    @[ @"News & Politics", @"News", [[NSNumber alloc] initWithInt:kUploadsTag] ],
    @[ @"Nonprofits & Activism", @"Nonprofit", [[NSNumber alloc] initWithInt:kUploadsTag] ],
    @[ @"People & Blogs", @"People", [[NSNumber alloc] initWithInt:kUploadsTag] ],
    @[ @"Pets & Animals", @"Animals", [[NSNumber alloc] initWithInt:kUploadsTag] ],
    @[ @"Science & Technology", @"Tech", [[NSNumber alloc] initWithInt:kUploadsTag] ],
    @[ @"Sports", @"Sports", [[NSNumber alloc] initWithInt:kUploadsTag] ],
    @[ @"Travel & Events", @"Travel", [[NSNumber alloc] initWithInt:kUploadsTag] ],
   ];

   return array;
}


- (NSArray *)signUserCategories {
   NSArray * array = @[
    @[ @"Subscriptions", @"subscriptions",
     [[NSNumber alloc] initWithInt:kUploadsTag] ],
    @[ @"What to Watch", @"recommended",
     [[NSNumber alloc] initWithInt:kWatchHistoryTag] ],
    @[ @"Favorite", @"favorites",
     [[NSNumber alloc] initWithInt:kFavoritesTag] ],
    @[ @"Watch Later", @"watch_later",
     [[NSNumber alloc] initWithInt:kWatchLaterTag] ],
    @[ @"Playlists", @"playlists",
     [[NSNumber alloc] initWithInt:kUploadsTag] ],
   ];

   return array;
}


@end
