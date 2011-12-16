//
//  FileCache.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 12/15/11.
//  Copyright (c) 2011 Lucas Neiva. All rights reserved.
//

#import "FileCache.h"
#import "Files.h"


@interface FileCache ()

@property (nonatomic, copy) NSString *directoyPath;

- (NSString *)filePathForKey:(NSString *)key;

@end


@implementation FileCache

@synthesize directoyPath;

+ (FileCache *)fileCacheWithDirectoryName:(NSString *)cacheDirectoryName {
	FileCache *cache = [[FileCache alloc] init];
	cache.directoyPath = [Files cachesDirectoryNamed:cacheDirectoryName]; 
	return [cache autorelease];
}

- (void)cacheData:(NSData *)data forKey:(NSString *)key {
	[[NSFileManager defaultManager] createFileAtPath:[self filePathForKey:key] contents:data attributes:nil];
}

- (NSData *)loadDataForKey:(NSString *)key {
	NSData *data = nil;
	if ([[NSFileManager defaultManager] isReadableFileAtPath:[self filePathForKey:key]]) {
		data = [NSData dataWithContentsOfFile:[self filePathForKey:key]];
	}
	return data;
}

- (NSString *)filePathForKey:(NSString *)key {
	return [[self.directoyPath stringByAppendingPathComponent:key] stringByAppendingPathExtension:@"cache"];
}

@end
