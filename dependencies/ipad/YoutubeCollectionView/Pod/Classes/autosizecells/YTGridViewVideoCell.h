//
//  YTGridViewVideoCell.h
//  IOSTemplate
//
//  Created by djzhang on 11/10/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface YTGridViewVideoCell : UICollectionViewCell
@property(strong, nonatomic) IBOutlet UIImageView * videoThumbnails;
@property(strong, nonatomic) IBOutlet UILabel * videoTitle;
@property(strong, nonatomic) IBOutlet UILabel * videoRatingLabel;
@property(strong, nonatomic) IBOutlet UILabel * videoViewCountLabel;
@property(strong, nonatomic) IBOutlet UIImageView * videoChannelThumbnails;
@property(strong, nonatomic) IBOutlet UILabel * videoChannelTitleLabel;
@end
