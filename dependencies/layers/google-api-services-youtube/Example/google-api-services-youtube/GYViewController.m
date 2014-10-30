//
//  GYViewController.m
//  google-api-services-youtube
//
//  Created by wanghaogithub720 on 09/25/2014.
//  Copyright (c) 2014 wanghaogithub720. All rights reserved.
//

#import "GYViewController.h"
#import "GYSearch.h"


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
   NSString * debug = @"debug";
}


- (void)didReceiveMemoryWarning {
   [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
}

@end
