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
@property (nonatomic, retain) UIImage *banner;

- (BOOL)isBannerRequest:(NSString *)requestId;

@end


@implementation SeriesModel

@synthesize delegate;
@synthesize series, banner;

- (void)loadSeries:(NSString *)seriesId {
	NSURL *url= [NSURL URLWithString:[NSString stringWithFormat:@"%@/getSeries?id=%@", ServerURL, seriesId]];
	
	CommunicationAgent *com= [ServiceLocator singletonForClass:[CommunicationAgent class]];
	[com sendProtocolBuffersGETRequestWithURL:url requestId:nil delegate:self];
}

- (void)loadSeriesBanner:(NSString *)bannerPath {
	NSURL *url= [NSURL URLWithString:[@"http://www.thetvdb.com/banners/" stringByAppendingString:bannerPath]];
	
	CommunicationAgent *com= [ServiceLocator singletonForClass:[CommunicationAgent class]];
	[com sendProtocolBuffersGETRequestWithURL:url requestId:@"banner" delegate:self];
}

- (BOOL)isBannerRequest:(NSString *)requestId {
	return [requestId isEqualToString:@"banner"];
}

#pragma mark CommunicationDelegate

- (void)receivedResponse:(NSData *)responseData requestId:(NSString *)requestId {
	if ([self isBannerRequest:requestId]) {
		self.banner= [UIImage imageWithData:responseData];
	} else {
		PBSeries *response= [PBSeries parseFromData:responseData];
		self.series= [Series seriesFromProtoMessage:response];
	}
}

- (void)requestDidSucceed:(NSString *)requestId {
	if ([self isBannerRequest:requestId]) {
		[self.delegate loadedSeriesBanner:self.banner];
	} else {
		[self.delegate loadedSeries:self.series];
	}
}

- (void)requestDidFail:(NSString *)requestId {
	self.series= nil;
	self.banner= nil;
}

#pragma mark -

- (void)dealloc {
	self.series= nil;
	self.banner= nil;
	[super dealloc];
}

@end
