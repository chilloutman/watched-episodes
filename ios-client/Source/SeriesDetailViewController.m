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

@property (nonatomic, retain) SeriesLoader *seriesLoader;
@property (nonatomic, retain) SeriesBannerLoader *bannerLoader;
@property (nonatomic, retain) PBSeries *currentSeries;

@end


@implementation SeriesDetailViewController

@synthesize seriesLoader, bannerLoader, currentSeries;
@synthesize nameLabel, overviewView, bannerView, spindicator;

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
	UIBarButtonItem *faveButton= [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(faveSeries)];
	self.navigationItem.rightBarButtonItem= faveButton;
}

- (void)viewWillAppear:(BOOL)animated {
	NSLog(@"View will appear.");
}

- (void)displayDetailsForUnloadedSeries:(NSString *)seriesId {
	if (![seriesId isEqualToString:self.currentSeries.seriesId]) {
		[self.seriesLoader loadSeries:seriesId];
		[self resetUI];
		[self.spindicator startAnimating];
	}
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

- (void)faveSeries {
	FavoritesMananger *manager= [ServiceLocator singletonForClass:[FavoritesMananger class]];
	[manager addSeriesToFavorites:self.currentSeries];
}

#pragma mark SeriesModelDelegate

- (void)loadedSeries:(PBSeries *)series {
	[self displayDetailsForSeries:series];
}

- (void)loadedSeriesBanner:(UIImage *)banner {
	self.nameLabel= nil;
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
}

- (void)dealloc {
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
