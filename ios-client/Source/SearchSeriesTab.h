//
//  SearchSeriesRootController.h
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SearchSeriesViewController;

@interface SearchSeriesTab : UIViewController {
	UINavigationController *navController;
	SearchSeriesViewController *rootController;
}

@end
