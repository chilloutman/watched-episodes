//
//  SeriesSummary.h
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PBSearchResults_PBSeriesSummary;

@interface SeriesSummary : NSObject {
	NSString *seriesId;
	NSString *seriesName;
}

@property (nonatomic, readonly) NSString *seriesId;
@property (nonatomic, readonly) NSString *seriesName;

+ (SeriesSummary *)seriesFromProtoMessage:(PBSearchResults_PBSeriesSummary *)proto;
- (SeriesSummary *)initWithProtoMessage:(PBSearchResults_PBSeriesSummary *)proto;

@end
