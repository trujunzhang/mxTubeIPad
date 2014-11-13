//
//  YoutubeChannelPageViewController.m
//  IOSTemplate
//
//  Created by djzhang on 11/12/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import "YoutubeChannelPageViewController.h"
#import "YoutubeChannelTopCell.h"
#import "UIView+Shadow.h"
#import "GYoutubeRequestInfo.h"


@interface YoutubeChannelPageViewController ()
@property(nonatomic, strong) UIView * topBanner;
@property(nonatomic, strong) UISegmentedControl * pageSegmentController;
@end


@implementation YoutubeChannelPageViewController

- (void)viewDidLoad {
   [super viewDidLoad];

   // Do any additional setup after loading the view from its nib.
   // 1 
   self.topBanner = [self makeTopBanner];
   [self.view addSubview:self.topBanner];

   // 2
   [self makeSegmentWithRect:self.topBanner.frame];
   [self addSeperatorForSegment:self.pageSegmentController];
}


- (void)addSeperatorForSegment:(UISegmentedControl *)segmentedControll {
   for (int i = 0; i < [segmentedControll.subviews count]; i++) {
      [[segmentedControll.subviews objectAtIndex:i] setTintColor:nil];
      if (![[segmentedControll.subviews objectAtIndex:i] isSelected]) {
         UIColor * tintcolor = [UIColor blackColor];
         [[segmentedControll.subviews objectAtIndex:i] setTintColor:tintcolor];
      }
      else {
         UIColor * tintcolor = [UIColor blueColor];
         [[segmentedControll.subviews objectAtIndex:i] setTintColor:tintcolor];
      }
   }

}


- (void)makeSegmentWithRect:(CGRect)rect {
   self.pageSegmentController = [[UISegmentedControl alloc] initWithItems:[GYoutubeRequestInfo getChannelPageSegmentTitlesArray]];

   self.pageSegmentController.selectedSegmentIndex = 0;
   self.pageSegmentController.autoresizingMask = UIViewAutoresizingFlexibleWidth;
   self.pageSegmentController.frame = CGRectMake(0, rect.origin.y + rect.size.height, 300, 30);
   self.pageSegmentController.center = self.view.center;
   self.pageSegmentController.tintColor = [UIColor redColor];
}


- (UIView *)makeTopBanner {
   CGRect statusRect = [[UIApplication sharedApplication] statusBarFrame];
   CGFloat statusbarHeight = statusRect.size.height;
   CGFloat navbarHeight = 46;

   YoutubeChannelTopCell * topView = [[YoutubeChannelTopCell alloc] init];

   CGRect rect = self.view.bounds;
   rect.origin.y = statusbarHeight + navbarHeight;
   rect.size.height = topView.frame.size.height;
   topView.frame = rect;

   topView.autoresizingMask = UIViewAutoresizingFlexibleWidth;

   return topView;
}


- (void)didReceiveMemoryWarning {
   [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
}


@end
