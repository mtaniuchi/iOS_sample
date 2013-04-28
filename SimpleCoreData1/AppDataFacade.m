//
//  AppDataFacade.m
//  SimpleCoreData1
//
//  Created by mtaniuchi on 12/08/08.
//  Copyright (c) 2012年 Tiesfeed Software JP. All rights reserved.
//

#import "AppDataFacade.h"
#import "CoreDataUtil.h"

#import "Macros.h"

#import "TextMemo.h"

@implementation AppDataFacade

#define NEW_FOR_INSERT(model) { model *new = (model *)[COREDATA_UTIL entityForInsert:@#model]; return new; }

static AppDataFacade* instance = nil;

+ (AppDataFacade*)sharedInstance {
    @synchronized(self) {
        if (instance == nil) {
            instance = [[self alloc] init];
        }
    }
    return instance;
}

-(void)saveContext
{
    [COREDATA_UTIL saveContext];
}


#pragma mark - Migraiton
- (BOOL)isRequiredMigration
{
    return [COREDATA_UTIL isRequiredMigration];
}
- (void)doMigration {
    [COREDATA_UTIL doMigration];
    [self initFirstData];
}

#pragma mark - TextMemo
- (NSMutableArray*)loadAllMemo
{
    return [COREDATA_UTIL fetch:@"TextMemo" :nil :false :0];
}

- (TextMemo*)newMemoForInsert
{
    NEW_FOR_INSERT(TextMemo);
}

-(void)initFirstData
{
    [COREDATA_UTIL saveContext];
}

- (void)deleteTextMemo:(TextMemo*)textMemo
{
    [COREDATA_UTIL deleteObject:textMemo];
}

@end
