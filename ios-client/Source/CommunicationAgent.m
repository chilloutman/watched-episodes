//
//  CommunicationAgent.m
//  finibank.app
//
//  Created by Lucas Neiva on 10/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CommunicationAgent.h"
#import "Request.h"


@interface CommunicationAgent ()

- (void)dispatchRequest:(Request *)request;
- (void)hitServer:(Request *)request;
- (void)requestStarted;
- (void)requestFinished;

@end


@implementation CommunicationAgent

- (void)sendGETRequestWithURL:(NSURL *)url delegate:(id<CommunicationDelegate>)delegate {
	[self sendGETRequestWithURL:url requestId:nil delegate:delegate];
}

- (void)sendProtocolBuffersGETRequestWithURL:(NSURL *)url delegate:(id<CommunicationDelegate>)delegate {
	[self sendProtocolBuffersGETRequestWithURL:url requestId:nil delegate:delegate];
}

- (void)sendGETRequestWithURL:(NSURL *)url requestId:(id<NSObject>)requestId delegate:(id<CommunicationDelegate>)delegate {	
	Request *request= [[Request alloc] initWithURL:url delegate:delegate];
	request.requestId= requestId;
	[self dispatchRequest:request];
}

- (void)sendProtocolBuffersGETRequestWithURL:(NSURL *)url requestId:(id<NSObject>)requestId delegate:(id<CommunicationDelegate>)delegate {
	Request *request= [[Request alloc] initWithURL:url delegate:delegate];
	request.protobuf= YES;
	request.requestId= requestId;
	[self dispatchRequest:request];
}

- (void)dispatchRequest:(Request *)request {
	dispatch_queue_t q= dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
	dispatch_async(q, ^ {
		[self hitServer:request];
		[request release];
	});
}

- (void)hitServer:(Request *)request {
	dispatch_async(dispatch_get_main_queue(), ^ {
		[self requestStarted];
	});
	
	[request excecute];
	
	dispatch_async(dispatch_get_main_queue(), ^ {
		[self requestFinished];
	});
}

- (void)requestStarted {
	numberOfRunningRequests++;
	[UIApplication sharedApplication].networkActivityIndicatorVisible= YES;
}

- (void)requestFinished {
	numberOfRunningRequests--;
	if (numberOfRunningRequests == 0) {
		[UIApplication sharedApplication].networkActivityIndicatorVisible= NO;
	}
}

@end
