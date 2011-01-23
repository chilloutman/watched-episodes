//
//  SeriesModel.h
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommunicationDelegate.h"
#import "Series.h"

@protocol SeriesLoaderDelegate
@required
- (void)loadedSeries:(Series *)updatedSeries;

@end


@interface SeriesLoader : NSObject<CommunicationDelegate> {
	id<SeriesLoaderDelegate> delegate;
	Series *series;
}

@property (nonatomic, assign) id<SeriesLoaderDelegate> delegate;

- (void)loadSeries:(NSString *)seriesId;

@end
