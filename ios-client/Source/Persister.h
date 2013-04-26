//
//  Persiter.h
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 4/26/13.
//  Copyright (c) 2013 Lucas Neiva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FavoriteSeries.h"

extern NSString const *FavoriteSeriesAddedNotification;

@interface Persister : NSObject

- (void)save;

- (FavoriteSeries *)insertFavoriteSeries:(NSString *)seriesId;
- (NSArray *)loadFavoriteSeries;
- (FavoriteSeries *)loadFavoriteSeriesWithId:(NSString *)seriesId;

@end
