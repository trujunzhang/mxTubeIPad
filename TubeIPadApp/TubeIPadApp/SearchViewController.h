//
//  SearchViewController.h
//  TubeIPadApp
//
//  Created by djzhang on 10/23/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <YoutubeCollectionView/YoutubeGridLayoutViewController.h>


@interface SearchViewController : YoutubeGridLayoutViewController<IpadGridViewCellDelegate, UISearchBarDelegate>

//@property(nonatomic, strong)  * youtubeGridLayoutViewController;
@end

