//
//  SearchLoader.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SeriesLoader.h"
#import "GetSeries.pb.h"


@interface SeriesLoader () <ProtocolBuffersFetcherDelegate>

@property (nonatomic, retain) PBSeries *series;

@end


@implementation SeriesLoader

@synthesize delegate;
@synthesize series;

- (void)loadSeries:(NSString *)seriesId {
	[self.fetcher sendProtocolBuffersRequestWithURLString:[NSString stringWithFormat:@"%@/getSeries?id=%@", ServerURL, seriesId] delegate:self];
}

#pragma mark ProtocolBuffersFetcherDelegate

- (void)processData:(NSData *)newData {
	self.series = [GetSeriesResponse parseFromData:newData].series;
	[self.delegate loadedSeries:self.series];
}

- (void)connectionFailed {
	self.series= nil;
}

#pragma mark -

- (void)dealloc {
	self.series = nil;
	[super dealloc];
}

@end
