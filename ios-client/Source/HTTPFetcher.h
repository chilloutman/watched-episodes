//
//  HTTPFetcher.h
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 6/28/11.
//  Copyright 2011 Lucas Neiva. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^DataBlock) (NSData *dataOrNil);


@interface HTTPFetcher : NSObject

- (void)sendHTTPRequestWithURLString:(NSString *)URL completionBlock:(DataBlock)block;

- (void)cancelConnection;

@end
