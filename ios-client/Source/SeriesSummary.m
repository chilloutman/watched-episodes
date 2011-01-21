//
//  SeriesSummary.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SeriesSummary.h"
#import "SearchSeries.pb.h"

@implementation SeriesSummary

@synthesize seriesId, seriesName;

+ (id)seriesFromProtoMessage:(PBSearchResults_PBSeriesSummary *)proto {
	return [[[SeriesSummary alloc] initWithProtoMessage:proto] autorelease];
}

- (SeriesSummary *)initWithProtoMessage:(PBSearchResults_PBSeriesSummary *)proto {
	if (self= [super init]) {
		seriesId= [[proto seriesId] retain];
		seriesName= [[proto seriesName] retain];
	}
	return self;
}

@end
