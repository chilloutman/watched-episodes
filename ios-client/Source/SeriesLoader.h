//
//  SeriesModel.h
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/21/11.
//  Copyright 2011 Lucas Neiva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractLoader.h"
#import "GetSeries.pb.h"


typedef void (^SeriesBlock) (PBSeries *series);

@interface SeriesLoader : AbstractLoader

- (void)loadSeriesForSeriesId:(NSString *)seriesId completionBlock:(SeriesBlock)block;

@end
