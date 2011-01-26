//
//  FavoritesTab.h
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FavoritesMananger;

@interface FavoritesViewController : UITableViewController {
	FavoritesMananger *favoritesManager;
}

@end
