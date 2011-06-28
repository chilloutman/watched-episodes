//
//  SearchSeriesModel.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SearchLoader.h"
#import "NSString+URLEncoding.h"


@interface SearchLoader () <ProtocolBuffersFetcherDelegate>

@property (nonatomic, retain) NSArray *searchResults;

@end


@implementation SearchLoader

@synthesize delegate, searchResults;

- (void)searchSeries:(NSString *)seriesName {
	NSString *searchTerm = [seriesName URLEncodedString];
	[self.fetcher sendProtocolBuffersRequestWithURLString:[NSString stringWithFormat:@"%@/searchSeries?name=%@", ServerURL, searchTerm] delegate:self];
}

#pragma mark ProtocolBuffersFetcherDelegate

- (void)processData:(NSData *)newData {
	self.searchResults= [[SearchSeriesResponse parseFromData:newData] seriesList];
	[self.delegate searchResultsUpdated:self.searchResults];
}

- (void)connectionFailed {
	//[self.delegate searchResultsUpdated:[NSArray arrayWithObject:@"Connection Failed"]];
}

#pragma mark -

- (void)dealloc {
	self.searchResults = nil;
	[super dealloc];
}

@end
