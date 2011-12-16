//
//  AbstractLoader.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 6/28/11.
//  Copyright 2011 Lucas Neiva. All rights reserved.
//

#import "AbstractLoader.h"
#import "HTTPFetcher.h"
#import "FileCache.h"

@implementation AbstractLoader

@synthesize fetcher, cache, cacheDirectoryPath;

- (HTTPFetcher *)fetcher {
	if (!fetcher) {
		fetcher = [[HTTPFetcher alloc] init];
	}
	return fetcher;
}

- (FileCache *)cache {
	if (!cache) {
		self.cache = [FileCache fileCacheWithDirectoryName:self.cacheDirectoryPath];
	}
	return cache;
}

- (void)cancelCurrentConnection {
	[self.fetcher cancelConnection];
}

- (void)dealloc {
	self.fetcher = nil;
	self.cache = nil;
}

@end
