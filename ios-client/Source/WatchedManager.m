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
#import "Files.h"


NSString * const WatchedManagerDidFinishLoadingNotification = @"WatchedManagerAvailableNotification";


@implementation WatchedEpisode

@synthesize seriesId, episodeNumber, seasonNumber;

+ (WatchedEpisode *)episodeWithSeriesId:(NSString *)seriesId dictionary:(NSDictionary *)lastWatchedDictionary {
	return [WatchedEpisode episodeWithSeriesId:nil
								 episodeNumber:[[lastWatchedDictionary objectForKey:@"episode"] unsignedIntegerValue]
								  seasonNumber:[[lastWatchedDictionary objectForKey:@"season"] unsignedIntegerValue]];
}

+ (WatchedEpisode *)episodeWithSeriesId:(NSString *)seriesId episodeNumber:(NSUInteger)episodeNumber seasonNumber:(NSUInteger)seasonNumber {
	WatchedEpisode *episode = [[WatchedEpisode alloc] init];
	episode.seriesId = seriesId;
	episode.episodeNumber = episodeNumber;
	episode.seasonNumber = seasonNumber;
	return [episode autorelease];
}

- (BOOL)isZero {
	return (self.seasonNumber == 0) && (self.episodeNumber == 0);
}

- (void)dealloc {
	self.seriesId = nil;
}

@end


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

- (void)setLastWatchedEpisode:(WatchedEpisode *)episode {
	NSMutableDictionary *lastWatched= [self.document lastWatchedEpisodeDictionaryForSeries:episode.seriesId];
	[lastWatched setObject:[NSNumber numberWithUnsignedInteger:episode.episodeNumber] forKey:@"episode"];
	[lastWatched setObject:[NSNumber numberWithUnsignedInteger:episode.seasonNumber] forKey:@"season"];
	[self.document updateChangeCount:UIDocumentChangeDone];
}

- (BOOL)isEpisodeMarkedAsWatched:(PBEpisode *)episode {
	WatchedEpisode *watchedEpisode = [self lastWatchedEpisodeForSeriesId:episode.seriesId];
	
	if (episode.seasonNumber < watchedEpisode.seasonNumber) {
		return YES;
	} else if (episode.seasonNumber == watchedEpisode.seasonNumber && episode.episodeNumber <= watchedEpisode.episodeNumber) {
		return YES;
	} else {
		return NO;
	}
}

- (WatchedEpisode *)lastWatchedEpisodeForSeriesId:(NSString *)seriesId {
	return [WatchedEpisode episodeWithSeriesId:seriesId dictionary:[self.document lastWatchedEpisodeDictionaryForSeries:seriesId]];
}

- (void)loadLastWatchedEpisodesWithCompletionBlock:(void (^) ())block {
	if ([Files fileExistsAtPath:self.document.fileURL.path]) {
		[self.document openWithCompletionHandler:^ (BOOL success) {
            if (success) {
				NSLog(@"Document was opened");
                block();
            } else {
                NSLog(@"Could not open document");
            }
        }];
	} else {
		[self.document saveToURL:self.document.fileURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^ (BOOL success) {
			if (success) {
				NSLog(@"Document created");
                block();
            } else {
                NSLog(@"Document could not be created");
            }
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
