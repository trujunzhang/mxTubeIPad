//
//  UserInfoView.m
//  NIBMultiViewsApp
//
//  Created by djzhang on 10/27/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import "UserInfoView.h"

#import "GYoutubeAuthUser.h"
#import "GTLYouTubeChannel.h"
#import "GTLYouTubeChannelSnippet.h"
#import "GTLYouTubeThumbnailDetails.h"
#import "GTLYouTubeThumbnail.h"

#import "UIImageView+Cache.h"


@implementation UserInfoView

//"https://yt3.ggpht.com/-NvptLtFVHnM/AAAAAAAAAAI/AAAAAAAAAAA/glOMyY45o-0/s240-c-k-no/photo.jpg"
- (UIView *)bind:(GYoutubeAuthUser *)user {
   if (user == nil)
      return self;

   GTLYouTubeChannel * channel = user.channel;
   NSString * channelTitle = channel.snippet.title;
   NSString * channelThumbnailsUrl = channel.snippet.thumbnails.high.url;

   // 1
//   channelThumbnailsUrl = @"https://yt3.ggpht.com/-NvptLtFVHnM/AAAAAAAAAAI/AAAAAAAAAAA/glOMyY45o-0/s240-c-k-no/photo.jpg";
   UIImage * image = [UIImage imageNamed:@"account_default_thumbnail.png"];
   [self.userHeader setImageWithURL:[NSURL URLWithString:channelThumbnailsUrl] placeholderImage:image];
   self.userTitle.text = channelTitle;
   self.userEmail.text = channelThumbnailsUrl;

   // UIImageView Touch event
   UITapGestureRecognizer * singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(tapSignOut)];
   singleTap.numberOfTapsRequired = 1;
   [self.logOutImage setUserInteractionEnabled:YES];
   [self.logOutImage addGestureRecognizer:singleTap];

   return self;
}


- (void)tapSignOut {
   NSString * debug = @"debug";
}
@end
