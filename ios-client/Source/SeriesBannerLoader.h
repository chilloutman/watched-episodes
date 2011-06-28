//
//  SeriesBannerModel.h
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractLoader.h"

@protocol SeriesBannerLoaderDelegate 

- (void)loadedSeriesBanner:(UIImage *)banner;

@end


@interface SeriesBannerLoader : AbstractLoader {
	id <SeriesBannerLoaderDelegate> delegate;
	UIImage *banner;
	NSString *currentBannerPath;
}

@property (nonatomic, assign) id<SeriesBannerLoaderDelegate> delegate;

- (void)loadSeriesBanner:(NSString *)bannerPath;

@end
