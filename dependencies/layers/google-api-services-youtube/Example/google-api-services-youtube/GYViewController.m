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

   //2 user label
   UILabel * label = [[UILabel alloc] init];
   label.frame = CGRectMake(100, 300, 100, 100);
   label.textColor = [UIColor redColor];
   label.text = @"wanghao";

   GTMOAuth2Authentication * authentication = [[GYSearch getInstance] getAuthorizer];


   [self.view addSubview:label];
}


- (void)editBtnTouch {
   GTMOAuth2ViewControllerTouch * viewController =
    [[GYSearch getInstance] getYoutubeOAuth2ViewControllerTouchWithDelegate:self
                                                               cancelAction:@selector(cancelGdriveSignIn:)];

   UINavigationController * naviBarObj = [[UINavigationController alloc] initWithRootViewController:viewController];

   [self presentViewController:naviBarObj animated:YES completion:nil];
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
