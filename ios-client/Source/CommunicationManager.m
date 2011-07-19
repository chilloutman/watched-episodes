//
//  CommunicationManager.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 7/19/11.
//  Copyright 2011 Lucas Neiva. All rights reserved.
//

#import "CommunicationManager.h"
#import "MessagePopupView.h"

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

- (void)displayErrorMessageForStatusCode:(NSInteger)statusCode {
    MessagePopupView *popupView = [MessagePopupView messagePopupView];
    popupView.messageLabel.text = [NSString stringWithFormat:@"Could not connect to server. (%d)", statusCode];
    [popupView show];
}

@end
