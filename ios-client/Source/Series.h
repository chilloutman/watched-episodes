//
//  Series.h
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PBSeries;

@interface Series : NSObject {
	NSString *seriesId;
	NSString *language;
	NSString *seriesName;
	NSString *overview;
	NSString *firstAired;
	NSArray *actors;
	NSString *banner;
	NSString *imdbId;
}

@property (nonatomic, readonly) NSString *seriesId;
@property (nonatomic, readonly) NSString *language;
@property (nonatomic, readonly) NSString *seriesName;
@property (nonatomic, readonly) NSString *overview;
@property (nonatomic, readonly) NSString *firstAired;
@property (nonatomic, readonly) NSArray *actors;
@property (nonatomic, readonly) NSString *banner;
@property (nonatomic, readonly) NSString *imdbId;

+ (Series *)seriesFromProtoMessage:(PBSeries *)proto;
- (Series *)initWithProtoMessage:(PBSeries *)proto;

@end
