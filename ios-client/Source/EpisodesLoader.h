//
//  EpisodesLoader.h
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 3/17/11.
//  Copyright 2011 Lucas Neiva Informatik AG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProtocolTypes.pb.h"
#import "AbstractLoader.h"


typedef void (^EpisodesBlock) (NSArray *episodes);


@interface EpisodesLoader : AbstractLoader

- (void)loadAllEpisodesForSeries:(NSString *)seriesId completionBlock:(EpisodesBlock)block;

@end