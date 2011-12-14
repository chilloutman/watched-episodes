//
//  SeriesBannerModel.h
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/23/11.
//  Copyright 2011 Lucas Neiva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractLoader.h"


typedef void (^ImageBlock) (UIImage *);


@interface SeriesBannerLoader : AbstractLoader

- (void)loadSeriesBannerForBannerPath:(NSString *)bannerPath completionBlock:(ImageBlock)block;

@end
