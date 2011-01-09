//
//  ServiceLocator.h
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServiceLocator : NSObject {
	NSMutableDictionary *singletons;
}

+ (id)singletonForClass:(Class)serviceClass;

@end
