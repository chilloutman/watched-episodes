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

@property (nonatomic, retain) SeriesBannerLoader *bannerLoader;

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
	[self refreshUI];
}

- (void)refreshUI {
	self.bannerView.image = nil;
	[self.bannerLoader loadSeriesBannerForBannerPath:self.series.banner completionBlock:^ (UIImage *banner) {
        self.bannerView.image = banner;
    }];
	self.episodeStepper.value = [[WatchedManager shared] lastWatchedEpisodeNumberForSeriesId:self.series.seriesId];
	[self episodeStepperValueChanged:self.episodeStepper];
	self.seasonStepper.value = [[WatchedManager shared] lastWatchedEpisodeSeasonNumberForSeriesId:self.series.seriesId];
	[self seasonStepperValueChanged:self.seasonStepper];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)seasonStepperValueChanged:(UIStepper *)sender {
	NSUInteger season = seasonStepper.value;
	self.seasonLabel.text = [NSString stringWithFormat:@"Season %d", season];
	[[WatchedManager shared] setLastWatchedEpisodeSeasonNumber:season forSeries:self.series.seriesId];
}

- (IBAction)episodeStepperValueChanged:(UIStepper *)sender {
	NSUInteger episode = episodeStepper.value;
	self.episodeLabel.text = [NSString stringWithFormat:@"Episode %d", episode];
	[[WatchedManager shared] setLastWatchedEpisodeNumber:episode forSeries:self.series.seriesId];
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
