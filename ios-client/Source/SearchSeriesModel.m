//
//  SearchSeriesModel.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SearchSeriesModel.h"

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
	[com sendProtocolBuffersGETRequestWithURL:url requestId:nil delegate:self];
}

- (void)requestDidSucceed:(id<NSObject>)requestId {
	[self.delegate searchResultsUpdated:self.searchResults];
}

- (void)receivedResponse:(NSData *)responseData requestId:(id<NSObject>)requestId {
	self.searchResults= [[SearchSeriesResponse parseFromData:responseData] seriesList];
}

- (void)requestDidFail:(id<NSObject>)requestId {
	//[self.delegate searchResultsUpdated:[NSArray arrayWithObject:@"Connection Failed"]];
}

@end
