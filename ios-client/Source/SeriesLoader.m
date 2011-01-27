//
//  SeriesModel.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SeriesLoader.h"

#import "GetSeries.pb.h"

#import "ServiceLocator.h"
#import "CommunicationAgent.h"


@interface SeriesLoader ()

@property (nonatomic, retain) PBSeries *series;

@end


@implementation SeriesLoader

@synthesize delegate;
@synthesize series;

- (void)loadSeries:(NSString *)seriesId {
	NSURL *url= [NSURL URLWithString:[NSString stringWithFormat:@"%@/getSeries?id=%@", ServerURL, seriesId]];
	
	CommunicationAgent *com= [ServiceLocator singletonForClass:[CommunicationAgent class]];
	[com sendProtocolBuffersGETRequestWithURL:url requestId:nil delegate:self];
}

#pragma mark CommunicationDelegate

- (void)receivedResponse:(NSData *)responseData requestId:(NSString *)requestId {
	self.series= [GetSeriesResponse parseFromData:responseData].series;
}

- (void)requestDidSucceed:(NSString *)requestId {
	[self.delegate loadedSeries:self.series];
}

- (void)requestDidFail:(NSString *)requestId {
	self.series= nil;
}

#pragma mark -

- (void)dealloc {
	self.series= nil;
	[super dealloc];
}

@end
