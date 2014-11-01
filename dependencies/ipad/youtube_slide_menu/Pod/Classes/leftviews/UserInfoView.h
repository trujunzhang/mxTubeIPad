//
//  UserInfoView.h
//  NIBMultiViewsApp
//
//  Created by djzhang on 10/27/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GYoutubeAuthUser;


@interface UserInfoView : UIView
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView * userHeader;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *userTitle;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *userEmail;

@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *logOutImage;


- (UIView *)bind:(GYoutubeAuthUser *)user;
@end
