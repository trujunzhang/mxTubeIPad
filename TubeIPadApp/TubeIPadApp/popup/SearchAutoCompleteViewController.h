//
//  SearchAutoCompleteViewController.h
//  TubeIPadApp
//
//  Created by djzhang on 11/21/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SearchAutoCompleteViewController : UITableViewController

@property(nonatomic, strong) id<UITableViewDelegate> selectedDelegate;
- (instancetype)initWithSelectedDelegate:(id<UITableViewDelegate>)selectedDelegate;

- (void)resetTableSource:(NSMutableArray *)array;
- (void)empty;
@end
