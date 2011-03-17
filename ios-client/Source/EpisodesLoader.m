//
//  EpisodesLoader.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 3/17/11.
//  Copyright 2011 Ergon Informatik AG. All rights reserved.
//

#import "EpisodesLoader.h"
#import	"Constants.h"
#import "CommunicationAgent.h"
#import "GetAllEpisodes.pb.h"

@interface EpisodesLoader () <CommunicationDelegate>

@property (nonatomic, retain) NSArray *episodes;

@end


@implementation EpisodesLoader

@synthesize delegate, episodes;

- (void)loadAllEpisodesForSeries:(NSString *)seriesId {
	self.episodes = nil;
	CommunicationAgent *com = [ServiceLocator singletonForClass:[CommunicationAgent class]];
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/getAllEpisodes?id=%@", ServerURL, seriesId]];
	[com sendProtocolBuffersGETRequestWithURL:url delegate:self];
}

#pragma mark CommunicationDelegate

- (void)receivedResponse:(NSData *)responseData requestId:(NSString *)requestId {
	self.episodes = [GetAllEpisodesResponse parseFromData:responseData].episodesList;
}

- (void)requestDidSucceed:(NSString *)requestId {
	[self.delegate loadedEpisodes:self.episodes];
}

- (void)requestDidFail:(NSString *)requestId {
	self.episodes = nil;
}

#pragma mark -

- (void)dealloc {
	self.episodes = nil;
	[super dealloc];
}

@end
