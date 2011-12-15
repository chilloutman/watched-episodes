//
//  LastWatchedEpisodeViewController.h
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 12/10/11.
//  Copyright (c) 2011 Lucas Neiva. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LastWatchedEpisodeViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) PBSeries *series;

@end
