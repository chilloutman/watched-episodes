//
//  Constants.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TargetConditionals.h"

#if TARGET_IPHONE_SIMULATOR
NSString * const ServerURL= @"http://localhost:8080";
#else
NSString * const ServerURL= @"http://watched-episodes.appspot.com";
#endif