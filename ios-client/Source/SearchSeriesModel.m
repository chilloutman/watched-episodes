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


@implementation SearchSeriesModel

@synthesize delegate;

- (void)searchSeries:(NSString *)seriesName {
	NSString *searchTerm= [seriesName URLEncodedString];
	NSURL *url= [NSURL URLWithString:[NSString stringWithFormat:@"%@/searchSeries?name=%@&t=protobuf", ServerURL, searchTerm]];
	
	CommunicationAgent *com= [ServiceLocator singletonForClass:[CommunicationAgent class]];
	[com sendRequestWithURL:url delegate:self];
}

- (void)requestDidSuccedWithURL:(NSURL *)url response:(NSData *)response {
	NSArray *parsedResults= [[PBSearchResults parseFromData:response] seriesList];
	NSMutableArray *results= [NSMutableArray arrayWithCapacity:[parsedResults count]];
	
	for (PBSearchResults_PBSeries *series in parsedResults) {
		[results addObject:[series name]];
	}
	
	[self.delegate searchResultsUpdated:results];
}

- (void)requestDidFailWithURL:(NSURL *)url {
	[self.delegate searchResultsUpdated:[NSArray array]];
}

@end
