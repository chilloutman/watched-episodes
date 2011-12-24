
//
//  HTTPFetcher.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 6/28/11.
//  Copyright 2011 Lucas Neiva. All rights reserved.
//

#import "HTTPFetcher.h"
#import "ServiceLocator.h"
#import "CommunicationManager.h"


@interface HTTPFetcher ()

@property (nonatomic, retain) NSOperationQueue *queue;

- (HTTPOperation *)alreadyQueuedOperationForURL:(NSURL *)URL;

@end


@implementation HTTPFetcher

@synthesize queue;

+ (HTTPFetcher *)shared {
	return [ServiceLocator singletonForClass:[HTTPFetcher class]];
}

- (NSOperationQueue *)queue {
	if (!queue) {
		queue = [[NSOperationQueue alloc] init];
		queue.maxConcurrentOperationCount = 3;
	}
	return queue;
}

- (HTTPOperation *)sendHTTPRequestWithURLString:(NSString *)URLString taker:(id)takerObject completionBlock:(HTTPOperationBlock)block {
#ifdef FAKEDATA
	URLString = [URL stringByAppendingString:@"&debug"];
#endif
	
	NSURL *URL = [NSURL URLWithString:URLString];
	HTTPOperation *operation = [self alreadyQueuedOperationForURL:URL];
	if (operation) {
		[operation addCompletitionBlock:block];
	} else {
		operation = [HTTPOperation operationWithURL:URL taker:takerObject completitionBlock:block];
		[self.queue addOperation:operation];
	}
	
	return operation;

}

- (HTTPOperation *)alreadyQueuedOperationForURL:(NSURL *)URL {
	HTTPOperation *operation = nil;
	for (HTTPOperation *o in self.queue.operations) {
		if ([o.URL isEqual:URL]) {
			operation = o;
		}
	}
	return operation;
}

- (void)cancelAllRequestsForTaker:(id)takerObject {
	for (HTTPOperation *o in self.queue.operations) {
		if (o.takerObject == takerObject) {
			[o cancel];
		}
	}
}

#pragma mark -

- (void)dealloc {
	self.queue = nil;
	[super dealloc];
}

@end
