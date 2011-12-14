//
//  Files.h
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/27/11.
//  Copyright 2011 Lucas Neiva. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Files : NSObject

+ (NSURL *)URLForDocumentNamed:(NSString *)documentName;
+ (NSString *)documentDirectoryNamed:(NSString *)directoryName;
+ (NSString *)cachesDirectoryNamed:(NSString *)directoryName;
+ (BOOL)fileExistsAtPath:(NSString *)path;
+ (BOOL)createDirectoryAtPath:(NSString *)path;

@end
