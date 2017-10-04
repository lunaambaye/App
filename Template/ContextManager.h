//
//  ContextManager.h
//  Template
//
//  Created by Karim on 18/4/17.
//  Copyright © 2017 ExpressTemplate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface ContextManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSPersistentStore *persistentStore;

@property (readonly, strong, nonatomic) NSURL *persistentStoreURL;

+ (instancetype)sharedManager;

- (void)saveContext;
- (BOOL)saveContext:(NSError **)error;

- (nullable NSArray *)executeFetchRequest:(NSFetchRequest *)request error:(NSError **)error;

+ (__kindof NSManagedObject *)insertNewObjectForEntityForName:(NSString *)entityName;

@end

NS_ASSUME_NONNULL_END
