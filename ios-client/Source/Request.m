//
//  CBServerCall.m
//  CoreBanking
//
//  Created by Lucas Neiva on 12/15/10.
//  Copyright 2010 Ergon Informatik AG. All rights reserved.
//

#import "Request.h"


@interface Request ()

@property (nonatomic, assign) id<CommunicationDelegate> delegate;
@property (nonatomic, retain) NSURL *url;

- (NSURLRequest *)createGETRequest;
- (BOOL)checkResponse:(NSHTTPURLResponse *)response;
- (void)handleHTTPError:(NSInteger)errorCode;
- (void)requestSucceded:(NSData *)data;
- (void)requestFailed;

@end


@implementation Request

@synthesize url, delegate, protobuf, requestId;

- (id)initWithURL:(NSURL *)u delegate:(id<CommunicationDelegate>)d {
	if ((self = [super init]) != nil) {
		self.url= u;
		self.delegate= d;
	}
	return self;
}

- (void)excecute {
	NSHTTPURLResponse *response;
	NSData *data= [NSURLConnection sendSynchronousRequest:[self createGETRequest] returningResponse:&response error:NULL];
	
	if ([self checkResponse:response]) {
		[self requestSucceded:data];
	} else {
		[self requestFailed];
	}
}

- (NSURLRequest *)createGETRequest {
	NSMutableURLRequest *request= [NSMutableURLRequest requestWithURL:self.url];
	[request setHTTPMethod:@"GET"];
	[request setTimeoutInterval:30];
	if (self.protobuf) {
		[request addValue:@"application/x-protobuf" forHTTPHeaderField:@"Accept"];
	}
	return request;
}

- (BOOL)checkResponse:(NSHTTPURLResponse *)response {
	if ([response statusCode] == 200) {
		return YES;
	} else {
		[self handleHTTPError:[response statusCode]];
		return NO;
	}
}

- (void)handleHTTPError:(NSInteger)errorCode {
	// TODO
}

- (void)requestSucceded:(NSData *)data {
	[self.delegate receivedResponse:data requestId:self.requestId];
	dispatch_async(dispatch_get_main_queue(), ^ {
		[self.delegate requestDidSucceed:self.requestId];
	});
}

- (void)requestFailed {
	dispatch_async(dispatch_get_main_queue(), ^ {
		[self.delegate requestDidFail:self.requestId];
	});
}

#pragma mark -

- (void)dealloc {
	self.delegate= nil;
	self.url= nil;
	[super dealloc];
}

@end