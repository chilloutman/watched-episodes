//
//  SeriesModel.h
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommunicationDelegate.h"
#import "GetSeries.pb.h"

@protocol SeriesLoaderDelegate
@required
- (void)loadedSeries:(PBSeries *)updatedSeries;

@end


@interface SeriesLoader : NSObject<CommunicationDelegate> {
	id<SeriesLoaderDelegate> delegate;
	PBSeries *series;
}

@property (nonatomic, assign) id<SeriesLoaderDelegate> delegate;

- (void)loadSeries:(NSString *)seriesId;

@end
