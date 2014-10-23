//
//  IpadGridViewUserCell.h
//  IOSTemplate
//
//  Created by djzhang on 10/23/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GTLYouTubeVideo;


@interface IpadGridViewUserCell : UIView

@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *headerImage;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *userNameLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *subscribeBgImage;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *subscribeImage;

- (void)bind:(GTLYouTubeVideo *)video;
@end
