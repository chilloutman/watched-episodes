//
//  FavoritesMananger.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/26/11.
//  Copyright 2011 Lucas Neiva. All rights reserved.
//

#import "FavoritesManager.h"
#import "Files.h"
#import "ServiceLocator.h"


@interface FavoritesManager ()

@property (nonatomic, retain) NSMutableDictionary *favoriteSeries;

- (void)loadFavoritesFromFilessystem;
- (void)persistSeries:(PBSeries *)series;
- (NSString *)seriesDirectory;
- (NSString *)filenameForSeries:(PBSeries *)series;

@end


@implementation FavoritesManager

@synthesize favoriteSeries;

+ (FavoritesManager *)shared {
    return [ServiceLocator singletonForClass:[FavoritesManager class]];
}

- (id)init {
    self = [super init];
	if (self != nil) {
		self.favoriteSeries= [NSMutableDictionary dictionary];
		[self loadFavoritesFromFilessystem];
	}
	return self;
}

- (void)loadFavoritesFromFilessystem {
	NSFileManager *fileManager= [NSFileManager defaultManager];
	NSString *seriesDirectory= [self seriesDirectory];
	NSDirectoryEnumerator *dirEnum= [fileManager enumeratorAtPath:seriesDirectory];
	
	NSString *file;
	while ((file = [dirEnum nextObject]) != nil) {
		if ([[file pathExtension] isEqualToString:@"series"]) {
			PBSeries *series = [PBSeries parseFromData:[fileManager contentsAtPath:[seriesDirectory stringByAppendingPathComponent:file]]];
			[self.favoriteSeries setObject:series forKey:series.seriesId];
		}
	}
}

- (NSArray *)allFavoriteSeries {
	return [self.favoriteSeries allValues];
}

- (PBSeries *)seriesForSeriesId:(NSString *)seriesId {
	return [self.favoriteSeries objectForKey:seriesId];
}

- (void)addSeriesToFavorites:(PBSeries *)series {
	if (![self isInFavorites:series.seriesId]) {
		[self.favoriteSeries setObject:series forKey:series.seriesId];
		[self persistSeries:series];
	}
}

- (BOOL)isInFavorites:(NSString *)seriesId {
	return ([self seriesForSeriesId:seriesId]) ? YES : NO;
}

- (void)persistSeries:(PBSeries *)series {
	NSString *path= [[self seriesDirectory] stringByAppendingPathComponent:[self filenameForSeries:series]];
	NSOutputStream *target= [NSOutputStream outputStreamToFileAtPath:path append:NO];
	[series writeToOutputStream:target];
}

- (NSString *)seriesDirectory {
	return [Files documentDirectoryNamed:@"series"];
}

- (NSString *)filenameForSeries:(PBSeries *)series {
	return [NSString stringWithFormat:@"%@.series", series.seriesId];
}

- (void)dealloc {
	self.favoriteSeries= nil;
	[super dealloc];
}

@end
