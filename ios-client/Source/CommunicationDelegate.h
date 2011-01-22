//
//  CommunicationManagerDelegate.h
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 10/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol CommunicationDelegate

- (void)requestDidSucceed:(id <NSObject>)requestId; // Gets called from main thread
- (void)requestDidFail:(id <NSObject>)requestId; // Gets called from main thread
- (void)receivedResponse:(NSData *)responseData requestId:(id <NSObject>)requestId; // Gets called from background thread

@end