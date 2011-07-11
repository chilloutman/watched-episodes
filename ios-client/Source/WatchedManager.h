//
//  WatchedManager.h
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 7/4/11.
//  Copyright 2011 Lucas Neiva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProtocolTypes.pb.h"

@interface WatchedManager : NSObject

- (void)markEpisodeAsWatched:(PBEpisode *)episode;
- (BOOL)isEpisodeMarkedAsWatched:(PBEpisode *)episode;
- (NSUInteger)numberOfUnwatchedEpisodesForSeries:(PBSeries *)series;

@end
