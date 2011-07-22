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

+ (WatchedManager *)shared;
- (void)markEpisodeAsWatched:(PBEpisode *)episode;
- (BOOL)isEpisodeMarkedAsWatched:(PBEpisode *)episode;
- (void)loadWatchedStateForSeries:(NSString *)seriesId withCompletionHandler:(void (^) ())handler;
- (NSUInteger)numberOfUnwatchedEpisodesForSeries:(PBSeries *)series;

@end
