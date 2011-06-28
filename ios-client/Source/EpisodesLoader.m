//
//  EpisodesLoader.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 3/17/11.
//  Copyright 2011 Lucas Neiva Informatik AG. All rights reserved.
//

#import "EpisodesLoader.h"
#import	"Constants.h"
#import "GetAllEpisodes.pb.h"

@interface EpisodesLoader () <ProtocolBuffersFetcherDelegate>

@property (nonatomic, retain) NSArray *episodes;

@end


@implementation EpisodesLoader

@synthesize delegate, episodes;

- (void)loadAllEpisodesForSeries:(NSString *)seriesId {
	self.episodes = nil;
	[self.fetcher sendProtocolBuffersRequestWithURLString:[NSString stringWithFormat:@"%@/getAllEpisodes?id=%@", ServerURL, seriesId] delegate:self];
}

#pragma mark ProtocolBuffersFetcherDelegate

- (void)processData:(NSData *)newData {
	self.episodes = [GetAllEpisodesResponse parseFromData:newData].episodesList;
	[self.delegate loadedEpisodes:self.episodes];
}

- (void)connectionFailed {
	self.episodes = nil;
}

#pragma mark -

- (void)dealloc {
	self.episodes = nil;
	[super dealloc];
}

@end
