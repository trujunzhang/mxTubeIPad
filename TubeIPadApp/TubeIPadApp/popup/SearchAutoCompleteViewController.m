//
//  SearchAutoCompleteViewController.m
//  TubeIPadApp
//
//  Created by djzhang on 11/21/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import "SearchAutoCompleteViewController.h"


@interface SearchAutoCompleteViewController ()<UITableViewDataSource>
@property(strong, nonatomic) NSMutableArray * ParsingArray;
@end


@implementation SearchAutoCompleteViewController

- (instancetype)initWithSelectedDelegate:(id<UITableViewDelegate>)selectedDelegate {
   self = [super init];
   if (self) {
      self.selectedDelegate = selectedDelegate;
   }

   return self;
}


- (void)viewDidLoad {
   [super viewDidLoad];

   // Do any additional setup after loading the view.
   self.tableView.dataSource = self;

   NSAssert(self.selectedDelegate, @"not found UITableViewDelegate instance!");
}


- (void)resetTableSource:(NSMutableArray *)array {
   self.ParsingArray = array;
   [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning {
   [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
}


#pragma mark - 
#pragma mark UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return self.ParsingArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   return nil;
}


#pragma mark -
#pragma mark UITableViewDelegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

@end
