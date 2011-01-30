//
//  FilePathHelper.h
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FileHelper : NSObject

+ (NSString *)documentDirectoryNamed:(NSString *)directoryName;
+ (NSString *)cachesDirectoryNamed:(NSString *)directoryName;

+ (BOOL)createDirectoryAtPath:(NSString *)path;

@end
