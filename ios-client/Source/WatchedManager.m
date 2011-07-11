//
//  WatchedManager.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 7/4/11.
//  Copyright 2011 Lucas Neiva. All rights reserved.
//

#import "WatchedManager.h"
#import "FileHelper.h"


@interface WatchedManager () {
	NSMutableDictionary *loadedStates;
}

- (void)storeWatchedStateForSeries:(NSString *)seriesId;
- (NSMutableDictionary *)watchedStateForSeries:(NSString *)seriesId;
- (NSMutableDictionary *)loadWatchedStateForSeries:(NSString *)seriesId;
- (NSString *)filePathForSeries:(NSString *)seriesId;

@end


@implementation WatchedManager

- (id)init {
	self = [super init];
	if (self) {
		loadedStates = [[NSMutableDictionary alloc] init];
	}
	return self;
}

- (void)markEpisodeAsWatched:(PBEpisode *)episode {
	if (![self isEpisodeMarkedAsWatched:episode]) {
		// TODO: Create categories to make do this string conversions
		NSString *seasonNumber = [NSString stringWithFormat:@"%d", episode.seasonNumber];
		NSString *episodeNumber = [NSString stringWithFormat:@"%d", episode.episodeNumber];
		
		NSMutableDictionary *watchedState = [self watchedStateForSeries:episode.seriesId];
		NSMutableArray *season = [watchedState objectForKey:seasonNumber];
		if (season == nil) {
			season = [NSMutableArray arrayWithObject:episodeNumber];
			[watchedState setObject:season forKey:seasonNumber];
		} else {
			[season addObject:episodeNumber];
		}
		
		[self storeWatchedStateForSeries:episode.seriesId];
	}
}

- (BOOL)isEpisodeMarkedAsWatched:(PBEpisode *)episode {
	NSDictionary *watchedState = [self watchedStateForSeries:episode.seriesId];
	
	// TODO: Create categories to make do this string conversions
	NSString *season = [NSString stringWithFormat:@"%d", episode.seasonNumber];
	NSString *episodeNumber = [NSString stringWithFormat:@"%d", episode.episodeNumber];
	return [[watchedState objectForKey:season] containsObject:episodeNumber];
}

- (NSUInteger)numberOfUnwatchedEpisodesForSeries:(PBSeries *)series {
	// TODO: How to get the total episodes here? maybe make this "numberOfWatched"?
	return 0;
}

- (void)storeWatchedStateForSeries:(NSString *)seriesId {
	NSOutputStream *stream = [NSOutputStream outputStreamToFileAtPath:[self filePathForSeries:seriesId] append:NO];
	[stream open];
	NSError *error = nil;
	if ([NSJSONSerialization writeJSONObject:[self watchedStateForSeries:seriesId] toStream:stream options:0 error:&error] == 0) {
		// TODO: handle error
		NSLog(@"%@", [error localizedDescription]);
	}
}

- (NSMutableDictionary *)watchedStateForSeries:(NSString *)seriesId {
	NSMutableDictionary *watchedState = [loadedStates objectForKey:seriesId];
	if (watchedState == nil) {
		watchedState = [self loadWatchedStateForSeries:seriesId];
		if ([watchedState count] > 0) {
			[loadedStates setObject:watchedState forKey:seriesId];
		}
	}
	return watchedState;
}

- (NSMutableDictionary *)loadWatchedStateForSeries:(NSString *)seriesId {
	NSString *filePath = [self filePathForSeries:seriesId];
	NSMutableDictionary *watchedState = nil;
	if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
		NSInputStream *stream = [NSInputStream inputStreamWithFileAtPath:[self filePathForSeries:seriesId]];
		[stream open];
		NSError *error = nil;
		watchedState = [[NSJSONSerialization JSONObjectWithStream:stream options:NSJSONReadingMutableContainers error:&error] mutableCopy];
		
		if (error) {
			// TODO: handle error
			NSLog(@"%@", [error localizedDescription]);
			watchedState = [NSMutableDictionary dictionary];
		}
	} else {
		watchedState = [NSMutableDictionary dictionary];
	}
	
	return watchedState;
}

- (NSString *)filePathForSeries:(NSString *)seriesId {
	return [[FileHelper documentDirectoryNamed:@"watched"] stringByAppendingPathComponent:seriesId];
}

- (void)dealloc {
	[loadedStates release];
	[super dealloc];
}

@end
