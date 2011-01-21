//
//  SearchSeriesModel.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SearchSeriesModel.h"

#import "SearchSeries.pb.h"
#import "NSString+URLEncoding.h"

#import "ServiceLocator.h"
#import "CommunicationAgent.h"


@interface SearchSeriesModel ()

@property (nonatomic, retain) NSArray *searchResults;

@end


@implementation SearchSeriesModel

@synthesize delegate, searchResults;

- (void)searchSeries:(NSString *)seriesName {
	NSString *searchTerm= [seriesName URLEncodedString];
	NSURL *url= [NSURL URLWithString:[NSString stringWithFormat:@"%@/searchSeries?name=%@", ServerURL, searchTerm]];
	
	CommunicationAgent *com= [ServiceLocator singletonForClass:[CommunicationAgent class]];
	[com sendProtocolBuffersGETRequestWithURL:url delegate:self];
}

- (void)requestDidSuccedWithURL:(NSURL *)url {
	[self.delegate searchResultsUpdated:self.searchResults];
}

- (void)receivedResponse:(NSData *)responseData {
	NSArray *parsedResults= [[PBSearchResults parseFromData:responseData] seriesList];
	NSMutableArray *results= [NSMutableArray arrayWithCapacity:[parsedResults count]];
	
	for (PBSearchResults_PBSeriesSummary *series in parsedResults) {
		[results addObject:[SeriesSummary seriesFromProtoMessage:series]];
	}
	self.searchResults= results;
}

- (void)requestDidFailWithURL:(NSURL *)url {
	[self.delegate searchResultsUpdated:[NSArray arrayWithObject:@"Connection Failed"]];
}

@end
