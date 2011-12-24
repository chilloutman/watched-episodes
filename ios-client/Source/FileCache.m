//
//  FileCache.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 12/15/11.
//  Copyright (c) 2011 Lucas Neiva. All rights reserved.
//

#import "FileCache.h"
#import "Files.h"
#import "ServiceLocator.h"


@interface FileCache ()

@property (nonatomic, copy) NSString *directoyPath;
@property (nonatomic, retain) NSMutableDictionary *cache;

- (NSString *)filePathForKey:(NSString *)key;

@end


@implementation FileCache

@synthesize directoyPath, cache;

+ (FileCache *)sharedCacheWithDirectoryName:(NSString *)cacheDirectoryName {
	FileCache *sharedCache = [ServiceLocator singletonForKey:cacheDirectoryName];
	if (!sharedCache) {
		sharedCache = [FileCache fileCacheWithDirectoryName:cacheDirectoryName];
		[ServiceLocator registerSingletonInstance:sharedCache forKey:cacheDirectoryName];
	}
	return sharedCache;
}

+ (FileCache *)fileCacheWithDirectoryName:(NSString *)cacheDirectoryName {
	FileCache *cache = [[FileCache alloc] init];
	cache.directoyPath = [Files cachesDirectoryNamed:cacheDirectoryName];
	cache.cache = [NSMutableDictionary dictionary];
	return [cache autorelease];
}

- (id)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidReceiveMemoryWarningNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^ (NSNotification *n) {
			self.cache = [NSMutableDictionary dictionary];
		}];
    }
    return self;
}

- (void)cacheData:(NSData *)data forKey:(NSString *)key {
	[self.cache setObject:data forKey:key];
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^ {
		if (![[NSFileManager defaultManager] createFileAtPath:[self filePathForKey:key] contents:data attributes:nil]) {
			NSLog(@"Could not create file at path %@", [self filePathForKey:key]);
		}
	});
}

- (NSData *)loadDataForKey:(NSString *)key {
	NSData *data = [self.cache objectForKey:key];
	
	if (!data && [[NSFileManager defaultManager] isReadableFileAtPath:[self filePathForKey:key]]) {
		data = [NSData dataWithContentsOfFile:[self filePathForKey:key]];
	}
	return data;
}

- (NSString *)filePathForKey:(NSString *)key {
	return [self.directoyPath stringByAppendingPathComponent:key];
}

- (void)dealloc {
	self.directoyPath = nil;
	self.cache = nil;
	[super dealloc];
}

@end
