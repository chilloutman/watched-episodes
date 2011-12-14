//
//  ServiceLocator.h
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/9/11.
//  Copyright 2011 Lucas Neiva. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServiceLocator : NSObject

+ (id)singletonForClass:(Class)serviceClass;

@end
