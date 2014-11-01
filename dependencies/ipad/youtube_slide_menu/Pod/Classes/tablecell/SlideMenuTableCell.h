//
//  SlideMenuTableCell.h
//  IOSTemplate
//
//  Created by djzhang on 11/1/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SlideMenuTableCell : UITableViewCell

- (void)bind:(NSArray *)array hasRemote:(BOOL)remote withPlaceHolder:(UIImage *)holder;
@end
