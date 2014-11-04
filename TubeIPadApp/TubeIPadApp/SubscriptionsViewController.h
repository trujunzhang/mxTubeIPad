//
//  SubscriptionsViewController.h
//  TubeIPadApp
//
//  Created by djzhang on 10/23/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YoutubeCollectionView/IpadGridViewCell.h>


@interface SubscriptionsViewController : UINavigationController<IpadGridViewCellDelegate>

@property(nonatomic, strong) UIBarButtonItem * revealButtonItem;



@end

