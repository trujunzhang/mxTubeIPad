//
//  LeftMenuViewController.m
//  STCollapseTableViewDemo
//
//  Created by Thomas Dupont on 09/08/13.
//  Copyright (c) 2013 iSofTom. All rights reserved.
//

#import "LeftMenuViewController.h"

#import "STCollapseTableView.h"
#import "UserInfoView.h"


@interface LeftMenuViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) STCollapseTableView * tableView;

@property(nonatomic, strong) NSMutableArray * data;
@property(nonatomic, strong) NSMutableArray * headers;

@end


@implementation LeftMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
   self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
   if (self) {
      [self setupViewController];
   }
   return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder {
   self = [super initWithCoder:aDecoder];
   if (self) {
      [self setupViewController];
   }
   return self;
}


- (void)setupViewController {
   NSArray * colors = @[ [UIColor redColor],
   ];

   self.data = [[NSMutableArray alloc] init];
   for (int i = 0; i < [colors count]; i++) {
      NSMutableArray * section = [[NSMutableArray alloc] init];
      for (int j = 0; j < 3; j++) {
         [section addObject:[NSString stringWithFormat:@"Cell n°%i %i", i + 1, j]];
      }
      [self.data addObject:section];
   }

   self.headers = [[NSMutableArray alloc] init];
   for (int i = 0; i < [colors count]; i++) {
      UIView * header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
//      header.backgroundColor=[UIColor clearColor];
      [header setBackgroundColor:[colors objectAtIndex:i]];
      UILabel * number = [[UILabel alloc] initWithFrame:header.frame];
      number.textAlignment = NSTextAlignmentCenter;
      number.textColor = [UIColor blackColor];
      number.text = [NSString stringWithFormat:@"%i", i + 1];
      [header addSubview:number];

      [self.headers addObject:header];
   }
}


- (void)viewDidLoad {
   [super viewDidLoad];

   [self setupBackground];

   self.tableView = [[STCollapseTableView alloc] initWithFrame:self.view.frame];
   self.tableView.backgroundColor = [UIColor clearColor];
   self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
   self.tableView.dataSource = self;
   self.tableView.delegate = self;

   [self.view addSubview:self.tableView];

   NSArray * views = [[NSBundle mainBundle] loadNibNamed:@"UserInfoView" owner:nil options:nil]; //&1
   UserInfoView * userInfoView = [views lastObject];
   userInfoView.frame = CGRectMake(0, 0, 256, 100);

   self.tableView.tableHeaderView = userInfoView;

   [self.tableView reloadData];

   [self.tableView setExclusiveSections:NO];

   [self.tableView openSection:0 animated:NO];
   [self.tableView openSection:1 animated:NO];
}


- (void)setupBackground {
   UIImageView * imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
   imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
   imageView.contentMode = UIViewContentModeScaleAspectFit;
   imageView.image = [UIImage imageNamed:@"mt_side_menu_bg"];

   [self.view addSubview:imageView];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   return [self.data count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   static NSString * CellIdentifier = @"NewsTableViewCell";

   UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
   if (cell == nil) {
      cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
   }
   cell.backgroundColor = [UIColor clearColor];

   NSArray * line = [self defaultCategories][indexPath.row];

   UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:line[1]]];
   [imageView setContentMode:UIViewContentModeScaleAspectFit];
   imageView.frame = CGRectMake(0, 0, 50, 50);

   [cell.contentView addSubview:imageView];


   UILabel * label = [[UILabel alloc] init];
   CGRect rect = cell.frame;
   rect.origin.x = 60;
   rect.size.width = rect.size.width - 60;
   label.frame = rect;
   label.text = line[0];

   [cell.contentView addSubview:label];

   return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return [[self defaultCategories] count];
//   return [[self.data objectAtIndex:section] count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//   if (section == 0) {
//      return 0;
//   }
   return 50;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
   return [self.headers objectAtIndex:section];
}


- (NSArray *)defaultCategories {
   NSArray * array = @[
    @[ @"Autos & Vehicles", @"Autos" ],
    @[ @"Comedy", @"Comedy" ],
    @[ @"Education", @"Education" ],
    @[ @"Entertainment", @"Entertainment" ],
    @[ @"File & Animation", @"Film" ],
    @[ @"Gaming", @"Games" ],
    @[ @"Howto & Style", @"Howto" ],
    @[ @"Music", @"Music" ],
    @[ @"News & Politics", @"News" ],
    @[ @"Nonprofits & Activism", @"Nonprofit" ],
    @[ @"People & Blogs", @"People" ],
    @[ @"Pets & Animals", @"Animals" ],
    @[ @"Science & Technology", @"Tech" ],
    @[ @"Sports", @"Sports" ],
    @[ @"Travel & Events", @"Travel" ],
   ];


   return array;
}


@end
