//
//  YoutubeChannelTopCell.m
//  IOSTemplate
//
//  Created by djzhang on 11/12/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import <IOS_Collection_Code/ImageCacheImplement.h>
#import "YoutubeChannelTopCell.h"


@implementation YoutubeChannelTopCell

- (instancetype)initWithSubscription:(YTYouTubeSubscription *)subscription {
   NSArray * subviewArray = [[NSBundle mainBundle] loadNibNamed:@"YoutubeChannelTopCell" owner:self options:nil];
   UIView * mainView = [subviewArray objectAtIndex:0];
   if (self) {
      self.shadowView.backgroundColor = [UIColor whiteColor];

      self.shadowView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
      self.shadowView.layer.shadowOffset = CGSizeMake(2, 2);
      self.shadowView.layer.shadowOpacity = 1;
      self.shadowView.layer.shadowRadius = 1.0;

      [self bind:subscription];
   }
   return mainView;
}


- (void)bind:(YTYouTubeSubscription *)subscription {
//   UIImageView * youtubeCover;
//   UIImageView * channelPhoto;
//   UILabel * channelTitle;
//   UILabel * channelSubscriberCount;
//   UIButton * channelSubscribedState;

   [ImageCacheImplement CacheWithImageView:self.channelPhoto
                                   withUrl:subscription.snippet.thumbnails.high.url
                           withPlaceholder:[UIImage imageNamed:@"account_default_thumbnail.png"]
   ];


   [self.channelTitle setText:subscription.snippet.title];

}
@end
