//
//  ServiceLocator.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
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
	id service= [[ServiceLocator shared].singletons objectForKey:serviceClass];
	if (!service) {
		service= [[serviceClass alloc] init];
		[[ServiceLocator shared].singletons setObject:service forKey:serviceClass];
	}
	return service;
}

- (NSMutableDictionary *)singletons {
	if (!singletons) {
		singletons= [[NSMutableDictionary alloc] init];
	}
	return singletons;
}

- (void)dealloc {
	self.singletons= nil;
	[super dealloc];
}

@end
