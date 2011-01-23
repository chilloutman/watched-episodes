//
//  SeriesBannerModel.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SeriesBannerLoader.h"
#import "ServiceLocator.h"
#import "CommunicationAgent.h"


@interface SeriesBannerLoader () <CommunicationDelegate>

@property (nonatomic, retain) UIImage *banner;

@end


@implementation SeriesBannerLoader

@synthesize delegate, banner;

- (void)loadSeriesBanner:(NSString *)bannerPath {
	NSURL *url= [NSURL URLWithString:[@"http://www.thetvdb.com/banners/" stringByAppendingString:bannerPath]];
	
	CommunicationAgent *com= [ServiceLocator singletonForClass:[CommunicationAgent class]];
	[com sendProtocolBuffersGETRequestWithURL:url requestId:nil delegate:self];
}

#pragma mark CommunicationDelegate

- (void)receivedResponse:(NSData *)responseData requestId:(NSString *)requestId {
	self.banner= [UIImage imageWithData:responseData];
}

- (void)requestDidSucceed:(NSString *)requestId {
	[self.delegate loadedSeriesBanner:self.banner];
}

- (void)requestDidFail:(NSString *)requestId {
	self.banner= nil;
}

#pragma mark -

- (void)dealloc {
	self.banner= nil;
	[super dealloc];
}


@end
