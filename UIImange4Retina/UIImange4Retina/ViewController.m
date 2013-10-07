//
//  ViewController.m
//  UIImange4Retina
//
//  Created by mtaniuchi on 2013/10/07.
//  Copyright (c) 2013年 Tiesfeed Software JP. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
	[[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    
    [self.view setBackgroundColor:[[UIColor alloc]
                                   initWithPatternImage:[UIImage imageNamed:@"bgPortrait"]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate
{
	return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    }
	return UIInterfaceOrientationMaskAll;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation) fromInterfaceOrientation
{
    // Set Background Image
    if (UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation))
    {
        // code for Portrait orientation
        [self.view setBackgroundColor:[UIColor
                                       colorWithPatternImage:[UIImage
                                                              imageNamed:@"bgPortrait.png"]]];
    }
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation))
    {
        // code for landscape orientation
        [self.view setBackgroundColor:[UIColor
                                       colorWithPatternImage:[UIImage
                                                              imageNamed:@"bgLandscape.png"]]];
    }
}

@end
