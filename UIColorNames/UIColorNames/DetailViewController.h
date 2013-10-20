//
//  DetailViewController.h
//  UIColorNames
//
//  Created by mtaniuchi on 2013/10/20.
//  Copyright (c) 2013年 Tiesfeed Software JP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (weak, nonatomic) UIColor *backgroundColor;
@property (weak, nonatomic) UIColor *textColor;
@property (weak, nonatomic) NSString *text;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

- (void)setDetailItem:(UIColor*)__backgroundColor :(UIColor*)__textColor :(NSString*)__text;

@end
