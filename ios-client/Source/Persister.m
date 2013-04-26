//
//  Persiter.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 4/26/13.
//  Copyright (c) 2013 Lucas Neiva. All rights reserved.
//

#import "Persister.h"
#import "Files.h"

NSString const*FavoriteSeriesAddedNotification= @"FavoriteSeriesAddedNotification";

@interface Persister ()

@property (readonly, nonatomic) NSManagedObjectContext *context;
@property (readonly, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end

@implementation Persister {
    NSManagedObjectContext *_context;
    NSManagedObjectModel *_managedObjectModel;
    NSPersistentStoreCoordinator *_persistentStoreCoordinator;
}

- (id)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (FavoriteSeries *)insertFavoriteSeries:(NSString *)seriesId {
    FavoriteSeries *favorite = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([FavoriteSeries class]) inManagedObjectContext:self.context];
    favorite.seriesId = seriesId;
    return favorite;
}

- (NSArray *)loadFavoriteSeries {
    return [self loadFavoriteSeriesWithPredicate:nil];
}

- (FavoriteSeries *)loadFavoriteSeriesWithId:(NSString *)seriesId {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"seriesId like %@", seriesId];
    NSArray *favorites = [self loadFavoriteSeriesWithPredicate:predicate];
    return favorites.count > 0 ? favorites[0] : nil;
}

- (NSArray *)loadFavoriteSeriesWithPredicate:(NSPredicate *)predicate {
    NSEntityDescription *entity = [self entityDescriptionForManagedObjectClass:[FavoriteSeries class]];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = entity;
    request.predicate = predicate;
    NSArray *favorites = [self.context executeFetchRequest:request error:NULL];
    
    return favorites;
}

- (NSEntityDescription *)entityDescriptionForManagedObjectClass:(Class)managedObjectClass {
    return [NSEntityDescription entityForName:NSStringFromClass(managedObjectClass) inManagedObjectContext:self.context];
    
}

- (void)save {
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.context;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Notifications

- (void)contextDidChange:(NSDictionary *)userInfo {
    NSLog(@"Context Did Change");
    [self.context save:NULL];
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)context {
    if (_context != nil) {
        return _context;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _context = [[NSManagedObjectContext alloc] init];
        [_context setPersistentStoreCoordinator:coordinator];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contextDidChange:) name:NSManagedObjectContextObjectsDidChangeNotification object:self.context];
    return _context;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"UserData" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [Files URLForDocumentNamed:@"UserData.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

@end
