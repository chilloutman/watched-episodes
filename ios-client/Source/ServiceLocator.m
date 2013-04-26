//
//  ServiceLocator.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/9/11.
//  Copyright 2011 Lucas Neiva. All rights reserved.
//

#import "ServiceLocator.h"
#import "SynthesizeSingleton.h"


@interface ServiceLocator ()

@property (nonatomic, retain) NSMutableDictionary *singletons;

@end


@implementation ServiceLocator

SYNTHESIZE_SINGLETON_FOR_CLASS(ServiceLocator)
@synthesize singletons;

+ (id)singletonForClass:(Class)serviceClass {
	id service = [ServiceLocator singletonForKey:serviceClass];
	if (service == nil) {
		service = [[serviceClass alloc] init];
		[[ServiceLocator shared].singletons setObject:service forKey:(id<NSCopying>)serviceClass];
	}
	return service;
}

+ (void)registerSingletonInstance:(id)instance forKey:(NSString *)key {
	[[ServiceLocator shared].singletons setObject:instance forKey:key];
}

+ (id)singletonForKey:(id)key {
	return [[ServiceLocator shared].singletons objectForKey:key];
}

- (NSMutableDictionary *)singletons {
	if (!singletons) {
		singletons = [[NSMutableDictionary alloc] init];
	}
	return singletons;
}

@end
