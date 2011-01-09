//
//  CommunicationManagerDelegate.h
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 10/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol CommunicationDelegate

- (void)requestDidSuccedWithURL:(NSURL *)url response:(NSData *)response;
- (void)requestDidFailWithURL:(NSURL *)url;

@end