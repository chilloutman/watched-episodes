//
//  HTTPOperationResult.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 12/24/11.
//  Copyright (c) 2011 Lucas Neiva. All rights reserved.
//

#import "HTTPOperationResult.h"


@implementation HTTPOperationResult

@synthesize receivedData;

+ (HTTPOperationResult *)operationResult {
	return [[HTTPOperationResult alloc] init];
}

@end
