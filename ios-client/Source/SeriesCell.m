//
//  SeriesCell.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 7/22/11.
//  Copyright 2011 Lucas Neiva. All rights reserved.
//

#import "SeriesCell.h"
#import "WatchedManager.h"
#import "SeriesBannerLoader.h"


@interface SeriesCell ()

@property (nonatomic, retain) SeriesBannerLoader *bannerLoader;

@end


@implementation SeriesCell

@synthesize series, bannerLoader;
@synthesize unwatchedLabel, seriesNameLabel, bannerView;

- (SeriesBannerLoader *)bannerLoader {
	if (!bannerLoader) {
		bannerLoader = [[SeriesBannerLoader alloc] init];
	}
	return bannerLoader;
}

- (void)setSeries:(PBSeries *)seriesToDisplay {
	self.bannerView.image = nil;
	[self.bannerLoader cancel];
	
	series = seriesToDisplay;
	self.seriesNameLabel.text = series.seriesName;
	
	WatchedEpisode *episode = [[WatchedManager shared] lastWatchedEpisodeForSeriesId:series.seriesId];
	// TODO Create this string inside the WatchedEpisode class?
	if (episode.isZero) {
		self.unwatchedLabel.text = @"";
	} else {
		self.unwatchedLabel.text = [NSString stringWithFormat:@"Season %d Episode %d", episode.seasonNumber, episode.episodeNumber];
	}
	
	[self.bannerLoader loadSeriesBannerForBannerPath:series.banner completionBlock:^ (UIImage *banner) {
		self.bannerView.image = banner;
	}];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
