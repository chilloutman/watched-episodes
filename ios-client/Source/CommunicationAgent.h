//
//  CommunicationAgent.h
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 10/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommunicationDelegate.h"


@interface CommunicationAgent : NSObject {
	NSUInteger numberOfRunningRequests;
}

- (void)sendGETRequestWithURL:(NSURL *)url delegate:(id<CommunicationDelegate>)delegate;
- (void)sendProtocolBuffersGETRequestWithURL:(NSURL *)url delegate:(id<CommunicationDelegate>)delegate;

- (void)sendGETRequestWithURL:(NSURL *)url requestId:(id<NSObject>)requestId delegate:(id<CommunicationDelegate>)delegate;
- (void)sendProtocolBuffersGETRequestWithURL:(NSURL *)url requestId:(id<NSObject>)requestId delegate:(id<CommunicationDelegate>)delegate;

@end
