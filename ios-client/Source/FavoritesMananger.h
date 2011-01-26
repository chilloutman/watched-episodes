//
//  FavoritesMananger.h
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GetSeries.pb.h"

@interface FavoritesMananger : NSObject {
	NSMutableArray *favoriteSeries;
}

@property (nonatomic, readonly) NSArray *allFavoriteSeries;

- (void)addSeriesToFavorites:(PBSeries *)series;
- (BOOL)isInFavorites:(NSString *)seriesId;

@end
