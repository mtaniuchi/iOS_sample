//
//  DetailViewController.h
//  SimpleCoreData1
//
//  Created by mtaniuchi on 13/04/29.
//  Copyright (c) 2013年 Tiesfeed Software JP. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DetailViewControllerDelegate<NSObject>
- (void)editDetailViewFinished;
@end

@class TextMemo;

@interface DetailViewController : UIViewController<UITextFieldDelegate>

@property (assign) id<DetailViewControllerDelegate>delegate;

@property (retain, nonatomic) TextMemo *detailItem;

@property (strong, nonatomic) IBOutlet UITextField *textField;

@end
