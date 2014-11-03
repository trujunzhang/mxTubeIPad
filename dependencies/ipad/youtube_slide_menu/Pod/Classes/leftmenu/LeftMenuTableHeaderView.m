//
//  LeftMenuTableHeaderView.m
//  STCollapseTableViewDemo
//
//  Created by djzhang on 11/3/14.
//  Copyright (c) 2014 iSofTom. All rights reserved.
//

#import "LeftMenuTableHeaderView.h"


@implementation LeftMenuTableHeaderView

- (void)setupUI:(NSString *)title {
   self.titleLabel.text = title;
}


- (void)setupUIxzxx:(NSString *)title {
   // 1
//   self.backgroundColor = [UIColor clearColor];
   CGRect rect = self.frame;
   CGFloat aWidth = rect.size.width;


   // 3
   UIButton * button = [[UIButton alloc] init];
   rect.origin.x = 200;
   rect.size.width = 20;
   button.frame = rect;
//   UIImage * btnImage = [UIImage imageNamed:@"side_tab_menu_expand"];
//   [button setImage:btnImage forState:UIControlStateNormal];
   button.titleLabel.text = @"wanghao";


//   [self addSubview:button];

   // 2   
   UILabel * number = [[UILabel alloc] init];
   number.textAlignment = NSTextAlignmentLeft;
   number.textColor = [UIColor blackColor];
   number.text = title;

//   [self addSubview:number];
}
@end
