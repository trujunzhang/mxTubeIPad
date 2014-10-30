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

static NSString * const kKeychainItemName = @"OAuth2 Sample: Google+";


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

   //edit button
   UIButton * editButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
   editButton.frame = self.view.frame;
   [editButton addTarget:self
                  action:@selector(editBtnTouch)
        forControlEvents:UIControlEventTouchDown];

   [editButton setTitle:@"Effects" forState:UIControlStateNormal];

   [self.view addSubview:editButton];
}


- (void)editBtnTouch {


   NSString * kMyClientID = @"981239920851-gi3pis2s62pb2miojr2lsukuc8n8405h.apps.googleusercontent.com";     // pre-assigned by service
   NSString * kMyClientSecret = @"wMEhiReTb1_429VsuG9Xu9r0"; // pre-assigned by service

   NSString * scope = @"https://www.googleapis.com/auth/plus.me"; // scope for Google+ API

   GTMOAuth2ViewControllerTouch * viewController =
    [[GTMOAuth2ViewControllerTouch alloc] initWithScope:scope
                                               clientID:kMyClientID
                                           clientSecret:kMyClientSecret
                                       keychainItemName:kKeychainItemName
                                               delegate:self
                                       finishedSelector:@selector(viewController:finishedWithAuth:error:)];

   viewController.navigationItem.leftBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"Cancel", nil)]
                                     style:UIBarButtonItemStyleBordered
                                    target:self
                                    action:@selector(cancelGdriveSignIn:)];

   UINavigationController * naviBarObj = [[UINavigationController alloc] initWithRootViewController:viewController];

   [self presentViewController:naviBarObj animated:YES completion:nil];
}


- (void)cancelGdriveSignIn:(id)cancelGdriveSignIn {
   [self dismissViewControllerAnimated:YES completion:^(void) {
   }];
}


- (void)viewController:(GTMOAuth2ViewControllerTouch *)viewController
      finishedWithAuth:(GTMOAuth2Authentication *)auth
                 error:(NSError *)error {
   if (error != nil) {
      // Authentication failed
      NSLog(@"failed");
   } else {
      // Authentication succeeded
      NSLog(@"Success");
   }
}


- (void)didReceiveMemoryWarning {
   [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
}

@end
