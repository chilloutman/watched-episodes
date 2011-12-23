//
//  WatchedManager.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 7/4/11.
//  Copyright 2011 Lucas Neiva. All rights reserved.
//

#import "WatchedManager.h"
#import "ServiceLocator.h"
#import "JSONDocument.h"
#import "Files.h"


NSString * const WatchedManagerDidFinishLoadingNotification = @"WatchedManagerAvailableNotification";


@implementation WatchedEpisode

@synthesize seriesId, episodeNumber, seasonNumber;

+ (WatchedEpisode *)episodeWithSeriesId:(NSString *)seriesId dictionary:(NSDictionary *)lastWatchedDictionary {
	return [WatchedEpisode episodeWithSeriesId:seriesId
								 episodeNumber:[[lastWatchedDictionary objectForKey:@"e"] unsignedIntegerValue]
								  seasonNumber:[[lastWatchedDictionary objectForKey:@"s"] unsignedIntegerValue]];
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


@interface WatchedManager () <JSONDocumentDataProvider>

@property (nonatomic, retain) JSONDocument *document;
@property (nonatomic, retain) NSMutableDictionary *lastWatchedEpisodes;

- (NSMutableDictionary *)lastWatchedEpisodeDictionaryForSeries:(NSString *)seriesId;

@end


@implementation WatchedManager

@synthesize document, lastWatchedEpisodes;

+ (WatchedManager *)shared {
	return [ServiceLocator singletonForClass:[WatchedManager class]];
}

- (id)init {
    self = [super init];
    if (self) {
		self.lastWatchedEpisodes = [NSMutableDictionary dictionary];
	}
    return self;
}

- (JSONDocument *)document {
	if (!document) {
		document = [[JSONDocument alloc] initWithDocumentName:@"LastWatched.json" dataProvider:self];
	}
	return document;
}

- (void)setLastWatchedEpisode:(WatchedEpisode *)episode {
	NSMutableDictionary *lastWatched = [self lastWatchedEpisodeDictionaryForSeries:episode.seriesId];
	[lastWatched setObject:[NSNumber numberWithUnsignedInteger:episode.episodeNumber] forKey:@"e"];
	[lastWatched setObject:[NSNumber numberWithUnsignedInteger:episode.seasonNumber] forKey:@"s"];
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
	return [WatchedEpisode episodeWithSeriesId:seriesId dictionary:[self lastWatchedEpisodeDictionaryForSeries:seriesId]];
}

- (NSMutableDictionary *)lastWatchedEpisodeDictionaryForSeries:(NSString *)seriesId {
	NSMutableDictionary *dictionary = [self.lastWatchedEpisodes objectForKey:seriesId];
	if (!dictionary) {
		dictionary = [NSMutableDictionary dictionaryWithCapacity:2];
		[self.lastWatchedEpisodes setObject:dictionary forKey:seriesId];
	}
	
	return dictionary;
}

#pragma mark Opening and Closing the Document

- (void)loadLastWatchedEpisodesWithCompletionBlock:(void (^) ())block {
	[self.document openWithCompletionHandler:^ (BOOL success) {
		if (success) {
			block();
		}
	}];
}

- (void)save {
	[self.document savePresentedItemChangesWithCompletionHandler:^ (NSError *error) { }];
}

- (void)closeDocument {
	[self.document closeWithCompletionHandler:^ (BOOL success) {
		self.document = nil;
	}];
}

#pragma JSONDocumentDataProvider

- (void)setJSONObject:(NSMutableDictionary *)JSONObject {
	self.lastWatchedEpisodes = JSONObject;
}

- (id)JSONObject {
	return self.lastWatchedEpisodes;
}

- (BOOL)isJSONObjectEmpty {
	return [self.lastWatchedEpisodes count] == 0;
}

#pragma mark -

- (void)dealloc {
	self.document = nil;
	self.lastWatchedEpisodes = nil;
	[super dealloc];
}

@end
