//
//  SearchLoader.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SeriesLoader.h"
#import "GetSeries.pb.h"


@implementation SeriesLoader

- (void)loadSeriesForSeriesId:(NSString *)seriesId completionBlock:(SeriesBlock)block {
	NSString *URLString = [NSString stringWithFormat:@"%@/getSeries?id=%@", ServerURL, seriesId];
	[self.fetcher sendProtocolBuffersRequestWithURLString:URLString completionBlock:^ (NSData *data) {
		PBSeries *series = [GetSeriesResponse parseFromData:data].series;
		block(series);
	}];
}

@end
