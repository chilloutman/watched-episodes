//
//  WatchedManager.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 7/4/11.
//  Copyright 2011 Lucas Neiva. All rights reserved.
//

#import "WatchedManager.h"
#import "FileHelper.h"
#import "WatchedStateDocument.h"

@interface WatchedManager () {
	NSMutableDictionary *documents;
}

- (WatchedStateDocument *)documentForSeries:(NSString *)seriesId;

@end


@implementation WatchedManager

- (id)init {
	self = [super init];
	if (self) {
		documents = [[NSMutableDictionary alloc] init];
	}
	return self;
}

- (NSUInteger)numberOfUnwatchedEpisodesForSeries:(PBSeries *)series {
	// TODO: How to get the total episodes here? maybe make this "numberOfWatched"?
	return 0;
}

- (void)markEpisodeAsWatched:(PBEpisode *)episode {
    WatchedStateDocument *document = [self documentForSeries:episode.seriesId];
    [document markEpisodeAsWatched:episode];
//    [document openWithCompletionHandler: ^ (BOOL success) {
//        [document markEpisodeAsWatched:episode];
//        [document closeWithCompletionHandler:^ (BOOL success) { }];
//    }];
}

- (BOOL)isEpisodeMarkedAsWatched:(PBEpisode *)episode {
    WatchedStateDocument *document = [self documentForSeries:episode.seriesId];
    return [document isEpisodeMarkedAsWatched:episode];
}

- (WatchedStateDocument *)documentForSeries:(NSString *)seriesId {
    WatchedStateDocument *document = [documents objectForKey:seriesId];
    if (!document) {
        document = [WatchedStateDocument documentForSeries:seriesId];
        [documents setObject:document forKey:seriesId];
    }
    return document;
}

- (void)dealloc {
	[documents release];
	[super dealloc];
}

@end
