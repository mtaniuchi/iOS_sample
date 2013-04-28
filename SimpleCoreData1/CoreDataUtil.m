//
//  CoreDataUtil.m
//  SimpleCoreData1
//
//  Created by mtaniuchi on 12/07/14.
//  Copyright (c) 2012年 Tiesfeed Software JP. All rights reserved.
//

#import "CoreDataUtil.h"
#import "Macros.h"

#define FILENAME [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
#define STORE_FILENAME [NSString stringWithFormat:@"%@.db", FILENAME]
#define STORE_URL [[self applicationDocumentsDirectory] URLByAppendingPathComponent:STORE_FILENAME]

@implementation CoreDataUtil
@synthesize unlocked = _unlocked;
@synthesize notificationArray = _notificationArray;

static CoreDataUtil* instance = nil;  

+ (CoreDataUtil*)sharedInstance {  
    @synchronized(self) {  
        if (instance == nil) {  
            instance = [[self alloc] init];  
        }  
    }  
    return instance;
}  

+ (id)allocWithZone:(NSZone *)zone {  
    @synchronized(self) {  
        if (instance == nil) {  
            instance = [super allocWithZone:zone];  
            return instance;  
        }  
    }  
    return nil;  
}

- (id)copyWithZone:(NSZone*)zone {  
    return self;
}

#pragma mark -
- (BOOL)isRequiredMigration
{
    NSError* error = nil;
    
    NSDictionary* sourceMetaData =
    [NSPersistentStoreCoordinator metadataForPersistentStoreOfType:NSSQLiteStoreType
                                                               URL:STORE_URL
                                                             error:&error];
    if (sourceMetaData == nil) {
        return NO;
    } else if (error) {
        LOG(@"Checking migration was failed (%@, %@)", error, [error userInfo]);
        abort();
    }
    
    BOOL isCompatible = [[self managedObjectModel] isConfiguration:nil
                                        compatibleWithStoreMetadata:sourceMetaData]; 
    return !isCompatible;
}

- (void)doMigration {
    NSError* error = nil;
    
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                             [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    
    [coordinator addPersistentStoreWithType:NSSQLiteStoreType
                              configuration:nil
                                        URL:STORE_URL
                                    options:options
                                      error:&error];
}

#pragma mark - save & insert & delete
- (void)saveContext
{
    NSError *error = nil;
	NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    
    if (managedObjectContext != nil) {
        LOG(@"hasChanges %d", [managedObjectContext hasChanges]);
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            LOG(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}
- (NSManagedObject*)entityForInsert:(NSString*)entityname {
	NSManagedObjectContext *context = self.managedObjectContext;
	return [NSEntityDescription insertNewObjectForEntityForName:entityname inManagedObjectContext:context];
}
- (void)deleteObject:(NSManagedObject*)obj {
    if (obj == nil) {
        return;
    }
    
    NSError *error = nil;
	NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        [managedObjectContext deleteObject:obj];
        LOG(@"deleteObject %d", [managedObjectContext hasChanges]);
        if (/*[managedObjectContext hasChanges] &&*/ ![managedObjectContext save:&error]) {
            LOG(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Core Data stack
- (NSManagedObjectContext *)managedObjectContext
{   
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
	_managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:
					   [NSString stringWithFormat:@"%@.db",FILENAME]];
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]
                                   initWithManagedObjectModel:self.managedObjectModel];
    
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                             [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
    
    NSError *error = nil;
    
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                   configuration:nil
                                                             URL:storeURL
                                                         options:options
                                                           error:&error]) {
        NSLog(@"Creating persistentStoreCoordinator was failed (%@, %@)", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark -
#pragma mark Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager]
             URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark -
#pragma mark entity access method
- (NSMutableArray*)fetch:(NSString*)entityName :(NSString*)sortWithKey :(bool)ascending :(int)limit {
	NSManagedObjectContext *context = self.managedObjectContext;
    
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:context];
	[request setEntity:entity];
    
    if (sortWithKey) {
        NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:sortWithKey ascending:ascending];
        [request setSortDescriptors:[NSArray arrayWithObject:sort]];
        [request setFetchLimit:limit];
    }
    
	NSError *error = nil;
	NSMutableArray *mutableFetchResults = [[context executeFetchRequest:request error:&error] mutableCopy];
	if (mutableFetchResults == nil) {
		// Handle the error.
		LOG(@"fetch error.")
	}
	return mutableFetchResults;
}

- (void)dealloc
{
    instance = nil;
    _managedObjectContext = nil;
    _managedObjectModel = nil;
    _persistentStoreCoordinator = nil;
}

@end