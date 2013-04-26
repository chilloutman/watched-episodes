//
//  FavoriteSeries.h
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 4/26/13.
//  Copyright (c) 2013 Lucas Neiva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface FavoriteSeries : NSManagedObject

@property (nonatomic, retain) NSString * seriesId;
@property (nonatomic, retain) NSNumber * season;
@property (nonatomic, retain) NSNumber * episode;

@end
