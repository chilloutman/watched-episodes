//
//  HTTPFetcher.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 6/28/11.
//  Copyright 2011 Lucas Neiva. All rights reserved.
//

#import "ProtocolBuffersFetcher.h"


@interface ProtocolBuffersFetcher ()

@property (nonatomic, retain) NSURLConnection *connection;
@property (nonatomic, retain) NSMutableData *receivedData;
@property (nonatomic, assign) id<ProtocolBuffersFetcherDelegate> delegate;

- (NSURLRequest *)protocolBuffersRequestWithURL:(NSURL *)URL;

@end


@implementation ProtocolBuffersFetcher

@synthesize connection, receivedData, delegate;

- (void)sendProtocolBuffersRequestWithURLString:(NSString *)URL delegate:(id<ProtocolBuffersFetcherDelegate>)d {
	self.delegate = d;
#ifdef FAKEDATA
    URL = [URL stringByAppendingString:@"&debug"];
#endif
	NSURLRequest *request = [self protocolBuffersRequestWithURL:[NSURL URLWithString:URL]];
	self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
}

- (NSURLRequest *)protocolBuffersRequestWithURL:(NSURL *)URL {
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
	[request setHTTPMethod:@"GET"];
	[request addValue:@"application/x-protobuf" forHTTPHeaderField:@"Accept"];
	return request;
}

- (void)cancelConnection {
	self.delegate = nil;
	self.connection = nil;
	self.receivedData = nil;
}

#pragma mark NSURLConnection

- (void)connection:(NSURLConnection *)c didReceiveResponse:(NSHTTPURLResponse *)response {
	long long contentLength = [response expectedContentLength];
	self.receivedData = (contentLength == NSURLResponseUnknownLength) ? [NSMutableData data] : [NSMutableData dataWithCapacity:contentLength];	
}

- (void)connection:(NSURLConnection *)aConnection didReceiveData:(NSData *)newData {
	[self.receivedData appendData:newData];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)aConnection {
	[self.delegate processData:self.receivedData];
	[self cancelConnection];
}

- (void)connection:(NSURLConnection *)aConnection didFailWithError:(NSError *)error {
	// TODO: handle error
	[self cancelConnection];
}

#pragma mark -

- (void)dealloc {
	self.connection = nil;
	self.receivedData = nil;
	[super dealloc];
}

@end
