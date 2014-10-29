//
//  LeftMenuViewController.m
//  NIBMultiViewsApp
//
//  Created by djzhang on 10/27/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "UserInfoView.h"
#import "UserListView.h"
#import "SubscriptionsView.h"
#import "CategoriesView.h"


@interface LeftMenuViewController ()

@end


@implementation LeftMenuViewController

- (void)viewDidLoad {
   [super viewDidLoad];
   // Do any additional setup after loading the view from its nib.

   CGRect rect = self.view.frame;

   UIImage * image = [UIImage imageNamed:@"mt_side_menu_bg.png"];
   UIImageView * backgroundView = [[UIImageView alloc] initWithImage:image];
//   backgroundView.frame= CGRectMake(0, 0, 260, 2000);
   backgroundView.contentMode = UIViewContentModeScaleAspectFit;
}


- (void)didReceiveMemoryWarning {
   [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
}


@end
