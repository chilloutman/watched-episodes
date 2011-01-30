//
//  FilePathHelper.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FileHelper.h"


@interface FileHelper ()

+ (NSString *)pathForDirectory:(NSString *)directoryName insearchPathDirectory:(NSSearchPathDirectory)searchPathDirectory;

@end


@implementation FileHelper

+ (NSString *)documentDirectoryNamed:(NSString *)directoryName {
	return [FileHelper pathForDirectory:directoryName insearchPathDirectory:NSDocumentDirectory];
}

+ (NSString *)cachesDirectoryNamed:(NSString *)directoryName {
	return [FileHelper pathForDirectory:directoryName insearchPathDirectory:NSCachesDirectory];
}

+ (NSString *)pathForDirectory:(NSString *)directoryName insearchPathDirectory:(NSSearchPathDirectory)searchPathDirectory {
	NSString *specialDirectory= [NSSearchPathForDirectoriesInDomains(searchPathDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	NSString *directoryPath= [specialDirectory stringByAppendingPathComponent:directoryName];
	return ([FileHelper createDirectoryAtPath:directoryPath]) ? directoryPath : nil;
}

+ (BOOL)createDirectoryAtPath:(NSString *)path {
	return [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
}

@end
