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

@class SeriesBannerLoader;

@protocol SeriesModelDelegate
@required
- (void)loadedSeries:(Series *)updatedSeries;
- (void)loadedSeriesBanner:(UIImage *)banner;

@end


@interface SeriesModel : NSObject<CommunicationDelegate> {
	id<SeriesModelDelegate> delegate;
	SeriesBannerLoader *bannerLoader;
	Series *series;
	UIImage *banner;
}

@property (nonatomic, assign) id<SeriesModelDelegate> delegate;

- (void)loadSeries:(NSString *)seriesId;
- (void)loadSeriesBanner:(NSString *)bannerPath;

@end
