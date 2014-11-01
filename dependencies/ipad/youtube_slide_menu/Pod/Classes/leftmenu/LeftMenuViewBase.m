//
//  LeftMenuViewBase.m
//  STCollapseTableViewDemo
//
//  Created by Thomas Dupont on 09/08/13.
//  Copyright (c) 2013 iSofTom. All rights reserved.
//

#import "LeftMenuViewBase.h"


@interface LeftMenuViewBase ()<UITableViewDataSource, UITableViewDelegate>

@end


@implementation LeftMenuViewBase


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
