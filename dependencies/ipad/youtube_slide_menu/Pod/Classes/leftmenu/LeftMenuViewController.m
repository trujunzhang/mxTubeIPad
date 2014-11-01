//
//  LeftMenuViewController.m
//  STCollapseTableViewDemo
//
//  Created by Thomas Dupont on 09/08/13.
//  Copyright (c) 2013 iSofTom. All rights reserved.
//

#import "LeftMenuViewController.h"

#import "STCollapseTableView.h"
#import "GYoutubeAuthUser.h"
#import "LeftMenuItemTree.h"


@interface LeftMenuViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) STCollapseTableView * tableView;

@property(nonatomic, strong) NSMutableArray * headers;

@end


@implementation LeftMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
   self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
   if (self) {
      [self setupViewController:nil];
   }
   return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder {
   self = [super initWithCoder:aDecoder];
   if (self) {
      [self setupViewController:nil];
   }
   return self;
}


- (void)setupViewController:(NSArray *)subscriptionsArray {
   LeftMenuItemTree * defaultMenuItemTree =
    [[LeftMenuItemTree alloc] initWithTitle:@"  Categories"
                                  rowsArray:[self defaultCategories]
                                  hideTitle:NO];


   self.tableSectionArray = @[ defaultMenuItemTree ];
   if (subscriptionsArray) {
      LeftMenuItemTree * subscriptionsMenuItemTree =
       [[LeftMenuItemTree alloc] initWithTitle:@"  Subscriptions"
                                     rowsArray:subscriptionsArray
                                     hideTitle:YES];
      self.tableSectionArray = @[ subscriptionsMenuItemTree, defaultMenuItemTree ];
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


- (void)viewDidLoad {
   [super viewDidLoad];

   // 1
   self.tableView = [[STCollapseTableView alloc] initWithFrame:self.view.frame];
   self.tableView.backgroundColor = [UIColor clearColor];
   self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
   self.tableView.dataSource = self;
   self.tableView.delegate = self;

   [self.view addSubview:self.tableView];

   //2
   self.tableView.tableHeaderView = [self getUserInfoPanel];

   // 3
   [self.tableView setExclusiveSections:NO];

   [self.tableView openSection:0 animated:NO];
   [self.tableView openSection:1 animated:NO];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   return [self.tableSectionArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   static NSString * CellIdentifier = @"NewsTableViewCell";

   UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
   if (cell == nil) {
      cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
   }
   // 1
   cell.backgroundColor = [UIColor clearColor];

   // 2
   LeftMenuItemTree * menuItemTree = self.tableSectionArray[indexPath.section];
   NSArray * line = menuItemTree.rowsArray[indexPath.row];

   // 3
   cell.textLabel.text = line[0];
   cell.imageView.image = [UIImage imageNamed:line[1]];
   cell.imageView.contentMode = UIViewContentModeScaleAspectFit;

   // 4
   cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"mt_side_menu_selected_bg"]
    stretchableImageWithLeftCapWidth:0.0
                        topCapHeight:5.0]];

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
   if (menuItemTree.hideTitle)
      return 0;

   return 30;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
   return [self.headers objectAtIndex:section];
}


- (void)refreshAutoUser:(GYoutubeAuthUser *)user {
   NSArray * array = [user getTableRows];

   [self setupViewController:array];

   //4
   [self.tableView reloadData];
}

@end
