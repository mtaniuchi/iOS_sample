//
//  DetailViewController.m
//  SimpleCoreData1
//
//  Created by mtaniuchi on 13/04/29.
//  Copyright (c) 2013年 Tiesfeed Software JP. All rights reserved.
//

#import "DetailViewController.h"
#import "TextMemo.h"
#import "AppDataFacade.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.textField.text = self.detailItem.memo;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Save"
                                                             style:UIBarButtonItemStyleDone
                                                            target:self action:@selector(saveButtonAction)];
    self.navigationItem.rightBarButtonItem = item;
    
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Detail", @"Detail");
    }
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.textField resignFirstResponder];
    [self saveButtonAction];
    return YES;
}

- (void)saveButtonAction
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(editDetailViewFinished)]) {
        self.detailItem.memo = self.textField.text;
        [FACADE saveContext];
        [self.delegate editDetailViewFinished];
    }
}

@end
