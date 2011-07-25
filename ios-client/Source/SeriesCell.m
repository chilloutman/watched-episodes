//
//  SeriesCell.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 7/22/11.
//  Copyright 2011 Lucas Neiva. All rights reserved.
//

#import "SeriesCell.h"
#import "WatchedManager.h"


@implementation SeriesCell

@synthesize series;
@synthesize unwatchedLabel, seriesNameLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSeries:(PBSeries *)seriesToDisplay {
    if (series != seriesToDisplay) {
        series = seriesToDisplay;
        self.seriesNameLabel.text = series.seriesName;
        NSUInteger unwatched = [[WatchedManager shared] numberOfUnwatchedEpisodesForSeries:series];
        self.unwatchedLabel.text = [NSString stringWithFormat:@"%d unwatched", unwatched];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [unwatchedLabel release];
    [seriesNameLabel release];
    [super dealloc];
}
@end
