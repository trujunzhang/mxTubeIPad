//
//  VideoDetailViewController.m
//  YoutubePlayApp
//
//  Created by djzhang on 10/14/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import "VideoDetailViewController.h"

#import "VideoDetailPanel.h"
#import "AsyncVideoDetailPanel.h"


@interface VideoDetailViewController ()<ASTableViewDataSource, ASTableViewDelegate> {
   ASTableView * _tableView;
}
//@property(nonatomic, strong) CURRENT_VIDEODETAIL_PANEL * videoDetailPanel;
@end


@implementation VideoDetailViewController

- (instancetype)initWithVideo:(YTYouTubeVideoCache *)video {
   self = [super init];
   if (self) {
      self.video = video;
   }

   return self;
}


- (void)viewDidLoad {
   [super viewDidLoad];

   // Do any additional setup after loading the view.

   // 1
   self.videoDetailScrollView = [[UIScrollView alloc] init];
   self.videoDetailScrollView.directionalLockEnabled = YES;
   self.videoDetailScrollView.pagingEnabled = NO;


   self.videoDetailScrollView.backgroundColor = [UIColor greenColor];
   [self.view addSubview:self.videoDetailScrollView];

   // 2
   self.videoDetailPanel = [[CURRENT_VIDEODETAIL_PANEL alloc] initWithVideo:self.video];
   [self.videoDetailScrollView addSubview:self.videoDetailPanel.view];

//   [videoDetailScrollView addSubview:self.videoDetailPanel.view];

//   self.view = self.videoDetailPanel.view;
//   self.videoDetailController.view = videoDetailScrollView;

//   self.videoDetailPanel.view.frame = self.videoDetailController.view.frame;
//   self.videoDetailPanel.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
}


- (void)didReceiveMemoryWarning {
   [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark Rotation stuff


- (void)viewDidLayoutSubviews {
   [super viewDidLayoutSubviews];

   [self updateLayout:[UIApplication sharedApplication].statusBarOrientation];
}


- (void)updateLayout:(UIInterfaceOrientation)toInterfaceOrientation {
   BOOL isPortrait = (toInterfaceOrientation == UIInterfaceOrientationPortrait) || (toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);

   // 2
   [self.videoDetailPanel setCurrentFrame:self.view.bounds];

   // 1
   self.videoDetailScrollView.frame = self.view.bounds;
   [self.videoDetailScrollView setContentSize:self.view.frame.size];


//   self.videoDetailPanel.view.frame = self.videoDetailController.view.frame;
//   self.videoDetailPanel.frame = self.videoDetailController.view.frame;
//   [self.videoDetailPanel setCurrentFrame:self.videoDetailController.view.frame];
}


@end
