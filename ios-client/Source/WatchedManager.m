//
//  WatchedManager.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 7/4/11.
//  Copyright 2011 Lucas Neiva. All rights reserved.
//

#import "WatchedManager.h"
#import "ServiceLocator.h"
#import "Files.h"
#import "Persister.h"


NSString * const WatchedManagerDidFinishLoadingNotification = @"WatchedManagerAvailableNotification";


@implementation WatchedEpisode

@synthesize seriesId, episodeNumber, seasonNumber;

+ (WatchedEpisode *)episodeWithFavoriteSeries:(FavoriteSeries *)favoriteSeries {
	return [WatchedEpisode episodeWithSeriesId:favoriteSeries.seriesId
                                 episodeNumber:[favoriteSeries.episode unsignedIntegerValue]
                                  seasonNumber:[favoriteSeries.season unsignedIntegerValue]];
}

+ (WatchedEpisode *)episodeWithSeriesId:(NSString *)seriesId episodeNumber:(NSUInteger)episodeNumber seasonNumber:(NSUInteger)seasonNumber {
	WatchedEpisode *episode = [[WatchedEpisode alloc] init];
	episode.seriesId = seriesId;
	episode.episodeNumber = episodeNumber;
	episode.seasonNumber = seasonNumber;
	return episode;
}

- (BOOL)isZero {
	return (self.seasonNumber == 0) && (self.episodeNumber == 0);
}

@end


@interface WatchedManager ()


@end


@implementation WatchedManager {
    Persister *_persister;
}

+ (WatchedManager *)shared {
	return [ServiceLocator singletonForClass:[WatchedManager class]];
}

- (id)initWithPersister:(Persister *)persister {
    self = [super init];
    if (self) {
        _persister = persister;
	}
    return self;
}

- (void)setLastWatchedEpisode:(WatchedEpisode *)episode {
    FavoriteSeries *favoriteSeries = [_persister loadFavoriteSeriesWithId:episode.seriesId];
    favoriteSeries.episode = @(episode.episodeNumber);
    favoriteSeries.season = @(episode.seasonNumber);
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
    FavoriteSeries *favoriteSeries = [_persister loadFavoriteSeriesWithId:seriesId];
	return [WatchedEpisode episodeWithFavoriteSeries:favoriteSeries];
}

@end
