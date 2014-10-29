//
//  LeftMenuViewController.h
//  NIBMultiViewsApp
//
//  Created by djzhang on 10/27/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UserInfoView;
@class UserListView;
@class SubscriptionsView;
@class CategoriesView;


@interface LeftMenuViewController : UIViewController


@property(strong, nonatomic) IBOutlet UserInfoView * userInfoView;
@property(strong, nonatomic) IBOutlet UserListView * userListView;
@property(strong, nonatomic) IBOutlet SubscriptionsView * subscriptionsView;
@property(strong, nonatomic) IBOutlet CategoriesView * caegoresView;

@end
