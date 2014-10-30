//
//  GYViewController.m
//  google-api-services-youtube
//
//  Created by wanghaogithub720 on 09/25/2014.
//  Copyright (c) 2014 wanghaogithub720. All rights reserved.
//

#import "GYViewController.h"

#import "GYSearch.h"
#import "GTMOAuth2ViewControllerTouch.h"


@interface GYViewController ()

@end


@implementation GYViewController

- (void)viewDidLoad {
   [super viewDidLoad];
   // Do any additional setup after loading the view, typically from a nib.

   YoutubeResponseBlock completion = ^(NSArray * array) {
       NSString * debug = @"debug";
   };
   ErrorResponseBlock error = ^(NSError * error) {
       NSString * debug = @"debug";
   };
   [[GYSearch getInstance] searchByQueryWithQueryTerm:@"sketch3" completionHandler:completion errorHandler:error];

   [self setupUI];
}


- (void)setupUI {
   //1. edit button
   UIButton * editButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
   editButton.frame = CGRectMake(100, 100, 100, 100);
   [editButton addTarget:self
                  action:@selector(editBtnTouch)
        forControlEvents:UIControlEventTouchDown];

   [editButton setTitle:@"Effects" forState:UIControlStateNormal];

   [self.view addSubview:editButton];

   //1. edit button
   UIButton * refreshButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
   refreshButton.frame = CGRectMake(300, 100, 100, 100);
   [refreshButton addTarget:self
                     action:@selector(refreshButtonTouch)
           forControlEvents:UIControlEventTouchDown];

   [refreshButton setTitle:@"refreshButton" forState:UIControlStateNormal];

   [self.view addSubview:refreshButton];

   //2 user label
   self.label = [[UILabel alloc] init];
   self.label.frame = CGRectMake(100, 400, 300, 100);
   self.label.textColor = [UIColor redColor];
   self.label.text = @"djzhang";

   [self.view addSubview:self.label];

   [self refreshButtonTouch];
}


- (void)refreshButtonTouch {
   BOOL isSignedIn = [[GYSearch getInstance] isSignedIn];
   if (isSignedIn) {
      self.label.text = [[GYSearch getInstance] getAuthorizer].userEmail;
   }
}


- (void)editBtnTouch {
   GTMOAuth2ViewControllerTouch * viewController =
    [[GYSearch getInstance] getYoutubeOAuth2ViewControllerTouchWithTouchDelegate:self
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

      [[GYSearch getInstance] saveAuthorizer:auth];
   }
}


- (void)cancelGdriveSignIn:(id)cancelGdriveSignIn {
   [self dismissViewControllerAnimated:YES completion:^(void) {
   }];
}


- (void)didReceiveMemoryWarning {
   [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
}

@end
