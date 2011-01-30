//
//  FavoritesMananger.h
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProtocolTypes.pb.h"

@interface FavoritesMananger : NSObject {
	NSMutableDictionary *favoriteSeries;
}

@property (nonatomic, readonly) NSArray *allFavoriteSeries;

- (void)addSeriesToFavorites:(PBSeries *)series;
- (BOOL)isInFavorites:(NSString *)seriesId;
- (PBSeries *)seriesForSeriesId:(NSString *)seriesId;

@end
