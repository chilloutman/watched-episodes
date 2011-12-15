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
	
	WatchedEpisode *episode = [[WatchedManager shared] lastWatchedEpisodeForSeriesId:series.seriesId];
	// TODO Create this string inside the WatchedEpisode class?
	if (episode.isZero) {
		self.unwatchedLabel.text = @"";
	} else {
		self.unwatchedLabel.text = [NSString stringWithFormat:@"Season %d Episode %d", episode.seasonNumber, episode.episodeNumber];
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
