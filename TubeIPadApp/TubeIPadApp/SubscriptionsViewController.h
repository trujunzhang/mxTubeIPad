//
//  SubscriptionsViewController.h
//  TubeIPadApp
//
//  Created by djzhang on 10/23/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YoutubeCollectionView/IpadGridViewCell.h>
@class LeftMenuItemTree;


@interface SubscriptionsViewController : UINavigationController<IpadGridViewCellDelegate>

@property(nonatomic, strong) UIBarButtonItem * revealButtonItem;

- (void)refreshByLeftMenu:(NSArray *)array withModel:(LeftMenuItemTree *)menuItemTree withRow:(NSArray *)row;
@end

