//
//  HTTPFetcher.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 6/28/11.
//  Copyright 2011 Lucas Neiva. All rights reserved.
//

#import "HTTPFetcher.h"
#import "CommunicationManager.h"


@interface HTTPFetcher ()

@property (nonatomic, retain) NSURLConnection *connection;
@property (nonatomic, retain) NSMutableData *receivedData;
@property (nonatomic, copy) DataBlock completionBlock;

- (void)sendRequestWithURLString:(NSString *)URL;
- (NSURLRequest *)protocolBuffersRequestWithURL:(NSURL *)URL;
- (void)reset;

@end


@implementation HTTPFetcher

@synthesize connection, receivedData, completionBlock;

- (void)sendHTTPRequestWithURLString:(NSString *)URL completionBlock:(DataBlock)block {
	dispatch_async(dispatch_get_main_queue(), ^ {
		self.completionBlock = block;
		[self sendRequestWithURLString:URL];
	});
}

- (void)sendRequestWithURLString:(NSString *)URL {
#ifdef FAKEDATA
    URL = [URL stringByAppendingString:@"&debug"];
#endif
	NSURLRequest *request = [self protocolBuffersRequestWithURL:[NSURL URLWithString:URL]];
	self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
	[[CommunicationManager shared] startedConnection];
}

- (NSURLRequest *)protocolBuffersRequestWithURL:(NSURL *)URL {
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
	[request setHTTPMethod:@"GET"];
	[request addValue:@"application/x-protobuf" forHTTPHeaderField:@"Accept"];
	return request;
}

- (void)cancelConnection {
	if (self.connection) {
		[[CommunicationManager shared] finnishedConnection];
		[self.connection cancel];
		[self reset];
	}
}

- (void)reset {
	self.completionBlock = nil;
	self.connection = nil;
	self.receivedData = nil;
}

#pragma mark NSURLConnection

- (void)connection:(NSURLConnection *)c didReceiveResponse:(NSHTTPURLResponse *)response {
    if (response.statusCode == 200) {
        long long contentLength = [response expectedContentLength];
        self.receivedData = (contentLength == NSURLResponseUnknownLength) ? [NSMutableData data] : [NSMutableData dataWithCapacity:contentLength];
    } else {
		[[CommunicationManager shared] displayErrorMessageForStatusCode:response.statusCode];
		[self cancelConnection];
    }
}

- (void)connection:(NSURLConnection *)aConnection didReceiveData:(NSData *)newData {
	[self.receivedData appendData:newData];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)aConnection {
	if (self.completionBlock) {
		self.completionBlock(self.receivedData);
	}
	[self cancelConnection];
}

- (void)connection:(NSURLConnection *)aConnection didFailWithError:(NSError *)error {
	[[CommunicationManager shared] displayErrorMessageForStatusCode:error.code];
	[self cancelConnection];
}

#pragma mark -

- (void)dealloc {
	self.connection = nil;
	self.receivedData = nil;
	self.completionBlock = nil;
	[super dealloc];
}

@end
