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

   self.myCollapseClick.CollapseClickDelegate = self;
   [self.myCollapseClick reloadCollapseClick];

   // If you want a cell open on load, run this method:
   [self.myCollapseClick openCollapseClickCellAtIndex:1 animated:NO];

   /*
    // If you'd like multiple cells open on load, create an NSArray of NSNumbers
    // with each NSNumber corresponding to the index you'd like to open.
    // - This will open Cells at indexes 0,2 automatically

    NSArray *indexArray = @[[NSNumber numberWithInt:0],[NSNumber numberWithInt:2]];
    [myCollapseClick openCollapseClickCellsWithIndexes:indexArray animated:NO];
    */

   self.myCollapseClick.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
}


- (void)didReceiveMemoryWarning {
   [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
}


#pragma mark - Collapse Click Delegate


// Required Methods
- (int)numberOfCellsForCollapseClick {
   return 4;
}


- (NSString *)titleForCollapseClickAtIndex:(int)index {
   switch (index) {
      case 0:
         return @"Login To CollapseClick";
      case 1:
         return @"Create an Account";
      case 2:
         return @"Terms of Service";
      case 3:
         return @"Terms of Service";
   }

   return nil;
}


- (UIView *)viewForCollapseClickContentViewAtIndex:(int)index {
   switch (index) {
      case 0:
         return self.userInfoView;
      case 1:
         return self.userListView;
      case 2:
         return self.subscriptionsView;
      case 3:
         return self.caegoresView;
   }
   return nil;
}


// Optional Methods

- (UIColor *)colorForCollapseClickTitleViewAtIndex:(int)index {
   return [UIColor colorWithRed:223 / 255.0f green:47 / 255.0f blue:51 / 255.0f alpha:1.0];
}


- (UIColor *)colorForTitleLabelAtIndex:(int)index {
   return [UIColor colorWithWhite:1.0 alpha:0.85];
}


- (UIColor *)colorForTitleArrowAtIndex:(int)index {
   return [UIColor colorWithWhite:0.0 alpha:0.25];
}


- (void)didClickCollapseClickCellAtIndex:(int)index isNowOpen:(BOOL)open {
   NSLog(@"%d and it's open:%@", index, (open ? @"YES" : @"NO"));
}


@end
