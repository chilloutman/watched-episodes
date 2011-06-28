//
//  SearchLoader.h
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchSeries.pb.h"
#import "AbstractLoader.h"

@protocol SearchSeriesModelDelegate

- (void)searchResultsUpdated:(NSArray *)searchResults;

@end


@interface SearchLoader : AbstractLoader {
	id<SearchSeriesModelDelegate> delegate;
	NSArray *seachResults;
}

@property (nonatomic, assign) id<SearchSeriesModelDelegate> delegate; 

- (void)searchSeries:(NSString *)seriesName;

@end
