//
//  AbstractLoader.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 6/28/11.
//  Copyright 2011 Lucas Neiva. All rights reserved.
//

#import "AbstractLoader.h"


@implementation AbstractLoader

@synthesize fetcher;

- (HTTPFetcher *)fetcher {
	if (fetcher == nil) {
		fetcher = [[HTTPFetcher alloc] init];
	}
	return fetcher;
}

- (void)cancelCurrentConnection {
	[self.fetcher cancelConnection];
}

- (void)dealloc {
	self.fetcher = nil;
}

@end
