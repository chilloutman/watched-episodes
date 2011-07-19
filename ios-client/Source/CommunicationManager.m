//
//  CommunicationManager.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 7/19/11.
//  Copyright 2011 Lucas Neiva. All rights reserved.
//

#import "CommunicationManager.h"

@implementation CommunicationManager {
    NSUInteger numberOfConnections;
}

- (void)startedConnection {
    numberOfConnections++;
    if (numberOfConnections > 0) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    }
}
                              
- (void)finnishedConnection {
    numberOfConnections--;
    if (numberOfConnections == 0) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }
}

@end
