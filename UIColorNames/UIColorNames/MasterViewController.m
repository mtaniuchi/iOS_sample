//
//  MasterViewController.m
//  UIColorNames
//
//  Created by mtaniuchi on 2013/10/20.
//  Copyright (c) 2013年 Tiesfeed Software JP. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"

@interface MasterViewController () {
    NSArray *_backgroundColors;
    NSArray *_textColors;
    NSArray *_descriptions;
}
@end

@implementation MasterViewController

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    /*
     //
     // UIColor Names
     //
     
     // Some convenience methods to create colors.  These colors will be as calibrated as possible.
     // These colors are cached.
     + (UIColor *)blackColor;      // 0.0 white
     + (UIColor *)darkGrayColor;   // 0.333 white
     + (UIColor *)lightGrayColor;  // 0.667 white
     + (UIColor *)whiteColor;      // 1.0 white
     + (UIColor *)grayColor;       // 0.5 white
     + (UIColor *)redColor;        // 1.0, 0.0, 0.0 RGB
     + (UIColor *)greenColor;      // 0.0, 1.0, 0.0 RGB
     + (UIColor *)blueColor;       // 0.0, 0.0, 1.0 RGB
     + (UIColor *)cyanColor;       // 0.0, 1.0, 1.0 RGB
     + (UIColor *)yellowColor;     // 1.0, 1.0, 0.0 RGB
     + (UIColor *)magentaColor;    // 1.0, 0.0, 1.0 RGB
     + (UIColor *)orangeColor;     // 1.0, 0.5, 0.0 RGB
     + (UIColor *)purpleColor;     // 0.5, 0.0, 0.5 RGB
     + (UIColor *)brownColor;      // 0.6, 0.4, 0.2 RGB
     + (UIColor *)clearColor;      // 0.0 white, 0.0 alpha
     */
    _backgroundColors = [[NSArray alloc] initWithObjects:
                         [UIColor blackColor],
                         [UIColor darkGrayColor],
                         [UIColor lightGrayColor],
                         [UIColor redColor],
                         [UIColor greenColor],
                         [UIColor blueColor],
                         [UIColor cyanColor],
                         [UIColor yellowColor],
                         [UIColor magentaColor],
                         [UIColor orangeColor],
                         [UIColor purpleColor],
                         [UIColor brownColor],
                         [UIColor clearColor],
                         nil];
    _textColors = [[NSArray alloc] initWithObjects:
                   [UIColor whiteColor],
                   [UIColor whiteColor],
                   [UIColor whiteColor],
                   [UIColor whiteColor],
                   [UIColor blackColor],
                   [UIColor whiteColor],
                   [UIColor blackColor],
                   [UIColor blackColor],
                   [UIColor blackColor],
                   [UIColor blackColor],
                   [UIColor whiteColor],
                   [UIColor whiteColor],
                   [UIColor whiteColor],
                   nil];
    _descriptions = [[NSArray alloc] initWithObjects:
                     @"blackColor",
                     @"darkGrayColor",
                     @"lightGrayColor",
                     @"redColor",
                     @"greenColor",
                     @"blueColor",
                     @"cyanColor",
                     @"yellowColor",
                     @"magentaColor",
                     @"orangeColor",
                     @"purpleColor",
                     @"brownColor",
                     @"clearColor",
                     nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _backgroundColors.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    // set color information...
    [cell setBackgroundColor:[_backgroundColors objectAtIndex:indexPath.row]];
    [cell.textLabel setText:[_descriptions objectAtIndex:indexPath.row]];
    [cell.textLabel setTextColor:[_textColors objectAtIndex:indexPath.row]];
    [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        [self.detailViewController
         setDetailItem:[_backgroundColors objectAtIndex:indexPath.row]
         :[_textColors objectAtIndex:indexPath.row]
         :[_descriptions objectAtIndex:indexPath.row]];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [[self tableView] indexPathForSelectedRow];
        [[segue destinationViewController]
         setDetailItem:[_backgroundColors objectAtIndex:indexPath.row]
         :[_textColors objectAtIndex:indexPath.row]
         :[_descriptions objectAtIndex:indexPath.row]];
    }
}

@end
