//
//  WatchedEpisodesViewController.h
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchLoader.h"

@class SeriesDetailViewController;

@interface SearchSeriesViewController : UIViewController <UISearchDisplayDelegate, SearchSeriesModelDelegate> {
	SearchLoader *model;
	SeriesDetailViewController *seriesController;
	NSString *lastSearchString;
}

@end

