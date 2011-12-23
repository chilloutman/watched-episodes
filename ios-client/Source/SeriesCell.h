//
//  SeriesCell.h
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 7/22/11.
//  Copyright 2011 Lucas Neiva. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SeriesCell : UITableViewCell

@property (nonatomic, assign) PBSeries * series;

@property (nonatomic, retain) IBOutlet UILabel *unwatchedLabel;
@property (nonatomic, retain) IBOutlet UIImageView *bannerView;
@property (nonatomic, retain) IBOutlet UILabel *seriesNameLabel;

@end
