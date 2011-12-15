//
//  LastWatchedEpisodeViewController.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 12/10/11.
//  Copyright (c) 2011 Lucas Neiva. All rights reserved.
//

#import "LastWatchedEpisodeViewController.h"
#import "WatchedManager.h"
#import "SeriesBannerLoader.h"
#import "EpisodesListViewController.h"


@interface LastWatchedEpisodeViewController ()

- (void)refreshUI;
- (void)refreshLastWatchedEpisodeLabels;

@property (nonatomic, retain) SeriesBannerLoader *bannerLoader;

@property (nonatomic, retain) IBOutlet UIImageView *bannerView;
@property (nonatomic, retain) IBOutlet UITableViewCell *allEpisodesCell;

@property (nonatomic, retain) IBOutlet UITableViewCell *seasonCell;
@property (nonatomic, retain) IBOutlet UILabel *seasonLabel;
@property (nonatomic, retain) IBOutlet UIStepper *seasonStepper;

@property (nonatomic, retain) IBOutlet UITableViewCell *episodeCell;
@property (nonatomic, retain) IBOutlet UILabel *episodeLabel;
@property (nonatomic, retain) IBOutlet UIStepper *episodeStepper;

@end


@implementation LastWatchedEpisodeViewController

@synthesize bannerLoader, series;
@synthesize bannerView, allEpisodesCell;
@synthesize seasonCell, seasonLabel, seasonStepper;
@synthesize episodeCell, episodeLabel, episodeStepper;

- (NSString *)nibName {
	return @"LastWatchedEpisode";
}

- (SeriesBannerLoader *)bannerLoader {
	if (!bannerLoader) {
		bannerLoader = [[SeriesBannerLoader alloc] init];
	}
	return bannerLoader;
}

- (void)setSeries:(PBSeries *)newSeries {
	if (![newSeries.seriesId isEqualToString:self.series.seriesId]) {
		[series release];
		series = [newSeries retain];
		[self refreshUI];
	}
}

- (void)viewWillAppear:(BOOL)animated {
	WatchedEpisode *episode = [[WatchedManager shared] lastWatchedEpisodeForSeriesId:series.seriesId];
	self.episodeStepper.value = episode.episodeNumber;
	self.seasonStepper.value = episode.seasonNumber;
	
	[self refreshUI];
}

- (void)refreshUI {
	self.bannerView.image = nil;
	[self.bannerLoader loadSeriesBannerForBannerPath:self.series.banner completionBlock:^ (UIImage *banner) {
        self.bannerView.image = banner;
    }];
	
	
	[self refreshLastWatchedEpisodeLabels];
}

- (void)refreshLastWatchedEpisodeLabels {
	WatchedEpisode *episode = [[WatchedManager shared] lastWatchedEpisodeForSeriesId:series.seriesId];
	
	self.episodeLabel.text = [NSString stringWithFormat:@"Episode %d", episode];
	self.seasonLabel.text = [NSString stringWithFormat:@"Season %d", episode.seasonNumber];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)stepperValueChanged:(UIStepper *)sender {	
	WatchedEpisode *episode = [WatchedEpisode episodeWithSeriesId:series.seriesId episodeNumber:episodeStepper.value seasonNumber:seasonStepper.value];
	[[WatchedManager shared] setLastWatchedEpisode:episode];
	[self refreshLastWatchedEpisodeLabels];
}

#pragma mark UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	switch (section) {
		case 0: return 2;
		case 1: return 1;
		default: return 0;
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = nil;
	
	if (indexPath.section == 0) {
		cell =  (indexPath.row == 0) ? self.seasonCell : self.episodeCell;
	} else if (indexPath.section == 1) {
		cell = self.allEpisodesCell;
	}
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (self.allEpisodesCell.selected) {
		EpisodesListViewController *episodesList= [[EpisodesListViewController alloc] init];
		[self.navigationController pushViewController:episodesList animated:YES];
		[episodesList displayEpisodesForSeriesWithId:self.series.seriesId];
		[episodesList release];
	}
}

#pragma mark -

- (void)viewDidUnload {
	[super viewDidUnload];
	self.bannerView = nil;
	self.seasonCell = nil;
	self.seasonLabel = nil;
	self.seasonStepper = nil;
	self.seasonCell = nil;
	self.episodeLabel = nil;
	self.episodeStepper = nil;
}

- (void)dealloc {
	self.bannerLoader = nil;
	self.series = nil;
	
	self.bannerView = nil;
	self.seasonCell = nil;
	self.seasonLabel = nil;
	self.seasonStepper = nil;
	self.seasonCell = nil;
	self.episodeLabel = nil;
	self.episodeStepper = nil;
}

@end
