//
//  FavoritesMananger.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FavoritesMananger.h"
#import "FileHelper.h"


@interface FavoritesMananger ()

@property (nonatomic, retain) NSMutableArray *favoriteSeries;

- (void)loadFavoritesFromFilessystem;
- (void)persistSeries:(PBSeries *)series;
- (NSString *)seriesDirectory;
- (NSString *)filenameForSeries:(PBSeries *)series;

@end


@implementation FavoritesMananger

@synthesize favoriteSeries;

- (id)init {
	if (self= [super init]) {
		self.favoriteSeries= [NSMutableArray array];
		[self loadFavoritesFromFilessystem];
	}
	return self;
}

- (void)loadFavoritesFromFilessystem {
	NSFileManager *fileManager= [NSFileManager defaultManager];
	NSString *seriesDirectory= [self seriesDirectory];
	NSDirectoryEnumerator *dirEnum= [fileManager enumeratorAtPath:seriesDirectory];
	
	NSString *file;
	while (file= [dirEnum nextObject]) {
		NSLog(@"%@", file);
		if ([[file pathExtension] isEqualToString:@"series"]) {
			PBSeries *series= [PBSeries parseFromData:[fileManager contentsAtPath:[seriesDirectory stringByAppendingPathComponent:file]]];
			[self.favoriteSeries addObject:series];
		}
	}
}

- (NSArray *)allFavoriteSeries {
	return [NSArray arrayWithArray:self.favoriteSeries];
}

- (void)addSeriesToFavorites:(PBSeries *)series {
	if (![self isInFavorites:series.seriesId]) {
		[self.favoriteSeries addObject:series];
		[self persistSeries:series];
	}
}

- (BOOL)isInFavorites:(NSString *)seriesId {
	for (PBSeries *series in self.favoriteSeries) {
		if ([series.seriesId isEqualToString:seriesId]) {
			return YES;
		}
	}
	return NO;
}

- (void)persistSeries:(PBSeries *)series {
	NSString *path= [[self seriesDirectory] stringByAppendingPathComponent:[self filenameForSeries:series]];
	NSOutputStream *target= [NSOutputStream outputStreamToFileAtPath:path append:NO];
	[series writeToOutputStream:target];
}

- (NSString *)seriesDirectory {
	return [FileHelper documentDirectoryNamed:@"series"];
}

- (NSString *)filenameForSeries:(PBSeries *)series {
	return [NSString stringWithFormat:@"%@.series", series.seriesId];
}

- (void)dealloc {
	self.favoriteSeries= nil;
	[super dealloc];
}

@end
