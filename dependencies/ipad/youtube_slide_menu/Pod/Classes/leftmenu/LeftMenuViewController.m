//
//  LeftMenuViewController.m
//  STCollapseTableViewDemo
//
//  Created by Thomas Dupont on 09/08/13.
//  Copyright (c) 2013 iSofTom. All rights reserved.
//

#import <Business-Logic-Layer/YoutubeAuthInfo.h>
#import <google-api-services-youtube/GYoutubeHelper.h>
#import "LeftMenuViewController.h"

#import "STCollapseTableView.h"
#import "GYoutubeAuthUser.h"
#import "LeftMenuItemTree.h"
#import "YoutubeAuthDataStore.h"
#import "LeftMenuTableHeaderView.h"


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
                                remoteImage:NO
                             cellIdentifier:@"CategoriesCellIdentifier"];


   self.tableSectionArray = @[ defaultMenuItemTree ];
   if ([[GYoutubeHelper getInstance] isSignedIn]) {
      LeftMenuItemTree * signUserMenuItemTree =
       [[LeftMenuItemTree alloc] initWithTitle:@"  "
                                     rowsArray:[self signUserCategories]
                                     hideTitle:YES
                                   remoteImage:NO
                                cellIdentifier:@"SignUserCellIdentifier"];
      LeftMenuItemTree * subscriptionsMenuItemTree =
       [[LeftMenuItemTree alloc] initWithTitle:@"  Subscriptions"
                                     rowsArray:subscriptionsArray
                                     hideTitle:NO
                                   remoteImage:YES
                                cellIdentifier:@"SubscriptionsCellIdentifier"];
      self.tableSectionArray = @[ signUserMenuItemTree, subscriptionsMenuItemTree, defaultMenuItemTree ];
//      self.tableSectionArray = @[ subscriptionsMenuItemTree, defaultMenuItemTree ];
   }


   self.headers = [[NSMutableArray alloc] init];

   for (int i = 0; i < [self.tableSectionArray count]; i++) {
      LeftMenuItemTree * menuItemTree = self.tableSectionArray[i];

      LeftMenuTableHeaderView * header = [[[NSBundle mainBundle] loadNibNamed:@"LeftMenuTableHeaderView"
                                                                        owner:nil
                                                                      options:nil] lastObject];
      [header setupUI:menuItemTree.title];
      [self.headers addObject:header];
   }

}


- (void)setupSlideTableViewWithAuthInfo:(YoutubeAuthInfo *)user {
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
   self.tableView = [[STCollapseTableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
   self.tableView.backgroundColor = [UIColor clearColor];
   self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
   self.tableView.dataSource = self;
   self.tableView.delegate = self;

   [self.view addSubview:self.tableView];

   // 2
   [self setupViewController:[[NSArray alloc] init]];
   [self setupSlideTableViewWithAuthInfo:nil];

   [self setupTableViewExclusiveState];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   return [self.tableSectionArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   LeftMenuItemTree * menuItemTree = self.tableSectionArray[indexPath.section];

   NSString * CellIdentifier = menuItemTree.cellIdentifier;

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

   return 33;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
   LeftMenuTableHeaderView * header = [self.headers objectAtIndex:section];

   return header;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   NSInteger section = indexPath.section;
   NSInteger row = indexPath.row;

   LeftMenuItemTree * menuItemTree = self.tableSectionArray[section];
   NSArray * line = menuItemTree.rowsArray[row];
   int typeValue = [(line[2]) intValue];

   [self tableViewEvent:menuItemTree atIndexPath:indexPath];
}


- (void)refreshChannelSubscriptionList:(GYoutubeAuthUser *)user {
   // 1
   [self setupViewController:[user getTableRows]];
   [self setupSlideTableViewWithAuthInfo:nil];

   // 2
   [self.tableView reloadData];

   //3
   [self setupTableViewExclusiveState];
}


- (void)refreshChannelInfo:(YoutubeAuthInfo *)info {
   [self setupSlideTableViewWithAuthInfo:info];
}
@end
