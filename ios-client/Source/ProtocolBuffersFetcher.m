//
//  HTTPFetcher.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 6/28/11.
//  Copyright 2011 Lucas Neiva. All rights reserved.
//

#import "ProtocolBuffersFetcher.h"
#import "CommunicationManager.h"


@interface ProtocolBuffersFetcher ()

@property (nonatomic, retain) NSURLConnection *connection;
@property (nonatomic, retain) NSMutableData *receivedData;
@property (nonatomic, assign) id<ProtocolBuffersFetcherDelegate> delegate;
@property (nonatomic, copy) DataBlock completionBlock;

- (void)sendRequestWithURLString:(NSString *)URL;
- (NSURLRequest *)protocolBuffersRequestWithURL:(NSURL *)URL;

@end


@implementation ProtocolBuffersFetcher

@synthesize connection, receivedData, delegate, completionBlock;

- (void)sendProtocolBuffersRequestWithURLString:(NSString *)URL delegate:(id<ProtocolBuffersFetcherDelegate>)d {
	self.delegate = d;
	[self sendRequestWithURLString:URL];
}

- (void)sendProtocolBuffersRequestWithURLString:(NSString *)URL completionBlock:(DataBlock)block {
	self.completionBlock = block;
	[self sendRequestWithURLString:URL];
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
    [self.connection cancel];
	self.delegate = nil;
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
        [[CommunicationManager shared] finnishedConnection];
        [[CommunicationManager shared] displayErrorMessageForStatusCode:response.statusCode];
        [self cancelConnection];
    }
}

- (void)connection:(NSURLConnection *)aConnection didReceiveData:(NSData *)newData {
	[self.receivedData appendData:newData];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)aConnection {
	if (delegate) {
		[self.delegate processData:self.receivedData];
	} else {
		self.completionBlock(self.receivedData);
	}
	[self cancelConnection];
    [[CommunicationManager shared] finnishedConnection];
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
