//
//  ContextManager.m
//  Template
//
//  Created by Karim on 18/4/17.
//  Copyright © 2017 ExpressTemplate. All rights reserved.
//

#import "ContextManager.h"

static ContextManager *SharedManager = nil;

@implementation ContextManager
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize persistentStoreURL = _persistentStoreURL;
@synthesize persistentStore = _persistentStore;

+ (instancetype)sharedManager{
    if (SharedManager)
        return SharedManager;
    
    SharedManager = [[ContextManager alloc] init];
    return SharedManager;
}

- (instancetype)init{
    if ([super init]) {
        
        /* NSManagedObjectModel */
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Recipes" withExtension:@"momd"];
        _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
        
        NSURL *supportDirectory = [[[NSFileManager defaultManager] URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask] lastObject];
        
        NSURL *libraryURL = [supportDirectory URLByAppendingPathComponent:@"Recipes.sqlite" isDirectory:false];
        
        if (![supportDirectory checkResourceIsReachableAndReturnError:nil]) {
            [[NSFileManager defaultManager] createDirectoryAtURL:supportDirectory withIntermediateDirectories:true attributes:nil error:nil];
        }
        
        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_managedObjectModel];
        
        NSError *error = nil;
        
        NSDictionary *options = @{
                                  NSMigratePersistentStoresAutomaticallyOption : @YES,
                                  NSInferMappingModelAutomaticallyOption : @YES
                                  };

        _persistentStoreURL = libraryURL;
        _persistentStore = [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:libraryURL options:options error:&error];
    }
    return self;
}

#pragma mark - Core Data stack

- (NSManagedObjectContext *)managedObjectContext {
    if (_managedObjectContext) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

- (NSPersistentStore *)persistentStore {
    return [[self persistentStoreCoordinator] persistentStoreForURL:_persistentStoreURL];
}

#pragma mark - Core Data support

- (void)saveContext {
    NSError *error = nil;
    if ([self.managedObjectContext hasChanges] && ![self.managedObjectContext save:&error]) {
        
    }
}

- (BOOL)saveContext:(NSError **)error{
    return [[self managedObjectContext] save:error];
}

- (nullable NSArray *)executeFetchRequest:(NSFetchRequest *)request error:(NSError **)error {
    return [[self managedObjectContext] executeFetchRequest:request error:error];
}

+ (__kindof NSManagedObject *)insertNewObjectForEntityForName:(NSString *)entityName {
    if (![[ContextManager sharedManager] managedObjectContext]) {
        return nil;
    }
    return [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:[[ContextManager sharedManager] managedObjectContext]];
}

@end
