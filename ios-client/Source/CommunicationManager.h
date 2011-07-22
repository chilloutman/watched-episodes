//
//  CommunicationManager.h
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 7/19/11.
//  Copyright 2011 Lucas Neiva. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommunicationManager : NSObject

+ (CommunicationManager *)shared;

- (void)startedConnection;
- (void)finnishedConnection;

- (void)displayErrorMessageForStatusCode:(NSInteger)statusCode;

@end
