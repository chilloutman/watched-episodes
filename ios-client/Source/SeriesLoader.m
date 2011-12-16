//
//  SearchLoader.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/21/11.
//  Copyright 2011 Lucas Neiva. All rights reserved.
//

#import "SeriesLoader.h"
#import "GetSeries.pb.h"
#import "HTTPFetcher.h"
#import "FileCache.h"


@interface SeriesLoader ()

- (PBSeries *)seriesFromData:(NSData *)data;
- (NSString *)URLStringForSeriesId:(NSString *)seriesId;

@end


@implementation SeriesLoader

- (void)loadSeriesForSeriesId:(NSString *)seriesId completionBlock:(SeriesBlock)block {
	NSData *cachedData = [self.cache loadDataForKey:seriesId];
	if (cachedData) {
		dispatch_async(dispatch_get_main_queue(), ^ {
			block([self seriesFromData:cachedData]);
		});
	} else {
		[self.fetcher sendHTTPRequestWithURLString:[self URLStringForSeriesId:seriesId] completionBlock:^ (NSData *data) {
			PBSeries *series = [self seriesFromData:data];
			[self.cache cacheData:data forKey:seriesId];
			block(series);
		}];
	}
}

- (PBSeries *)seriesFromData:(NSData *)data {
	return [GetSeriesResponse parseFromData:data].series;
}

- (NSString *)URLStringForSeriesId:(NSString *)seriesId {
	return [NSString stringWithFormat:@"%@/getSeries?id=%@", ServerURL, seriesId];
}

- (NSString *)cacheDirectoryPath {
	return @"SeriesCache";
}

@end
