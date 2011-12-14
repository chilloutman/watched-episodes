//
//  AbstractLoader.h
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 6/28/11.
//  Copyright 2011 Lucas Neiva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTTPFetcher.h"


@interface AbstractLoader : NSObject

@property (nonatomic, retain) HTTPFetcher *fetcher;

- (void)cancelCurrentConnection;

@end
