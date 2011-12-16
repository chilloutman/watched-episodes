//
//  SeriesManager.h
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/26/11.
//  Copyright 2011 Lucas Neiva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SeriesLoader.h"
#import "SeriesBannerLoader.h"

@interface SeriesManager : NSObject

@property (nonatomic, readonly) NSArray *favoriteSeriesIds;
@property (nonatomic, readonly) SeriesLoader *seriesLoader;
@property (nonatomic, readonly) SeriesBannerLoader *seriesBannerLoader;


+ (SeriesManager *)shared;

- (void)loadFavoritesWithCompletionBlock:(void (^) ())block;
- (void)save;
- (void)closeDocument;

- (void)addSeriesToFavorites:(NSString *)seriesId;
- (BOOL)isSeriesInFavorites:(NSString *)seriesId;

@end
