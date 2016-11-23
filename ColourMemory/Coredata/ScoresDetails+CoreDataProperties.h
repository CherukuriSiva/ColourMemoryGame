//
//  ScoresDetails+CoreDataProperties.h
//  ColourMemory
//
//  Created by Ducere Technologies on 10/21/15.
//  Copyright © 2015 SivaCherukuri. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ScoresDetails.h"

NS_ASSUME_NONNULL_BEGIN

@interface ScoresDetails (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *score;

@end

NS_ASSUME_NONNULL_END
