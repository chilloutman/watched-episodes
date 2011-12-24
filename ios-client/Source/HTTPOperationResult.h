//
//  HTTPOperationResult.h
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 12/24/11.
//  Copyright (c) 2011 Lucas Neiva. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HTTPOperationResult : NSObject

@property (nonatomic, retain) NSMutableData *receivedData;

+ (HTTPOperationResult *)operationResult;

@end
