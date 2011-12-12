//
//  FilePathHelper.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/27/11.
//  Copyright 2011 Lucas Neiva. All rights reserved.
//

#import "FileHelper.h"


@interface FileHelper ()

+ (NSString *)pathForDirectory:(NSString *)directoryName insearchPathDirectory:(NSSearchPathDirectory)searchPathDirectory;
+ (NSString *)specialDirectoryPath:(NSSearchPathDirectory)searchPathDirectory;

@end


@implementation FileHelper

+ (NSURL *)URLForDocumentNamed:(NSString *)documentName {
	NSString *filePath = [[self specialDirectoryPath:NSDocumentDirectory] stringByAppendingPathComponent:documentName];	
	return [NSURL fileURLWithPath:filePath isDirectory:NO];
}

+ (NSString *)documentDirectoryNamed:(NSString *)directoryName {
	return [FileHelper pathForDirectory:directoryName insearchPathDirectory:NSDocumentDirectory];
}

+ (NSString *)cachesDirectoryNamed:(NSString *)directoryName {
	return [FileHelper pathForDirectory:directoryName insearchPathDirectory:NSCachesDirectory];
}

+ (NSString *)pathForDirectory:(NSString *)directoryName insearchPathDirectory:(NSSearchPathDirectory)searchPathDirectory {
	NSString *directoryPath = [[self specialDirectoryPath:searchPathDirectory] stringByAppendingPathComponent:directoryName];
	return ([FileHelper createDirectoryAtPath:directoryPath]) ? directoryPath : nil;
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
