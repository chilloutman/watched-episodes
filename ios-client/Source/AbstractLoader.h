//
//  AbstractLoader.h
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 6/28/11.
//  Copyright 2011 Lucas Neiva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProtocolBuffersFetcher.h"


@interface AbstractLoader : NSObject {
    ProtocolBuffersFetcher *fetcher;
}

@property (nonatomic, retain) ProtocolBuffersFetcher *fetcher;

- (void)cancelCurrentConnection;

@end
