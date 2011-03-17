//
//  SeriesBannerModel.h
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol SeriesBannerLoaderDelegate 
@required
- (void)loadedSeriesBanner:(UIImage *)banner;

@end


@interface SeriesBannerLoader : NSObject {
	id <SeriesBannerLoaderDelegate> delegate;
	UIImage *banner;
}

@property (nonatomic, assign) id<SeriesBannerLoaderDelegate> delegate;

- (void)loadSeriesBanner:(NSString *)bannerPath;

@end
