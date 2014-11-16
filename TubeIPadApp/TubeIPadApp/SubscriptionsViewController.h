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


@interface SubscriptionsViewController : UINavigationController

@property(nonatomic, strong) UIBarButtonItem * revealButtonItem;

- (void)startToggleLeftMenuWithTitle:(NSString *)title withType:(enum YTPlaylistItemsType)playlistItemsType;
- (void)endToggleLeftMenuEventForChannelPageWithSubscription:(GTLYouTubeSubscription *)subscription withTitle:(NSString *)title;
@end

