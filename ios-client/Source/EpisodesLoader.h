//
//  EpisodesLoader.h
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 3/17/11.
//  Copyright 2011 Ergon Informatik AG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProtocolTypes.pb.h"


@protocol EpisodesLoaderDelegate
@required
- (void)loadedEpisodes:(NSArray *)loadedEpisodes;

@end


@interface EpisodesLoader : NSObject {
	id<EpisodesLoaderDelegate> delegate;
	NSArray *episodes;
}

@property (nonatomic, assign) id<EpisodesLoaderDelegate> delegate;

- (void)loadAllEpisodesForSeries:(NSString *)seriesId;

@end