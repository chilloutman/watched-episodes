//
//  AbstractLoader.h
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 6/28/11.
//  Copyright 2011 Lucas Neiva. All rights reserved.
//

#import <Foundation/Foundation.h>


@class FileCache;


@interface AbstractLoader : NSObject

@property (nonatomic, retain) FileCache *cache;
@property (nonatomic, readonly) NSString *cacheDirectoryPath;

- (void)cancel;
- (void)sendHTTPRequestWithURLString:(NSString *)URLString completionBlock:(DataBlock)dataBlock;

@end
