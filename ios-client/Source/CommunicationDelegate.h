//
//  CommunicationManagerDelegate.h
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 10/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol CommunicationDelegate

- (void)requestDidSuccedWithURL:(NSURL *)url; // Gets called from main thread
- (void)requestDidFailWithURL:(NSURL *)url; // Gets called from main thread
- (void)receivedResponse:(NSData *)responseData; // Gets called from background thread

@end