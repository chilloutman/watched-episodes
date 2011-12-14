//
//  SeriesBannerModel.h
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractLoader.h"


typedef void(^ImageHandler)(UIImage *);


@interface SeriesBannerLoader : AbstractLoader

- (void)loadSeriesBanner:(NSString *)bannerPath withHandler:(ImageHandler)handler;

@end
