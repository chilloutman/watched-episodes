//
//  WatchedManager.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 7/4/11.
//  Copyright 2011 Lucas Neiva. All rights reserved.
//

#import "WatchedManager.h"
#import "ServiceLocator.h"
#import "WatchedStateDocument.h"


@interface WatchedManager ()

@property (nonatomic, assign) BOOL documentIsOpen; // Or "documentIsOpenning". UIDocumentState doens't provide that information
@property (nonatomic, retain) WatchedStateDocument *document;

@end


@implementation WatchedManager

@synthesize documentIsOpen, document;

+ (WatchedManager *)shared {
	return [ServiceLocator singletonForClass:[WatchedManager class]];
}

- (WatchedStateDocument *)document {
	if (!document) {
		document= [[WatchedStateDocument alloc] init];
	}
	return document;
}

- (void)setLastWatchedEpisode:(PBEpisode *)episode {
	NSMutableDictionary *lastWatched= [self.document lastWatchedEpisodeDictionaryForSeries:episode.seriesId];
	[lastWatched setObject:[NSNumber numberWithUnsignedInteger:episode.episodeNumber] forKey:@"episode"];
	[lastWatched setObject:[NSNumber numberWithUnsignedInteger:episode.seasonNumber] forKey:@"season"];
	[self.document updateChangeCount:UIDocumentChangeDone];
}

- (void)setLastWatchedEpisodeNumber:(NSUInteger)number forSeries:(NSString *)seriesId {
	NSMutableDictionary *lastWatched= [self.document lastWatchedEpisodeDictionaryForSeries:seriesId];
	[lastWatched setObject:[NSNumber numberWithUnsignedInteger:number] forKey:@"episode"];
	[self.document updateChangeCount:UIDocumentChangeDone];
}

- (void)setLastWatchedEpisodeSeasonNumber:(NSUInteger)number forSeries:(NSString *)seriesId {
	NSMutableDictionary *lastWatched= [self.document lastWatchedEpisodeDictionaryForSeries:seriesId];
	[lastWatched setObject:[NSNumber numberWithUnsignedInteger:number] forKey:@"season"];
	[self.document updateChangeCount:UIDocumentChangeDone];
}

- (BOOL)isEpisodeMarkedAsWatched:(PBEpisode *)episode {
	return [episode seasonNumber] <= [self lastWatchedEpisodeSeasonNumberForSeriesId:episode.seriesId]
	&& [episode episodeNumber] <= [self lastWatchedEpisodeNumberForSeriesId:episode.seriesId];
}

- (NSUInteger)lastWatchedEpisodeNumberForSeriesId:(NSString *)seriesId {
	return [[[self.document lastWatchedEpisodeDictionaryForSeries:seriesId] objectForKey:@"episode"] unsignedIntegerValue];
}
			
- (NSUInteger)lastWatchedEpisodeSeasonNumberForSeriesId:(NSString *)seriesId {
	return [[[self.document lastWatchedEpisodeDictionaryForSeries:seriesId] objectForKey:@"season"] unsignedIntegerValue];
}

- (void)loadLastWatchedEpisodesWithHandler:(void (^) ())handler {
    if (self.documentIsOpen) {
        handler();
    } else {
		self.documentIsOpen = YES;
        [self.document openWithCompletionHandler:^ (BOOL success) {
            if (success) {
				NSLog(@"Document was opened");
                handler();
            } else {
                NSLog(@"Could not open document");
            }
        }];
    }
}

- (void)closeDocument {
	self.documentIsOpen = NO;
	[self.document closeWithCompletionHandler:^ (BOOL success) {
		if (success) {
			NSLog(@"Document was closed");
		} else {
			NSLog(@"Document could not be closed");
		}
	}];
}

#pragma mark -

- (void)dealloc {
	self.document = nil;
	[super dealloc];
}

@end
