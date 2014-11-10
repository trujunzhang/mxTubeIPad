//
//  YoutubeFooterView.m
//  IOSTemplate
//
//  Created by djzhang on 11/10/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import "YoutubeFooterView.h"


@implementation YoutubeFooterView

- (id)initWithFrame:(CGRect)frame {
   if (self = [super initWithFrame:frame]) {
      // Initialization code
      NSArray * arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"YoutubeFooterView" owner:self options:nil];

      if ([arrayOfViews count] < 1) {
         return nil;
      }

      if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionReusableView class]]) {
         return nil;
      }

      self = [arrayOfViews objectAtIndex:0];

      [self setupIndicatorView];

      self.backgroundColor = [UIColor clearColor];
   }
   return self;
}


- (void)setupIndicatorView {
   CGRect rect = self.activityIndicatorView.frame;
   rect.size.width = 40;
   rect.size.height = 40;
   self.activityIndicatorView.frame = rect;
}


- (void)startAnimation {
   [self.activityIndicatorView startAnimating];
}
@end
