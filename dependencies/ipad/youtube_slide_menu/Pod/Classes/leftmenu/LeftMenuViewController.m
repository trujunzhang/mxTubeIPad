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


   self.myCollapseClick.CollapseClickDelegate = self;
   [self.myCollapseClick reloadCollapseClick:backgroundView withSubViews:self.userInfoView];
//   [self.myCollapseClick reloadCollapseClick:backgroundView withSubViews:nil];

   // If you want a cell open on load, run this method:
//   [self.myCollapseClick openCollapseClickCellAtIndex:0 animated:NO];

   /*
    // If you'd like multiple cells open on load, create an NSArray of NSNumbers
    // with each NSNumber corresponding to the index you'd like to open.
    // - This will open Cells at indexes 0,2 automatically

    NSArray *indexArray = @[[NSNumber numberWithInt:0],[NSNumber numberWithInt:2]];
    [myCollapseClick openCollapseClickCellsWithIndexes:indexArray animated:NO];
    */

}


- (void)didReceiveMemoryWarning {
   [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
}


#pragma mark - Collapse Click Delegate


// Required Methods
- (int)numberOfCellsForCollapseClick {
   return 3;
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
//         return self.userInfoView;
//      case 1:
         return self.userListView;
      case 1:
         return self.subscriptionsView;
      case 2:
         return self.caegoresView;
   }
   return nil;
}


// Optional Methods

- (UIColor *)colorForCollapseClickTitleViewAtIndex:(int)index {
//   return [UIColor colorWithRed:223 / 255.0f green:47 / 255.0f blue:51 / 255.0f alpha:1.0];
   return [UIColor clearColor];
}


- (UIColor *)colorForTitleLabelAtIndex:(int)index {
//   return [UIColor colorWithWhite:1.0 alpha:0.85];
   return [UIColor blackColor];
}


- (UIColor *)colorForTitleArrowAtIndex:(int)index {
//   return [UIColor colorWithWhite:0.0 alpha:0.25];
   return [UIColor blackColor];
}


- (void)didClickCollapseClickCellAtIndex:(int)index isNowOpen:(BOOL)open {
   NSLog(@"%d and it's open:%@", index, (open ? @"YES" : @"NO"));
}


#pragma mark -
#pragma mark - Layout

//
//- (void)viewDidLayoutSubviews {
//   [super viewDidLayoutSubviews];
//
//   CGRect rect = self.view.frame;
//
//   self.myCollapseClick.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//   rect = self.myCollapseClick.frame;
//   rect.size.width = self.view.frame.size.width;
//   rect.size.height = self.view.frame.size.height;
//   self.myCollapseClick.frame = rect;
//
//   self.userInfoView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//   rect = self.userInfoView.frame;
//   rect.size.width = self.view.frame.size.width;
//   self.userInfoView.frame = rect;
//
//
//}


@end
