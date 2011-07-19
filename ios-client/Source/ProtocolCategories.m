//
//  ProtocolCategories.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 7/19/11.
//  Copyright 2011 Lucas Neiva. All rights reserved.
//

#import "ProtocolCategories.h"


@implementation PBEpisode (StringGetters)

- (NSString *)seasonString {
    return [NSString stringWithFormat:@"%d", self.seasonNumber];
}

- (NSString *)episodeNumberString {
    return [NSString stringWithFormat:@"%d", self.episodeNumber];
}

@end