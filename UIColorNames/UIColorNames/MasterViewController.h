//
//  MasterViewController.h
//  UIColorNames
//
//  Created by mtaniuchi on 2013/10/20.
//  Copyright (c) 2013年 Tiesfeed Software JP. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;

@end
