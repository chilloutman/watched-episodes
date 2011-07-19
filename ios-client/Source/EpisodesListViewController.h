//
//  EpisodesListViewController.h
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 3/17/11.
//  Copyright 2011 Lucas Neiva Informatik AG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EpisodesLoader.h"

@interface EpisodesListViewController : UITableViewController

- (void)displayEpisodesForSeriesWithId:(NSString *)seriesId;

@end
