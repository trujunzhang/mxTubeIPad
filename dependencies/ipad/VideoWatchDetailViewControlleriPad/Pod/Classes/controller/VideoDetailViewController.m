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


@interface VideoDetailViewController ()
@property(nonatomic, strong) CURRENT_VIDEODETAIL_PANEL * videoDetailPanel;
@end


@implementation VideoDetailViewController

- (void)viewDidLoad {
   [super viewDidLoad];
   // Do any additional setup after loading the view.

//   self.videoDetailPanel = [[CURRENT_VIDEODETAIL_PANEL alloc] initWithVideo:self.video];
//   [self.videoDetailController.view addSubview:self.videoDetailPanel.view];
   self.videoDetailScrollView = [[UIScrollView alloc] init];
   self.videoDetailScrollView.backgroundColor = [UIColor blackColor];
   [self.view addSubview:self.videoDetailScrollView];
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


@end
