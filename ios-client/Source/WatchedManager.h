//
//  WatchedManager.h
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 7/4/11.
//  Copyright 2011 Lucas Neiva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProtocolTypes.pb.h"


extern NSString * const WatchedManagerDidFinishLoadingNotification; // Posted when the WatchedManager updated the watched episodes.


@interface WatchedEpisode : NSObject

+ (WatchedEpisode *)episodeWithSeriesId:(NSString *)seriesId episodeNumber:(NSUInteger)episodeNumber seasonNumber:(NSUInteger)seasonNumber;

@property (nonatomic, copy) NSString *seriesId;
@property (nonatomic, assign) NSUInteger seasonNumber;
@property (nonatomic, assign) NSUInteger episodeNumber;
@property (nonatomic, readonly) BOOL isZero;

@end


@interface WatchedManager : NSObject

+ (WatchedManager *)shared;

- (void)loadLastWatchedEpisodesWithCompletionBlock:(void (^) ())block;
- (void)save;
- (void)closeDocument;

- (void)setLastWatchedEpisode:(WatchedEpisode *)episode;
- (WatchedEpisode *)lastWatchedEpisodeForSeriesId:(NSString *)seriesId;
- (BOOL)isEpisodeMarkedAsWatched:(PBEpisode *)episode;

@end
