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
#import "FileHelper.h"


NSString * const WatchedManagerDidFinishLoadingNotification = @"WatchedManagerAvailableNotification";


@interface WatchedManager ()

@property (nonatomic, retain) WatchedStateDocument *document;

@end


@implementation WatchedManager

@synthesize document;

+ (WatchedManager *)shared {
	return [ServiceLocator singletonForClass:[WatchedManager class]];
}

- (id)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserverForName:UIDocumentStateChangedNotification object:self.document queue:[NSOperationQueue mainQueue] usingBlock:^ (NSNotification *n) {
			NSLog(@"%d", self.document.documentState);
		}];
    }
    return self;
}

- (WatchedStateDocument *)document {
	if (!document) {
		document = [[WatchedStateDocument alloc] init];
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
	if ([FileHelper fileExistsAtPath:self.document.fileURL.path]) {
		[self.document openWithCompletionHandler:^ (BOOL success) {
            if (success) {
				NSLog(@"Document was opened");
                handler();
            } else {
                NSLog(@"Could not open document");
            }
        }];
	} else {
		[self.document saveToURL:self.document.fileURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^ (BOOL success) {
			NSLog(@"Document created");
			handler();
		}];
	}
}

- (void)save {
	[self.document savePresentedItemChangesWithCompletionHandler:^ (NSError *error) { }];
}

- (void)closeDocument {
	[self.document closeWithCompletionHandler:^ (BOOL success) {
		if (success) {
			self.document = nil;
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
