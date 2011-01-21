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

@protocol SeriesModelDelegate
@required
- (void)seriesUpdated:(Series *)updatedSeries;

@end


@interface SeriesModel : NSObject<CommunicationDelegate> {
	id<SeriesModelDelegate> delegate;
	Series *series;
}

@property (nonatomic, assign) id<SeriesModelDelegate> delegate;

- (void)getSeries:(NSString *)seriesId;

@end
