//
//  LeftMenuViewController.m
//  STCollapseTableViewDemo
//
//  Created by Thomas Dupont on 09/08/13.
//  Copyright (c) 2013 iSofTom. All rights reserved.
//

#import <Business-Logic-Layer/YoutubeAuthInfo.h>
#import "LeftMenuViewController.h"

#import "STCollapseTableView.h"
#import "GYoutubeAuthUser.h"
#import "LeftMenuItemTree.h"
#import "YoutubeAuthDataStore.h"


@interface LeftMenuViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) STCollapseTableView * tableView;

@property(nonatomic, strong) NSMutableArray * headers;

@end


@implementation LeftMenuViewController


- (void)setupViewController:(NSArray *)subscriptionsArray {
   LeftMenuItemTree * defaultMenuItemTree =
    [[LeftMenuItemTree alloc] initWithTitle:@"  Categories"
                                  rowsArray:[self defaultCategories]
                                  hideTitle:NO
                                remoteImage:NO];


   self.tableSectionArray = @[ defaultMenuItemTree ];
   if (subscriptionsArray) {
      LeftMenuItemTree * signUserMenuItemTree =
//       [[LeftMenuItemTree alloc] initWithTitle:nil
       [[LeftMenuItemTree alloc] initWithTitle:@"  wanghao"
                                     rowsArray:[self signUserCategories]
                                     hideTitle:YES
                                   remoteImage:NO];
      LeftMenuItemTree * subscriptionsMenuItemTree =
       [[LeftMenuItemTree alloc] initWithTitle:@"  Subscriptions"
                                     rowsArray:subscriptionsArray
                                     hideTitle:NO
                                   remoteImage:YES];
      self.tableSectionArray = @[ signUserMenuItemTree, subscriptionsMenuItemTree, defaultMenuItemTree ];
//      self.tableSectionArray = @[ subscriptionsMenuItemTree ];
   }


   self.headers = [[NSMutableArray alloc] init];

   for (int i = 0; i < [self.tableSectionArray count]; i++) {
      LeftMenuItemTree * menuItemTree = self.tableSectionArray[i];

      UIView * header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
      header.backgroundColor = [UIColor clearColor];
      UILabel * number = [[UILabel alloc] initWithFrame:header.frame];
      number.textAlignment = NSTextAlignmentLeft;
      number.textColor = [UIColor blackColor];

      number.text = menuItemTree.title;

      [header addSubview:number];

      [self.headers addObject:header];
   }

}


- (void)setupSlideTableViewWithAutoInfo:(YoutubeAuthInfo *)user {
   if (user == nil)
      user = [[[YoutubeAuthDataStore alloc] init] readAuthUserInfo];

   self.tableView.tableHeaderView = [self getUserHeaderView:user];
}


- (void)setupTableViewExclusiveState {
   [self.tableView setExclusiveSections:NO];
   for (int i = 0; i < [self.tableSectionArray count]; i++) {
      [self.tableView openSection:i animated:NO];
   }
}


- (void)viewDidLoad {
   [super viewDidLoad];



   // 1
   self.tableView = [[STCollapseTableView alloc] initWithFrame:self.view.frame];
   self.tableView.backgroundColor = [UIColor clearColor];
   self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
   self.tableView.dataSource = self;
   self.tableView.delegate = self;

   [self.view addSubview:self.tableView];

   // 2
   [self setupViewController:nil];
   [self setupSlideTableViewWithAutoInfo:nil];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   return [self.tableSectionArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   static NSString * CellIdentifier = @"LeftMenuTableViewCell";

   UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
   if (cell == nil) {
      cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
   }

   [self bind:cell atSection:indexPath.section atRow:indexPath.row];

   return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   LeftMenuItemTree * menuItemTree = self.tableSectionArray[section];
   return menuItemTree.rowsArray.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   return 42;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
   LeftMenuItemTree * menuItemTree = self.tableSectionArray[section];
   if (menuItemTree.hideTitle) {
      return 0;
   }

   return 30;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
   return [self.headers objectAtIndex:section];
}


- (void)refreshChannelSubscriptionList:(GYoutubeAuthUser *)user {
   // 1
   [self setupViewController:[user getTableRows]];
   [self setupSlideTableViewWithAutoInfo:nil];
   [self setupTableViewExclusiveState];

   // 2
   [self.tableView reloadData];
}


- (void)refreshChannelInfo:(YoutubeAuthInfo *)info {
   [self setupSlideTableViewWithAutoInfo:info];
}
@end
