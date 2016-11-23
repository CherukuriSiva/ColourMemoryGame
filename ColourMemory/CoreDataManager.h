//
//  LCCoreDataManager.h
//  LeChal
//
//  Created by Ducere Technologies on 3/5/15.
//  Copyright (c) 2015 DucereTechnologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Common.h"
#import "ScoresDetails.h"

@interface CoreDataManager : NSObject
{
@private
    NSManagedObjectContext *managedObjectContext_;
    NSManagedObjectModel *managedObjectModel_;
    NSPersistentStoreCoordinator *persistentStoreCoordinator_;
    NSInteger selYear,selMonth,selDay,selHour,selMinutes;
}

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (CoreDataManager *)sharedManager;
- (void)dbSaveInContext:(NSManagedObjectContext *)context;
- (void) dbSave;
- (NSArray *)fetchObjectList:(NSString *)entity predicate:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context;
- (void)addScoresDetails:(NSString*)player withScore:(NSString*)score;
- (NSArray*)getScoresDetails;
@end
