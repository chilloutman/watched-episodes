//
//  SeriesManager.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/26/11.
//  Copyright 2011 Lucas Neiva. All rights reserved.
//

#import "SeriesManager.h"
#import "ServiceLocator.h"
#import "Files.h"
#import "Persister.h"


@interface SeriesManager ()

@property (nonatomic, retain) NSMutableArray *seriesIds;

@end


@implementation SeriesManager {
    Persister *_persister;
}

@synthesize seriesIds, seriesLoader, seriesBannerLoader;

+ (SeriesManager *)shared {
    return [ServiceLocator singletonForClass:[SeriesManager class]];
}

- (id)initWithPersister:(Persister *)persister {
    self = [super init];
	if (self != nil) {
		self.seriesIds = [NSMutableArray array];
        _persister = persister;
	}
	return self;
}

- (SeriesLoader *)seriesLoader {
	if (!seriesLoader) {
		seriesLoader = [[SeriesLoader alloc] init];
	}
	return seriesLoader;
}

- (SeriesBannerLoader *)seriesBannerLoader {
	if (!seriesBannerLoader) {
		seriesBannerLoader = [[SeriesBannerLoader alloc] init];
	}
	return seriesBannerLoader;
}

- (void)loadSeriesForSeriesId:(NSString *)seriesId completionBlock:(SeriesBlock)block {
	[self.seriesLoader loadSeriesForSeriesId:seriesId completionBlock:block];
}

- (void)loadSeriesBannerForBannerPath:(NSString *)bannerPath completionBlock:(ImageBlock)block {
	[self.seriesBannerLoader loadSeriesBannerForBannerPath:bannerPath completionBlock:block];
}

- (NSArray *)favoriteSeriesIds {
    NSArray *favorites = [_persister loadFavoriteSeries];
    NSMutableArray *ids = [[NSMutableArray alloc] initWithCapacity:favorites.count];
    for (FavoriteSeries *favorite in favorites) {
        [ids addObject:favorite.seriesId];
    }
	return ids;
}

- (void)addSeriesToFavorites:(NSString *)seriesId {
	if (![self.seriesIds containsObject:seriesId]) {
		[self.seriesIds addObject:seriesId];
        [_persister insertFavoriteSeries:seriesId];
	}
}

- (BOOL)isSeriesInFavorites:(NSString *)seriesId {
	return [self.seriesIds containsObject:seriesId];
}

@end
