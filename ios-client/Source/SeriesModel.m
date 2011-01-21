//
//  SeriesModel.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SeriesModel.h"

#import "GetSeries.pb.h"

#import "ServiceLocator.h"
#import "CommunicationAgent.h"


@interface SeriesModel ()

@property (nonatomic, retain) Series *series;

@end


@implementation SeriesModel

@synthesize delegate;
@synthesize series;

- (void)getSeries:(NSString *)seriesId {
	NSURL *url= [NSURL URLWithString:[NSString stringWithFormat:@"%@/getSeries?id=%@", ServerURL, seriesId]];
	
	CommunicationAgent *com= [ServiceLocator singletonForClass:[CommunicationAgent class]];
	[com sendProtocolBuffersGETRequestWithURL:url delegate:self];
}

#pragma mark CommunicationDelegate

- (void)receivedResponse:(NSData *)responseData {
	PBSeries *response= [PBSeries parseFromData:responseData];
	self.series= [Series seriesFromProtoMessage:response];
}

- (void)requestDidSuccedWithURL:(NSURL *)url {
	[self.delegate seriesUpdated:self.series];
}
	 

- (void)requestDidFailWithURL:(NSURL *)url {
	
}

@end
