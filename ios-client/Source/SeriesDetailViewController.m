//
//  SeriesDetailViewController.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SeriesDetailViewController.h"
#import "FavoritesManager.h"


@interface SeriesDetailViewController ()

- (void)refreshUI;
- (void)resetUI;
- (void)loadSeriesForSeriesId:(NSString *)seriesId;
- (void)updateFaveButton;

@property (nonatomic, retain) SeriesLoader *seriesLoader;
@property (nonatomic, retain) SeriesBannerLoader *bannerLoader;
@property (nonatomic, retain) PBSeries *series;

@end


@implementation SeriesDetailViewController

@synthesize seriesLoader, bannerLoader, showsFaveButton, series=_series, seriesId=_seriesId;
@synthesize nameLabel, overviewView, bannerView, spindicator, faveButton;

- (NSString *)nibName {
	return @"SeriesDetail";
}

- (SeriesLoader *)seriesLoader {
	if (!seriesLoader) {
		seriesLoader = [[SeriesLoader alloc] init];
		seriesLoader.delegate= self;
	}
	return seriesLoader;
}

- (SeriesBannerLoader *)bannerLoader {
	if (!bannerLoader) {
		bannerLoader = [[SeriesBannerLoader alloc] init];
	}
	return bannerLoader;
}

- (void)viewDidLoad {
	self.title = @"Info";
	if (showsFaveButton) {
		self.navigationItem.rightBarButtonItem = self.faveButton;
		[self updateFaveButton];
	}
	
	[self resetUI];
}

- (void)setSeries:(PBSeries *)series {
	if (![series.seriesId isEqualToString:self.series.seriesId]) {
		[_series release];
		_series = [series retain];
		
		[self refreshUI];
	}
}

- (void)setSeriesId:(NSString *)seriesId {
	if (![seriesId isEqualToString:_seriesId]) {
		[_seriesId release];
		_seriesId = [seriesId copy];
		
		self.series = nil;
		PBSeries *series = [[FavoritesManager shared] seriesForSeriesId:self.seriesId];
		if (series) {
			self.series = series;
		} else {
			[self loadSeriesForSeriesId:self.seriesId];
		}

	}
}

- (void)viewWillAppear:(BOOL)animated {
	[self refreshUI];
}

- (void)loadSeriesForSeriesId:(NSString *)seriesId {
	[self.seriesLoader loadSeries:seriesId];
	[self resetUI];
	[self.spindicator startAnimating];
}

- (void)refreshUI {
	[self.spindicator stopAnimating];
	[self.bannerLoader loadSeriesBanner:self.series.banner withHandler:^(UIImage *banner) {
        self.nameLabel.text = nil;
        self.bannerView.image = banner;
    }];

	self.nameLabel.text = self.series.seriesName;
	self.overviewView.text = self.series.overview;
	[self updateFaveButton];
}

- (void)resetUI {
	self.nameLabel.text = nil;
	self.overviewView.text = nil;
	self.bannerView.image = nil;
}

- (IBAction)faveSeries {
	[[FavoritesManager shared] addSeriesToFavorites:self.series];
	[self updateFaveButton];
}

- (void)updateFaveButton {
	if ([[FavoritesManager shared] isInFavorites:self.seriesId]) {
		self.faveButton.enabled = NO;
		self.faveButton.image = [UIImage imageNamed:@"Heart"];
	} else {
		self.faveButton.enabled = YES;
		self.faveButton.image = [UIImage imageNamed:@"HeartAlt"];
	}
}

#pragma mark SeriesModelDelegate

- (void)loadedSeries:(PBSeries *)series {
	self.series = series;
}

#pragma mark UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
	return NO;
}

#pragma mark -

- (void)viewDidUnload {
    [super viewDidUnload];
	self.bannerLoader = nil;
	self.seriesLoader = nil;
	self.faveButton = nil;
	self.overviewView = nil;
	self.bannerView = nil;
	self.spindicator = nil;
}

- (void)dealloc {
	self.faveButton = nil;
	self.bannerLoader = nil;
	self.seriesLoader = nil;
	self.series = nil;
	self.seriesId = nil;
	self.nameLabel = nil;
	self.overviewView = nil;
	self.bannerView = nil;
	self.spindicator = nil;
    [super dealloc];
}

@end
