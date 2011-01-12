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

NSUInteger numberOfRunningRequests;

- (void)hitServer:(Request *)request;
- (void)requestStarted;
- (void)requestFinished;

@end


@implementation CommunicationAgent

- (void)sendRequestWithURL:(NSURL *)url delegate:(id<CommunicationDelegate>)delegate {	
	dispatch_queue_t q= dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
	dispatch_async(q, ^ {
		Request *request= [[Request alloc] initWithURL:url delegate:delegate];
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