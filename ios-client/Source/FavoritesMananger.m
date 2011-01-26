//
//  FavoritesMananger.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FavoritesMananger.h"


@interface FavoritesMananger ()

@property (nonatomic, retain) NSMutableArray *favoriteSeries;

@end


@implementation FavoritesMananger

@synthesize favoriteSeries;

- (id)init {
	if (self= [super init]) {
		self.favoriteSeries= [NSMutableArray array];
	}
	return self;
}

- (NSArray *)allFavoriteSeries {
	return [NSArray arrayWithArray:self.favoriteSeries];
}

- (void)addSeriesToFavorites:(PBSeries *)series {
	if (![self isInFavorites:series.seriesId]) {
		[self.favoriteSeries addObject:series];
		// TODO persist
	}
}

- (BOOL)isInFavorites:(NSString *)seriesId {
	for (PBSeries *series in self.favoriteSeries) {
		if ([series.seriesId isEqualToString:seriesId]) {
			return YES;
		}
	}
	return NO;
}

- (void)dealloc {
	[super dealloc];
}

@end
