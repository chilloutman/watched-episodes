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
	series = seriesToDisplay;
	self.seriesNameLabel.text = series.seriesName;
	
	NSUInteger season = [[WatchedManager shared] lastWatchedEpisodeSeasonNumberForSeriesId:series.seriesId];
	NSUInteger episode = [[WatchedManager shared] lastWatchedEpisodeNumberForSeriesId:series.seriesId];
	if (season != 0 && episode != 0) {
		self.unwatchedLabel.text = [NSString stringWithFormat:@"Season %d Episode %d", season, episode];
	} else {
		self.unwatchedLabel.text = @"";
	}
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
	self.unwatchedLabel = nil;
	self.seriesNameLabel = nil;
    [super dealloc];
}

@end
