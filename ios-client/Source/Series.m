//
//  Series.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Series.h"
#import "GetSeries.pb.h"

@implementation Series

@synthesize seriesId, language, seriesName, overview, firstAired, actors, banner, imdbId;

+ (id)seriesFromProtoMessage:(PBSeries *)proto {
	return [[[Series alloc] initWithProtoMessage:proto] autorelease];
}

- (Series *)initWithProtoMessage:(PBSeries *)proto {
	if (self= [super init]) {
		seriesId= [[proto seriesId] retain];
		language= [[proto language] retain];
		seriesName= [[proto seriesName] retain];
		overview= [[proto overview] retain];
		firstAired= [[proto firstAired] retain];
		actors= [[proto actorsList] retain];
		banner= [[proto banner] retain];
		imdbId= [[proto imdbId] retain];
	}
	return self;
}

@end
