//
//  AppDataFacade.h
//  SimpleCoreData1
//
//  Created by mtaniuchi on 12/08/08.
//  Copyright (c) 2012年 Tiesfeed Software JP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreDataUtil.h"

@class TextMemo;

#define FACADE (AppDataFacade*)[AppDataFacade sharedInstance]

@interface AppDataFacade : NSObject

// instance
+ (AppDataFacade*)sharedInstance;

-(void)saveContext;

#pragma mark - Migraiton
- (BOOL)isRequiredMigration;
- (void)doMigration;

#pragma mark - TextMemo
- (NSMutableArray*)loadAllMemo;
- (TextMemo*)newMemoForInsert;
- (void)deleteTextMemo:(TextMemo*)textMemo;

@end