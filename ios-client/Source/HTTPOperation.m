//
//  HTTPOperation.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 12/23/11.
//  Copyright (c) 2011 Lucas Neiva. All rights reserved.
//

#import "HTTPOperation.h"
#import "CommunicationManager.h"


@interface HTTPOperation ()

@property (nonatomic, retain) NSURLConnection *connection;
@property (nonatomic, retain) NSMutableSet *completionBlocks;
@property (nonatomic, retain) HTTPOperationResult *result;
@property (nonatomic, assign) BOOL isFinished;

- (NSURLRequest *)protocolBuffersRequestWithURL:(NSURL *)URL;
- (void)cancelConnection;

@end


@implementation HTTPOperation

@synthesize URL = URL_, takerObject, connection, result, completionBlocks;
@synthesize isFinished;

+ (HTTPOperation *)operationWithURL:(NSURL *)URL taker:(id)takerObject completitionBlock:(HTTPOperationBlock)block {
    HTTPOperation *operation = [[HTTPOperation alloc] init];
	operation.result = [HTTPOperationResult operationResult];
	operation.URL = URL;
	operation.takerObject = takerObject;
	operation.completionBlocks = [NSMutableSet setWithObject:[block copy]];
    return operation;
}

- (BOOL)isConcurrent {
	return YES;
}

- (BOOL)isExecuting {
	return self.connection != nil;
}

- (void)start {
	// Start the NSURLConnection on the main thread
	dispatch_async(dispatch_get_main_queue(), ^ {
		[self willChangeValueForKey:@"isExecuting"];
		self.connection = [NSURLConnection connectionWithRequest:[self protocolBuffersRequestWithURL:self.URL] delegate:self];
		[self didChangeValueForKey:@"isExecuting"];
		[[CommunicationManager shared] startedConnection];
	});
}

- (NSURLRequest *)protocolBuffersRequestWithURL:(NSURL *)URL {
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
	[request setHTTPMethod:@"GET"];
	[request addValue:@"application/x-protobuf" forHTTPHeaderField:@"Accept"];
	return request;
}

- (void)addCompletitionBlock:(HTTPOperationBlock)block {
	[self.completionBlocks addObject:[block copy]];
}

#pragma mark NSURLConnection

- (void)connection:(NSURLConnection *)c didReceiveResponse:(NSHTTPURLResponse *)response {
	if (self.isCancelled) {
		[self cancelConnection];
		return;
	}
    if (response.statusCode == 200) {
        long long contentLength = [response expectedContentLength];
        self.result.receivedData = (contentLength == NSURLResponseUnknownLength) ? [NSMutableData data] : [NSMutableData dataWithCapacity:contentLength];
    } else {
		[[CommunicationManager shared] displayErrorMessageForStatusCode:response.statusCode];
		[self cancelConnection];
    }
}

- (void)connection:(NSURLConnection *)aConnection didReceiveData:(NSData *)newData {
	if (self.isCancelled) {
		[self cancelConnection];
		return;
	}
	[self.result.receivedData appendData:newData];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)aConnection {
	if (self.isCancelled) {
		[self cancelConnection];
		return;
	}
	for (HTTPOperationBlock b in self.completionBlocks) {
		b(self.result);
	}
	[self cancelConnection];
}

- (void)connection:(NSURLConnection *)aConnection didFailWithError:(NSError *)error {
	if (self.isCancelled) {
		[self cancelConnection];
		return;
	}
	[[CommunicationManager shared] displayErrorMessageForStatusCode:error.code];
	[self cancelConnection];
}

- (void)cancelConnection {
	[self willChangeValueForKey:@"isExecuting"];
    [self willChangeValueForKey:@"isFinished"];
	
	[self.connection cancel];
	self.connection = nil;
	self.completionBlocks = nil;
	[[CommunicationManager shared] finnishedConnection];
	self.isFinished = YES;
	
	[self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
}

@end
