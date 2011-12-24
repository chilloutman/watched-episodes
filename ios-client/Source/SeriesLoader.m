//
//  SearchLoader.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/21/11.
//  Copyright 2011 Lucas Neiva. All rights reserved.
//

#import "SeriesLoader.h"
#import "GetSeries.pb.h"
#import "FileCache.h"


@interface SeriesLoader ()

@property (nonatomic, copy) SeriesBlock completionBlock;

- (PBSeries *)seriesFromData:(NSData *)data;
- (NSString *)URLStringForSeriesId:(NSString *)seriesId;

@end


@implementation SeriesLoader

@synthesize completionBlock;

- (void)loadSeriesForSeriesId:(NSString *)seriesId completionBlock:(SeriesBlock)block {
	self.completionBlock = block;
	NSData *cachedData = [self.cache loadDataForKey:seriesId];
	if (cachedData) {
		dispatch_async(dispatch_get_main_queue(), ^ {
			if (self.completionBlock) {
				self.completionBlock([self seriesFromData:cachedData]);
			}
		});
	} else {
		[self sendHTTPRequestWithURLString:[self URLStringForSeriesId:seriesId] completionBlock:^ (NSData *data) {
			if (self.completionBlock) {
				PBSeries *series = [self seriesFromData:data];
				[self.cache cacheData:data forKey:seriesId];
				block(series);
			}
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

- (void)cancel {
	[super cancel];
	self.completionBlock = nil;
}

@end
