//
//  WatchedManager.h
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 7/4/11.
//  Copyright 2011 Lucas Neiva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProtocolTypes.pb.h"

extern NSString * const WatchedManagerDidFinishLoadingNotification; // Posted when the WatchedManager is done loading the watched state.

@interface WatchedManager : NSObject

+ (WatchedManager *)shared;

- (void)loadLastWatchedEpisodesWithCompletionBlock:(void (^) ())handler;
- (void)save;
- (void)closeDocument;

- (void)setLastWatchedEpisode:(PBEpisode *)episode;
- (void)setLastWatchedEpisodeNumber:(NSUInteger)number forSeries:(NSString *)seriesId;
- (void)setLastWatchedEpisodeSeasonNumber:(NSUInteger)number forSeries:(NSString *)seriesId;

- (BOOL)isEpisodeMarkedAsWatched:(PBEpisode *)episode;
- (NSUInteger)lastWatchedEpisodeNumberForSeriesId:(NSString *)seriesId;
- (NSUInteger)lastWatchedEpisodeSeasonNumberForSeriesId:(NSString *)seriesId;

@end
