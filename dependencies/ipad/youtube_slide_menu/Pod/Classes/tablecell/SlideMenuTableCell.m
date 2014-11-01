//
//  SlideMenuTableCell.m
//  IOSTemplate
//
//  Created by djzhang on 11/1/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import <IOS_Collection_Code/ImageCacheImplement.h>
#import "SlideMenuTableCell.h"


@implementation SlideMenuTableCell

- (void)awakeFromNib {
   // Initialization code
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
   [super setSelected:selected animated:animated];

   // Configure the view for the selected state
}


//"https://yt3.ggpht.com/-NvptLtFVHnM/AAAAAAAAAAI/AAAAAAAAAAA/glOMyY45o-0/s240-c-k-no/photo.jpg"
- (void)bind:(NSArray *)line hasRemote:(BOOL)remote withPlaceHolder:(UIImage *)holder {

   self.backgroundColor = [UIColor clearColor];

   // 3
   self.textLabel.text = line[0];
//   if (remote) {
      [ImageCacheImplement CacheWithImageView:self.imageView
//                                      withUrl:line[1]
                                      withUrl:@"https://yt3.ggpht.com/-NvptLtFVHnM/AAAAAAAAAAI/AAAAAAAAAAA/glOMyY45o-0/s240-c-k-no/photo.jpg"
                              withPlaceholder:holder
//                       withCompletionBlock:block];
      ];
//   } else {
//      self.imageView.image = [UIImage imageNamed:line[1]];
//   }
   self.imageView.contentMode = UIViewContentModeScaleAspectFit;

   // 4
   self.selectedBackgroundView = [
    [UIImageView alloc] initWithImage:[[UIImage imageNamed:@"mt_side_menu_selected_bg"]
     stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0]];
}
@end