//
//  YTGridViewVideoCell.m
//  IOSTemplate
//
//  Created by djzhang on 11/10/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import <google-api-services-youtube/YoutubeConstants.h>
#import <YoutubeCollectionView/IpadGridViewCell.h>
#import <IOS_Collection_Code/ImageCacheImplement.h>
#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "YTGridViewVideoCell.h"
#import "ImageViewEffect.h"
#import "UIView+WhenTappedBlocks.h"


@interface YTGridViewVideoCell ()
@property(nonatomic, strong) YTYouTubeVideo * video;
@property(nonatomic, strong) id<IpadGridViewCellDelegate> delegate;
@end


@implementation YTGridViewVideoCell

- (id)initWithFrame:(CGRect)frame {
   self = [super initWithFrame:frame];

   if (self) {
      // Initialization code
      NSArray * arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"YTGridViewVideoCell" owner:self options:nil];

      if ([arrayOfViews count] < 1) {
         return nil;
      }

      if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]]) {
         return nil;
      }

      self = [arrayOfViews objectAtIndex:0];
   }

   return self;
}


- (void)bind:(YTYouTubeVideo *)video placeholderImage:(UIImage *)image delegate:(id<IpadGridViewCellDelegate>)delegate {
   self.video = video;
   self.delegate = delegate;

   // Confirm that the result represents a video. Otherwise, the
   // item will not contain a video ID.
   // 1
   ASImageNode * imageNode = [[ASImageNode alloc] init];
   imageNode.backgroundColor = [UIColor lightGrayColor];
   imageNode.frame = self.videoThumbnailsContainer.bounds;
   [self.videoThumbnailsContainer addSubview:imageNode.view];

//   [ImageViewEffect setEffectImage:self.videoThumbnails withCornerRadius:70.0f];
   [ImageCacheImplement CacheWithImageView:imageNode
                                       key:video.identifier
                                   withUrl:video.snippet.thumbnails.medium.url
                           withPlaceholder:image
   ];

   // configure the button
   imageNode.userInteractionEnabled = YES; // opt into touch handling
   [imageNode addTarget:self
                 action:@selector(tapDetected)
       forControlEvents:ASControlNodeEventTouchUpInside];


   // 2
   [self.videoTitle setText:video.snippet.title];
   // 3
   [self.videoRatingLabel setText:[NSString stringWithFormat:@"%@", video.statistics.likeCount]];
   [self.videoViewCountLabel setText:[NSString stringWithFormat:@"%@", video.statistics.viewCount]];

   // 4
   [self.videoChannelTitleLabel setText:video.snippet.channelTitle];

   // 5
   NSUInteger text = video.contentDetails.duration;
//   NSLog(@" %d= text", text);
   NSString * string = [self timeFormatConvertToSeconds:[NSString stringWithFormat:@"%d",
                                                                                   video.contentDetails.duration]];
//   NSLog(@"duration = %@", string);
//   [self.durationLabel setText:string];
//   [self.durationLabel sizeToFit];


   self.videoInfoContainer.layer.shadowColor = [UIColor lightGrayColor].CGColor;
   self.videoInfoContainer.layer.shadowOffset = CGSizeMake(2, 2);
   self.videoInfoContainer.layer.shadowOpacity = 1;
   self.videoInfoContainer.layer.shadowRadius = 1.0;
}


- (void)bind123:(YTYouTubeVideo *)video placeholderImage:(UIImage *)image delegate:(id<IpadGridViewCellDelegate>)delegate {
   self.video = video;
   self.delegate = delegate;

   // Confirm that the result represents a video. Otherwise, the
   // item will not contain a video ID.
   // 1
//   [ImageViewEffect setEffectImage:self.videoThumbnails withCornerRadius:70.0f];
   [ImageCacheImplement CacheWithImageView:self.videoThumbnails
                                   withUrl:video.snippet.thumbnails.medium.url
                           withPlaceholder:image
   ];
//   NSLog(@"url= %@", video.snippet.thumbnails.medium.url);
   // UIImageView Touch event
//   UITapGestureRecognizer * singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
//                                                                                action:@selector(tapDetected)];
//   singleTap.numberOfTapsRequired = 1;
//   [self.videoThumbnails setUserInteractionEnabled:YES];
//   [self.videoThumbnails addGestureRecognizer:singleTap];
   [self.videoThumbnails whenTouchedUp:^{
       [self tapDetected];
//       NSLog(@"I was touched up!");
   }];

   // 2
   [self.videoTitle setText:video.snippet.title];
   // 3
   [self.videoRatingLabel setText:[NSString stringWithFormat:@"%@", video.statistics.likeCount]];
   [self.videoViewCountLabel setText:[NSString stringWithFormat:@"%@", video.statistics.viewCount]];

   // 4
   [self.videoChannelTitleLabel setText:video.snippet.channelTitle];

   // 5
   NSUInteger text = video.contentDetails.duration;
//   NSLog(@" %d= text", text);
   NSString * string = [self timeFormatConvertToSeconds:[NSString stringWithFormat:@"%d",
                                                                                   video.contentDetails.duration]];
//   NSLog(@"duration = %@", string);
//   [self.durationLabel setText:string];
//   [self.durationLabel sizeToFit];


   self.videoInfoContainer.layer.shadowColor = [UIColor lightGrayColor].CGColor;
   self.videoInfoContainer.layer.shadowOffset = CGSizeMake(2, 2);
   self.videoInfoContainer.layer.shadowOpacity = 1;
   self.videoInfoContainer.layer.shadowRadius = 1.0;
}


- (NSString *)timeFormatConvertToSeconds:(NSString *)timeSecs {
   int totalSeconds = [timeSecs intValue];

   int seconds = totalSeconds % 60;
   int minutes = (totalSeconds / 60) % 60;
   int hours = totalSeconds / 3600;
   if (hours == 0) {
      return [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
   }

   return [NSString stringWithFormat:@"%02d:%02d:%02d", hours, minutes, seconds];
}


- (void)tapDetected {
   NSLog(@"single Tap on imageview");

   if (self.delegate) {
      [self.delegate gridViewCellTap:self.video sender:self.delegate];
   }
}


@end
