//
//  YTLeftRowTableViewCell.m
//  Popping
//
//  Created by djzhang on 11/30/14.
//  Copyright (c) 2014 André Schneider. All rights reserved.
//

#import "YTLeftRowTableViewCell.h"
#import "AsyncDisplayKit.h"
#import "ASControlNode+Subclasses.h"
#import "ASDisplayNode+Subclasses.h"


@implementation YTLeftRowTableViewCell

- (void)awakeFromNib {
   // Initialization code
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
   [super setSelected:selected animated:animated];

   // Configure the view for the selected state
}


- (void)bind:(UIColor *)color indexPath:(NSInteger)path {
   // Create a new private queue
   dispatch_queue_t _backgroundQueue;
   _backgroundQueue = dispatch_queue_create("com.company.subsystem.task", NULL);

   dispatch_async(_backgroundQueue, ^{
//       FiveStepsViewController * controller = [[FiveStepsViewController alloc] initWithRowCount:path];
//       controller.view.bounds = self.bounds;
//


       // self.view isn't a node, so we can only use it on the main thread
       dispatch_sync(dispatch_get_main_queue(), ^{
//           [self addSubview:controller.view];
       });
   });

}


- (void)bind123:(UIColor *)color {
   // Create a new private queue
   dispatch_queue_t _backgroundQueue;
   _backgroundQueue = dispatch_queue_create("com.company.subsystem.task", NULL);

   dispatch_async(_backgroundQueue, ^{
       ASImageNode * node = [[ASImageNode alloc] init];

       CGRect rect = self.bounds;
//       node.frame = rect;
//       node.frame = CGRectMake(rect.origin.x + 20, rect.origin.y + 10, rect.size.width - 30, rect.size.height - 30);
//       UIColor * color = [UIColor redColor];
       node.backgroundColor = color;


       // self.view isn't a node, so we can only use it on the main thread
       dispatch_sync(dispatch_get_main_queue(), ^{
           [self addSubview:node.view];
       });
   });

}
@end
