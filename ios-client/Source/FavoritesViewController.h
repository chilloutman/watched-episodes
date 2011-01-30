//
//  FavoritesTab.h
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FavoritesMananger, SeriesDetailViewController;

@interface FavoritesViewController : UITableViewController {
	FavoritesMananger *favoritesManager;
	SeriesDetailViewController *seriesController;
}

@end
