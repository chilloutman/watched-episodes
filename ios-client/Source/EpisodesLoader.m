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


@implementation EpisodesLoader

- (void)loadAllEpisodesForSeries:(NSString *)seriesId completionBlock:(EpisodesBlock)block {
	[self.fetcher sendProtocolBuffersRequestWithURLString:[NSString stringWithFormat:@"%@/getAllEpisodes?id=%@", ServerURL, seriesId] completionBlock:^ (NSData *data) {
		NSArray *episodes = [GetAllEpisodesResponse parseFromData:data].episodesList;
		block(episodes);
	}];
}

@end
