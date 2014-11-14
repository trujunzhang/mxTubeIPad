//
//  YoutubeChannelTopCell.m
//  IOSTemplate
//
//  Created by djzhang on 11/12/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import "YoutubeChannelTopCell.h"


@implementation YoutubeChannelTopCell

- (id)init {
   NSArray * subviewArray = [[NSBundle mainBundle] loadNibNamed:@"YoutubeChannelTopCell" owner:self options:nil];
   id mainView = [subviewArray objectAtIndex:0];


   self.shadowView.backgroundColor = [UIColor whiteColor];

   self.shadowView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
   self.shadowView.layer.shadowOffset = CGSizeMake(2, 2);
   self.shadowView.layer.shadowOpacity = 1;
   self.shadowView.layer.shadowRadius = 1.0;


   return mainView;
}


- (void)bind:(YTYouTubeSubscription *)subscription {

}
@end
