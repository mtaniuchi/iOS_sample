//
//  CoreDataUtil.h
//  SimpleCoreData1
//
//  Created by mtaniuchi on 12/07/14.
//  Copyright (c) 2012年 Tiesfeed Software JP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#define COREDATA_UTIL (CoreDataUtil*)[CoreDataUtil sharedInstance]

@interface CoreDataUtil : NSObject {
    NSManagedObjectContext *_managedObjectContext;
    NSManagedObjectModel *_managedObjectModel;
    NSPersistentStoreCoordinator *_persistentStoreCoordinator;
}

// property
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (assign) bool unlocked;
@property (nonatomic, strong) NSMutableArray *notificationArray;

// instance
+ (CoreDataUtil*)sharedInstance;

// documentsDir
- (NSURL *)applicationDocumentsDirectory;

// Migration
- (BOOL)isRequiredMigration;
- (void)doMigration;

// fetch
- (NSMutableArray*)fetch:(NSString*)entityName :(NSString*)sortWithKey :(bool)ascending :(int)limit;

// save
- (void)saveContext;
- (NSManagedObject*)entityForInsert:(NSString*)entityname;
- (void)deleteObject:(NSManagedObject*)obj;

// dealloc
- (void)dealloc;

@end