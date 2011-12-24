//
//  SearchSeriesModel.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/9/11.
//  Copyright 2011 Lucas Neiva. All rights reserved.
//

#import "SearchLoader.h"
#import "NSString+URLEncoding.h"


@implementation SearchLoader

- (void)searchSeriesWithName:(NSString *)seriesName completionBlock:(SearchResultsBlock)block {
	NSString *searchTerm = [seriesName URLEncodedString];
	[self sendHTTPRequestWithURLString:[NSString stringWithFormat:@"%@/searchSeries?name=%@", ServerURL, searchTerm] completionBlock:^ (NSData *data) {
		NSArray *searchResults = [[SearchSeriesResponse parseFromData:data] seriesList];
		block(searchResults);
	}];
}

@end
