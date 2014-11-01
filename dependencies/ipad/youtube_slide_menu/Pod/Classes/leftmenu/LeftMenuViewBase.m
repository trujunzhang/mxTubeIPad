//
//  LeftMenuViewBase.m
//  STCollapseTableViewDemo
//
//  Created by Thomas Dupont on 09/08/13.
//  Copyright (c) 2013 iSofTom. All rights reserved.
//

#import "LeftMenuViewBase.h"
#import "UserInfoView.h"
#import "SearchImplementation.h"


@interface LeftMenuViewBase ()<UITableViewDataSource, UITableViewDelegate>

@end


@implementation LeftMenuViewBase


- (void)viewDidLoad {
   [super viewDidLoad];

   // 1
   [self setupBackground];

}


#pragma mark -
#pragma mark Youtube auth login events


- (UserInfoView *)getUserInfoPanel {

   BOOL isSignedIn = [[SearchImplementation getInstance] isSignedIn];

   UIView * userInfoView = nil;
   if (isSignedIn) {
      userInfoView = [[[NSBundle mainBundle] loadNibNamed:@"UserInfoView" owner:nil options:nil] lastObject];
   } else {
      userInfoView = [[[NSBundle mainBundle] loadNibNamed:@"UserLoginView" owner:nil options:nil] lastObject];

      //The setup code (in viewDidLoad in your view controller)
      UITapGestureRecognizer * singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                         action:@selector(handleSingleTap:)];
      [userInfoView addGestureRecognizer:singleFingerTap];
   }

   userInfoView.frame = CGRectMake(0, 0, 256, 100);

   return userInfoView;
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


@end
