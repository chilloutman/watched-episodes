//
//  SearchSeriesModel.h
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommunicationDelegate.h"


@protocol SearchSeriesModelDelegate
@required
- (void)searchResultsUpdated:(NSArray *)searchResults;

@end


@interface SearchSeriesModel : NSObject <CommunicationDelegate> {
	id<SearchSeriesModelDelegate> delegate;
}

@property (nonatomic, assign) id<SearchSeriesModelDelegate> delegate; 
- (void)searchSeries:(NSString *)seriesName;

@end
