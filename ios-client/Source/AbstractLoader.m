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


@interface AbstractLoader ()

@end


@implementation AbstractLoader

@synthesize cache, cacheDirectoryPath;

- (FileCache *)cache {
	if (!cache) {
		self.cache = [FileCache fileCacheWithDirectoryName:self.cacheDirectoryPath];
	}
	return cache;
}

- (void)sendHTTPRequestWithURLString:(NSString *)URLString completionBlock:(DataBlock)dataBlock {
	[[HTTPFetcher shared] sendHTTPRequestWithURLString:URLString taker:self completionBlock:^ (HTTPOperationResult *result) {
		dataBlock(result.receivedData);
	}];
}

- (void)cancel {
	[[HTTPFetcher shared] cancelAllRequestsForTaker:self];
}

- (void)dealloc {
    [super dealloc];
	self.cache = nil;
}

@end
