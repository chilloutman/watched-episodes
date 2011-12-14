//
//  Files.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/27/11.
//  Copyright 2011 Lucas Neiva. All rights reserved.
//

#import "Files.h"


@interface Files ()

+ (NSString *)pathForDirectory:(NSString *)directoryName insearchPathDirectory:(NSSearchPathDirectory)searchPathDirectory;
+ (NSString *)specialDirectoryPath:(NSSearchPathDirectory)searchPathDirectory;

@end


@implementation Files

+ (NSURL *)URLForDocumentNamed:(NSString *)documentName {
	NSString *filePath = [[self specialDirectoryPath:NSDocumentDirectory] stringByAppendingPathComponent:documentName];	
	return [NSURL fileURLWithPath:filePath isDirectory:NO];
}

+ (NSString *)documentDirectoryNamed:(NSString *)directoryName {
	return [Files pathForDirectory:directoryName insearchPathDirectory:NSDocumentDirectory];
}

+ (NSString *)cachesDirectoryNamed:(NSString *)directoryName {
	return [Files pathForDirectory:directoryName insearchPathDirectory:NSCachesDirectory];
}

+ (NSString *)pathForDirectory:(NSString *)directoryName insearchPathDirectory:(NSSearchPathDirectory)searchPathDirectory {
	NSString *directoryPath = [[self specialDirectoryPath:searchPathDirectory] stringByAppendingPathComponent:directoryName];
	return ([Files createDirectoryAtPath:directoryPath]) ? directoryPath : nil;
}

+ (NSString *)specialDirectoryPath:(NSSearchPathDirectory)searchPathDirectory {
	return [NSSearchPathForDirectoriesInDomains(searchPathDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

+ (BOOL)fileExistsAtPath:(NSString *)path {
	return [[NSFileManager defaultManager] fileExistsAtPath:path];
}

+ (BOOL)createDirectoryAtPath:(NSString *)path {
	return [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
}

@end
