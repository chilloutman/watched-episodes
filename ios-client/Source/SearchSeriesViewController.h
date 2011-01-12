//
//  WatchedEpisodesViewController.h
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchSeriesModel.h"


@interface SearchSeriesViewController : UIViewController <UISearchDisplayDelegate, SearchSeriesModelDelegate> {
	SearchSeriesModel *model;
	NSString *lastSearchString;
}

@end

