//
//  SeriesDetailViewController.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/21/11.
//  Copyright 2011 Lucas Neiva. All rights reserved.
//

#import "SeriesDetailViewController.h"
#import "SeriesManager.h"


@interface SeriesDetailViewController ()

- (void)refreshUI;
- (void)resetUI;
- (void)loadSeriesForSeriesId:(NSString *)seriesId;
- (void)updateFaveButton;

@property (nonatomic, retain) PBSeries *series;

#pragma mark IB

- (IBAction)faveSeries;

@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UITextView *overviewView;
@property (nonatomic, retain) IBOutlet UIImageView *bannerView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *spindicator;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *faveButton;

@end


@implementation SeriesDetailViewController

@synthesize showsFaveButton, series=_series, seriesId=_seriesId;
@synthesize nameLabel, overviewView, bannerView, spindicator, faveButton;

- (NSString *)nibName {
	return @"SeriesDetail";
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"Info";
	if (showsFaveButton) {
		self.navigationItem.rightBarButtonItem = self.faveButton;
		[self updateFaveButton];
	}
	
	[self resetUI];
}

- (void)setSeriesId:(NSString *)seriesId {
	if (![seriesId isEqualToString:_seriesId]) {
		_seriesId = [seriesId copy];
		
		if (seriesId) {
			[self loadSeriesForSeriesId:self.seriesId];
		}
	}
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	[self refreshUI];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
	[[SeriesManager shared].seriesBannerLoader cancel];
	[[SeriesManager shared].seriesLoader cancel];
}

- (void)loadSeriesForSeriesId:(NSString *)seriesId {
	[self resetUI];
	[self.spindicator startAnimating];

	[[SeriesManager shared].seriesLoader loadSeriesForSeriesId:seriesId completionBlock:^ (PBSeries *series) {
		[self.spindicator stopAnimating];
		self.series = series;
		[self refreshUI];
		[[SeriesManager shared].seriesBannerLoader loadSeriesBannerForBannerPath:self.series.banner completionBlock:^(UIImage *banner) {
			self.nameLabel.text = nil;
			self.bannerView.image = banner;
		}];
	}];
}

- (void)resetUI {
	self.nameLabel.text = nil;
	self.overviewView.text = nil;
	self.bannerView.image = nil;
	self.faveButton.enabled = NO;
}

- (void)refreshUI {
	self.nameLabel.text = self.series.seriesName;
	self.overviewView.text = self.series.overview;
	[self updateFaveButton];
}

- (void)updateFaveButton {
	if ([[SeriesManager shared] isSeriesInFavorites:self.series.seriesId]) {
		self.faveButton.enabled = NO;
		self.faveButton.image = [UIImage imageNamed:@"Heart"];
	} else {
		self.faveButton.enabled = YES;
		self.faveButton.image = [UIImage imageNamed:@"HeartAlt"];
	}
}

- (IBAction)faveSeries {
	[[SeriesManager shared] addSeriesToFavorites:self.series.seriesId];
	[self updateFaveButton];
}


#pragma mark UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
	return NO;
}

#pragma mark -

- (void)dealloc {
	[[SeriesManager shared].seriesBannerLoader cancel];
	[[SeriesManager shared].seriesLoader cancel];
}

@end
