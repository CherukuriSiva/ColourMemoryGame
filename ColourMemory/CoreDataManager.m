//
//  LCCoreDataManager.m
//  LeChal
//
//  Created by Ducere Technologies on 3/5/15.
//  Copyright (c) 2015 DucereTechnologies. All rights reserved.
//

#import "CoreDataManager.h"

static CoreDataManager *sharedDataManager = nil;

@implementation CoreDataManager

@synthesize managedObjectModel;
@synthesize managedObjectContext;

+ (CoreDataManager *)sharedManager
{
    @synchronized(self)
    {
        if (sharedDataManager == nil)
        {
            sharedDataManager = [[self alloc] init];
        }
    }
    return sharedDataManager;
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self)
    {
        if (nil == sharedDataManager)
        {
            sharedDataManager = [super allocWithZone:zone];
            return sharedDataManager;
        }
    }
    return nil;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

- (NSManagedObjectModel *)managedObjectModel
{
    if (managedObjectModel != nil)
    {
        return managedObjectModel;
    }
    
    NSString *modelPath = [[NSBundle mainBundle] pathForResource:@"ColourMemory" ofType:@"momd"];
    NSURL *modelURL = [NSURL fileURLWithPath:modelPath];
    managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    return managedObjectModel;
}
- (NSManagedObjectContext *)managedObjectContext
{
    
    if (managedObjectContext_ != nil)
    {
        return managedObjectContext_;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        //managedObjectContext_ = [[NSManagedObjectContext alloc] init];
        managedObjectContext_ = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        
        NSUndoManager *undoManager = [[NSUndoManager alloc] init];
        [managedObjectContext_ setUndoManager:undoManager];
        
        [managedObjectContext_ setPersistentStoreCoordinator:coordinator];
    }
    return managedObjectContext_;
}


- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (persistentStoreCoordinator_ != nil)
    {
        return persistentStoreCoordinator_;
    }
    
    NSString *storePath = [[Common getAppDocumentsDirectory] stringByAppendingPathComponent: @"ColourMemory.sqlite"];
    NSURL *storeURL = [NSURL fileURLWithPath:storePath];
    
    NSError *error = nil;
    persistentStoreCoordinator_ = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    
    NSDictionary *automaticMigrationOptions = [NSDictionary dictionaryWithObjectsAndKeys:
                                               [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                                               [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
    
    
    if (![persistentStoreCoordinator_ addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:automaticMigrationOptions error:&error])
    {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    NSDictionary *fileAttributes = [NSDictionary dictionaryWithObject:NSFileProtectionComplete forKey:NSFileProtectionKey];
    if (![[NSFileManager defaultManager] setAttributes:fileAttributes ofItemAtPath:[storeURL path] error:&error])
    {
        NSLog(@"NSFileProtectionComplete error %@, %@", error, [error userInfo]);
    }
    
    return persistentStoreCoordinator_;
}

#pragma mark - fetch method
- (NSArray *)fetchObjectList:(NSString *)entity predicate:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context
{
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:entity inManagedObjectContext:context];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entityDescription];
    [fetchRequest setIncludesSubentities:NO];
    
    if (nil != predicate)
    {
        [fetchRequest setPredicate:predicate];
    }
    
    __block NSArray *result = nil;
    
    [context performBlockAndWait:^{
        
        NSError *error = nil;
        result = [context executeFetchRequest:fetchRequest error:&error];
        if (nil != error)
        {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        }
    }];
    
    return result;
}

- (NSArray *)fetchObjectList:(NSString *)entity inContext:(NSManagedObjectContext *)context{
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:entity inManagedObjectContext:context];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entityDescription];
    
    __block NSArray *result = nil;
    
    [context performBlockAndWait:^{
        
        NSError *error = nil;
        result = [context executeFetchRequest:fetchRequest error:&error];
        if (nil != error)
        {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        }
    }];
    
    
    return (0 == result.count) ? nil : result;
}


- (NSInteger) getNextUniqueIDForEntity:(NSString*)entityName
                             attribute:(NSString*)IDAttribure
                                 error:(NSError**)error
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSString *theKeyField = [NSString stringWithFormat: @"@max.%@", IDAttribure];
    NSArray  *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:error];
    NSNumber *maxID = [fetchedObjects valueForKeyPath:theKeyField];
    
    return [maxID integerValue] + 1;
}

- (void)addScoresDetails:(NSString*)player withScore:(NSString*)score{
    ScoresDetails *scoresValues = [NSEntityDescription insertNewObjectForEntityForName:@"ScoresDetails" inManagedObjectContext:self.managedObjectContext];
    
    scoresValues.name = player;
    scoresValues.score = score;
    [self dbSave];
}

//Fetch all user profile details
-(NSArray*)getScoresDetails{
    NSArray *ScoresDetailsDataArray = [self fetchObjectList:@"ScoresDetails" inContext:self.managedObjectContext];
    return ScoresDetailsDataArray;
    
}

#pragma mark - Public

- (void)dbSaveInContext:(NSManagedObjectContext *)context
{
    [context performBlockAndWait:^{
        NSError *error = nil;
        [context save:&error];
        
        // Save the changes on the main context
        [context.parentContext performBlock:^{
            NSError *parentError = nil;
            [context.parentContext save:&parentError];
        }];
    }];
}
- (void) dbSave
{
    [self dbSaveInContext:self.managedObjectContext];
}
@end
