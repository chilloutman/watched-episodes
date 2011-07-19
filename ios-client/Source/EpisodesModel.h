//
//  EpisodesModel.h
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 7/19/11.
//  Copyright 2011 Lucas Neiva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EpisodesLoader.h"

@interface EpisodesModel : NSObject

+ (EpisodesModel *)modelWithEpisodes:(NSArray *)episodes;
- (id)initWithEpisodes:(NSArray *)episodes;

- (NSUInteger)numberOfEpisodes;
- (NSUInteger)numberOfseasons;
- (NSUInteger)numberOfEpisodesForSeason:(NSUInteger)seasonNumber;
- (NSArray *)episodesForSeason:(NSUInteger)seasonNumber;

@end
