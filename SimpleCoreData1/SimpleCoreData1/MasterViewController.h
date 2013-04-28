//
//  MasterViewController.h
//  SimpleCoreData1
//
//  Created by mtaniuchi on 13/04/29.
//  Copyright (c) 2013年 Tiesfeed Software JP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"

@class DetailViewController;

@interface MasterViewController : UITableViewController<DetailViewControllerDelegate>

@property (strong, nonatomic) DetailViewController *detailViewController;

@end
