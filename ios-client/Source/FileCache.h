//
//  FileCache.h
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 12/15/11.
//  Copyright (c) 2011 Lucas Neiva. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileCache : NSObject

+ (FileCache *)sharedCacheWithDirectoryName:(NSString *)cacheDirectoryName;
+ (FileCache *)fileCacheWithDirectoryName:(NSString *)cacheDirectoryName;

- (void)cacheData:(NSData *)data forKey:(NSString *)key;
- (NSData *)loadDataForKey:(NSString *)key;

@end
