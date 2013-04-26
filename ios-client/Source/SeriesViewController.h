//
//  FavoritesTab.h
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/26/11.
//  Copyright 2011 Lucas Neiva. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SeriesManager, SeriesDetailViewController, SeriesViewController;

@protocol SeriesViewControllerDelegate

- (void)seriesViewControllerWantsToSearchShows:(SeriesViewController *)controller;

@end


@interface SeriesViewController : UITableViewController

@property (weak, nonatomic) id<SeriesViewControllerDelegate> delegate;

@end
