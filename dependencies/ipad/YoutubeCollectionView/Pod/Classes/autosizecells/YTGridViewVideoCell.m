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
#import "YoutubeParser.h"


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

   NSString * videoThumbnailsUrl = video.snippet.thumbnails.medium.url;
   NSString * videoTitleValue = video.snippet.title;
   NSString * channelTitleValue = video.snippet.channelTitle;

   // Confirm that the result represents a video. Otherwise, the
   // item will not contain a video ID.
   // 1
   ASImageNode * imageNode = [[ASImageNode alloc] init];
   imageNode.backgroundColor = [UIColor lightGrayColor];
   imageNode.frame = self.videoThumbnailsContainer.bounds;
   [self.videoThumbnailsContainer addSubview:imageNode.view];

   [ImageCacheImplement CacheWithImageView:imageNode
                                       key:video.identifier
                                   withUrl:videoThumbnailsUrl
                           withPlaceholder:image
   ];

   // configure the button
   imageNode.userInteractionEnabled = YES; // opt into touch handling
   [imageNode addTarget:self
                 action:@selector(tapDetected)
       forControlEvents:ASControlNodeEventTouchUpInside];


   // 2
   [self.videoTitle setText:videoTitleValue];
   // 3
   [self.videoRatingLabel setText:[NSString stringWithFormat:@"%@", video.statistics.likeCount]];
   [self.videoViewCountLabel setText:[NSString stringWithFormat:@"%@", video.statistics.viewCount]];

   // 4
   [self.videoChannelTitleLabel setText:channelTitleValue];

   // 5
   NSUInteger text = video.contentDetails.duration;
   NSString * string = [YoutubeParser timeFormatConvertToSecondsWithInteger:video.contentDetails.duration];


   // 6
//   self.videoInfoContainer.layer.shadowColor = [UIColor lightGrayColor].CGColor;
//   self.videoInfoContainer.layer.shadowOffset = CGSizeMake(1, 1);
//   self.videoInfoContainer.layer.shadowOpacity = 0.8;
//   self.videoInfoContainer.layer.shadowRadius = 1.0;

   // 7
//   self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
//   self.layer.shadowOffset = CGSizeMake(-2, -2);
//   self.layer.shadowOpacity = 1;
//   self.layer.shadowRadius = 1.0;
}


- (void)tapDetected {
   NSLog(@"single Tap on imageview");

   if (self.delegate) {
      [self.delegate gridViewCellTap:self.video sender:self.delegate];
   }
}


@end
