//
//  EpisodesModel.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 7/19/11.
//  Copyright 2011 Lucas Neiva. All rights reserved.
//

#import "EpisodesDataProvider.h"


@interface EpisodesDataProvider ()

@property (nonatomic, retain) NSArray *allEpisodes;
@property (nonatomic, retain) NSDictionary *seasonsDictionary;

- (NSDictionary *)seasonsDictionaryForEpisodes:(NSArray *)episodesArray;

@end


@implementation EpisodesDataProvider

@synthesize allEpisodes, seasonsDictionary;

+ (EpisodesDataProvider *)providerWithEpisodes:(NSArray *)episodes {
    return [[[EpisodesDataProvider alloc] initWithEpisodes:episodes] autorelease];
}

- (id)initWithEpisodes:(NSArray *)episodes {
    self = [super init];
    if (self != nil) {
        self.allEpisodes = episodes;
        self.seasonsDictionary = [self seasonsDictionaryForEpisodes:episodes];
    }
    return self;
}

- (NSDictionary *)seasonsDictionaryForEpisodes:(NSArray *)episodesArray {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    for (PBEpisode *episode in episodesArray) {
        NSMutableArray *episodes = [dictionary objectForKey:episode.seasonString];
        if (episodes == nil) {
            [dictionary setObject:[NSMutableArray arrayWithObject:episode] forKey:episode.seasonString];
        } else {
            [episodes addObject:episode];
        }
    }
    return dictionary;
}

- (NSUInteger)numberOfEpisodes {
    return self.allEpisodes.count;
}

- (NSUInteger)numberOfseasons {
    return [self.seasonsDictionary count];
}

- (NSUInteger)numberOfEpisodesForSeason:(NSUInteger)seasonNumber {
    return [[self episodesForSeason:seasonNumber] count];
}

- (NSArray *)episodesForSeason:(NSUInteger)seasonNumber {
    NSString *seasonString = [NSString stringWithFormat:@"%d", seasonNumber];
    return [self.seasonsDictionary objectForKey:seasonString];
}

- (void)dealloc {
    self.allEpisodes = nil;
    self.seasonsDictionary = nil;
    [super dealloc];
}

@end
