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


typedef void(^SearchResultsBlock)(NSArray *searchResults);


@interface SearchLoader : AbstractLoader

- (void)searchSeriesWithName:(NSString *)seriesName completionBlock:(SearchResultsBlock)block;

@end
