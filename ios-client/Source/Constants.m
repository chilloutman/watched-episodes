//
//  Constants.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/9/11.
//  Copyright 2011 Lucas Neiva. All rights reserved.
//

#import "TargetConditionals.h"

#if TARGET_IPHONE_SIMULATOR
NSString * const ServerURL= @"http://localhost:8888"; // Local server started from Eclipse
#else
NSString * const ServerURL= @"http://wwatched-episodes.appspot.com"; // App Engine
#endif