//
//  LastWatchedEpisodeViewController.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 12/10/11.
//  Copyright (c) 2011 Lucas Neiva. All rights reserved.
//

#import "LastWatchedEpisodeViewController.h"
#import "SeriesBannerLoader.h"

@interface LastWatchedEpisodeViewController () <SeriesBannerLoaderDelegate>

@property (nonatomic, copy) NSString *currentSeriesId;
@property (nonatomic, retain) SeriesBannerLoader *bannerLoader;

@end


@implementation LastWatchedEpisodeViewController

@synthesize bannerLoader, currentSeriesId;
@synthesize bannerView, seasonLabel, seasonStepper, episodeLabel, episodeStepper;

- (NSString *)nibName {
	return @"LastWatchedEpisode";
}

- (SeriesBannerLoader *)bannerLoader {
	if (!bannerLoader) {
		bannerLoader = [[SeriesBannerLoader alloc] init];
		bannerLoader.delegate = self;
	}
	return bannerLoader;
}

- (void)displayLastWatchedEpisodeForSeries:(PBSeries *)series {
	//if (![seriesId isEqualToString:self.currentSeriesId]) {
		//self.currentSeriesId= seriesId;
		self.bannerView.image = nil;
		[self.bannerLoader loadSeriesBanner:series.banner];
	//}
}

- (void)viewDidLoad {
	[super viewDidLoad];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)seasonStepperValueChanged:(UIStepper *)sender {
	self.seasonLabel.text = [NSString stringWithFormat:@"Season %.0lf", seasonStepper.value];
}

- (IBAction)episodeStepperValueChanged:(UIStepper *)sender {
	self.episodeLabel.text = [NSString stringWithFormat:@"Episode %.0lf", episodeStepper.value];
}

#pragma mark SeriesBannerLoaderDelegate

- (void)loadedSeriesBanner:(UIImage *)banner {
	self.bannerView.image = banner;
}

#pragma mark -

- (void)viewDidUnload {
	[super viewDidUnload];
	self.bannerView = nil;
	self.seasonLabel = nil;
	self.seasonStepper = nil;
	self.episodeLabel = nil;
	self.episodeStepper = nil;
}

- (void)dealloc {
	self.bannerLoader = nil;
	self.currentSeriesId = nil;
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


@end
