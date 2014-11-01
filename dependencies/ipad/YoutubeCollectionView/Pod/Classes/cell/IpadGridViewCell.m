//
//  IpadGridViewCell.m
//  app
//
//  Created by djzhang on 9/16/14.
//  Copyright (c) 2014 xinma. All rights reserved.
//

#import "IpadGridViewCell.h"

#import "GTLYouTubeVideo.h"
#import "GTLYouTubeVideoSnippet.h"
#import "GTLYouTubeThumbnailDetails.h"
#import "GTLYouTubeVideoContentDetails.h"
#import "GTLYouTubeVideoStatistics.h"
#import "GTLYouTubeThumbnail.h"

#import "IpadGridViewInfoCell.h"
#import "IpadGridViewUserCell.h"

#import "ImageCacheImplement.h"


@implementation IpadGridViewCell

- (void)setupUI:(GTLYouTubeVideo *)video {
   // Add other views
   if (self.infoCell == nil) {
      NSArray * infoCellViews = [[NSBundle mainBundle] loadNibNamed:@"IpadGridViewInfoCell"
                                                              owner:self
                                                            options:nil];
      self.infoCell = [infoCellViews lastObject];
      self.infoCell.backgroundColor = [UIColor clearColor];
      self.infoCell.frame = CGRectMake(0, 0, self.infoView.frame.size.width, self.infoView.frame.size.height);
      [self.infoView addSubview:self.infoCell];

      [self.infoCell bind:video];
   }

   if (self.userCell == nil) {
      NSArray * userCellViews = [[NSBundle mainBundle] loadNibNamed:@"IpadGridViewUserCell"
                                                              owner:self
                                                            options:nil];
      self.userCell = [userCellViews lastObject];
      self.userCell.backgroundColor = [UIColor clearColor];
      self.userCell.frame = CGRectMake(0, 0, self.userView.frame.size.width, self.userView.frame.size.height);
      [self.userView addSubview:self.userCell];

      [self.userCell bind:video];
   }
}


- (void)bind:(GTLYouTubeVideo *)video placeholderImage:(UIImage *)image delegate:(id<IpadGridViewCellDelegate>)delegate {
   self.video = video;
   self.delegate = delegate;

   [self setupUI:video];

   // Confirm that the result represents a video. Otherwise, the
   // item will not contain a video ID.

   // 1
   [ImageCacheImplement CacheWithImageView:self.thumbnails
                                   withUrl:video.snippet.thumbnails.high.url
                           withPlaceholder:image];
   // UIImageView Touch event
   UITapGestureRecognizer * singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(tapDetected)];
   singleTap.numberOfTapsRequired = 1;
   [self.thumbnails setUserInteractionEnabled:YES];
   [self.thumbnails addGestureRecognizer:singleTap];

//   self.thumbnails.image = [UIImage imageNamed:video.snippet.channelId];// test


   // UIView Touch event
   UITapGestureRecognizer * singleTapPanel = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(tapDetected)];
   singleTapPanel.numberOfTapsRequired = 1;
   [self.infoView setUserInteractionEnabled:YES];
   [self.infoView addGestureRecognizer:singleTapPanel];
}


- (void)tapDetected {
   NSLog(@"single Tap on imageview");

   if (self.delegate) {
      [self.delegate gridViewCellTap:self.video sender:self.delegate];
   }
}

@end
