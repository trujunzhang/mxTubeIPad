//
//  YoutubeGridLayoutViewController.h
//  YoutubePlayApp
//
//  Created by djzhang on 10/15/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YoutubeCollectionViewController.h"


@interface YoutubeGridLayoutViewController : YoutubeCollectionViewController
- (void)search:(NSString *)text;
- (void)search:(NSString *)text withQueryType:(NSString *)queryType;
- (void)cleanup;
@end
