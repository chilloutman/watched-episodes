//
//  HTTPFetcher.h
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 6/28/11.
//  Copyright 2011 Lucas Neiva. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^DataBlock) (NSData *dataOrNil);


@protocol ProtocolBuffersFetcherDelegate

- (void)processData:(NSData *)newData;
- (void)connectionFailed;

@end


@interface HTTPFetcher : NSObject

- (void)sendHTTPRequestWithURLString:(NSString *)URL delegate:(id<ProtocolBuffersFetcherDelegate>)delegate;
- (void)sendHTTPRequestWithURLString:(NSString *)URL completionBlock:(DataBlock)block;

- (void)cancelConnection;

@end
