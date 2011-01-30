//
//  SeriesDetailViewController.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SeriesDetailViewController.h"
#import "SeriesLoader.h"
#import "FavoritesMananger.h"


@interface SeriesDetailViewController ()

- (void)resetUI;
- (void)loadSeriesForSeriesId:(NSString *)seriesId;

@property (nonatomic, retain) SeriesLoader *seriesLoader;
@property (nonatomic, retain) SeriesBannerLoader *bannerLoader;
@property (nonatomic, retain) PBSeries *currentSeries;

@end


@implementation SeriesDetailViewController

@synthesize seriesLoader, bannerLoader, currentSeries;
@synthesize nameLabel, overviewView, bannerView, spindicator, faveButton;

- (NSString *)nibName {
	return @"SeriesDetail";
}

- (SeriesLoader *)seriesLoader {
	if (!seriesLoader) {
		seriesLoader= [[SeriesLoader alloc] init];
		seriesLoader.delegate= self;
	}
	return seriesLoader;
}

- (SeriesBannerLoader *)bannerLoader {
	if (!bannerLoader) {
		bannerLoader= [[SeriesBannerLoader alloc] init];
		bannerLoader.delegate= self;
	}
	return bannerLoader;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	[self resetUI];
}

- (void)displayDetailsForSeriesWithId:(NSString *)seriesId {
	if (![seriesId isEqualToString:self.currentSeries.seriesId]) {
		PBSeries *series= [[ServiceLocator singletonForClass:[FavoritesMananger class]] seriesForSeriesId:seriesId];
		if (series) {
			[self displayDetailsForSeries:series];
			self.navigationItem.rightBarButtonItem= nil;
		} else {
			[self loadSeriesForSeriesId:seriesId];
			self.navigationItem.rightBarButtonItem= self.faveButton;
		}
	}
}

- (void)loadSeriesForSeriesId:(NSString *)seriesId {
	[self.seriesLoader loadSeries:seriesId];
	[self resetUI];
	[self.spindicator startAnimating];
}

- (void)displayDetailsForSeries:(PBSeries *)series {
	[self.spindicator stopAnimating];
	self.currentSeries= series;
	self.nameLabel.text= series.seriesName;
	self.overviewView.text= series.overview;
	[self.bannerLoader loadSeriesBanner:series.banner];
}

- (void)resetUI {
	self.nameLabel.text= nil;
	self.overviewView.text= nil;
	self.bannerView.image= nil;
}

- (IBAction)faveSeries {
	FavoritesMananger *manager= [ServiceLocator singletonForClass:[FavoritesMananger class]];
	[manager addSeriesToFavorites:self.currentSeries];
}

#pragma mark SeriesModelDelegate

- (void)loadedSeries:(PBSeries *)series {
	[self displayDetailsForSeries:series];
}

- (void)loadedSeriesBanner:(UIImage *)banner {
	self.nameLabel.text= nil;
	self.bannerView.image= banner;
}

#pragma mark UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
	return NO;
}

#pragma mark -

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	// Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    self.currentSeries= nil;
	self.bannerLoader= nil;
	self.seriesLoader= nil;
	self.faveButton= nil;
	self.overviewView= nil;
	self.bannerView= nil;
	self.spindicator= nil;
}

- (void)dealloc {
	self.faveButton= nil;
	self.bannerLoader= nil;
	self.seriesLoader= nil;
	self.currentSeries= nil;
	self.nameLabel= nil;
	self.overviewView= nil;
	self.bannerView= nil;
	self.spindicator= nil;
    [super dealloc];
}

@end
