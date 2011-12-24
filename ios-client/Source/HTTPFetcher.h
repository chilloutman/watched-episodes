//
//  HTTPFetcher.h
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 6/28/11.
//  Copyright 2011 Lucas Neiva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTTPOperation.h"


@interface HTTPFetcher : NSObject

+ (HTTPFetcher *)shared;
- (HTTPOperation *)sendHTTPRequestWithURLString:(NSString *)URLString taker:(id)takerObject completionBlock:(HTTPOperationBlock)block;
- (void)cancelAllRequestsForTaker:(id)takerObject;

@end
