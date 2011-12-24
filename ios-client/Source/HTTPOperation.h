//
//  HTTPOperation.h
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 12/23/11.
//  Copyright (c) 2011 Lucas Neiva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTTPOperationResult.h"


typedef void (^HTTPOperationBlock) (HTTPOperationResult *finishedOperation);


@interface HTTPOperation : NSOperation

@property (nonatomic, copy) NSURL *URL;
@property (nonatomic, assign) id takerObject;

+ (HTTPOperation *)operationWithURL:(NSURL *)URL taker:(id)takerObject completitionBlock:(HTTPOperationBlock)block;
- (void)addCompletitionBlock:(HTTPOperationBlock)block;

@end
