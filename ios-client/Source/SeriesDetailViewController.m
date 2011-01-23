//
//  SeriesDetailViewController.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SeriesDetailViewController.h"
#import "SeriesLoader.h"


@interface SeriesDetailViewController ()

- (void)resetUI;

@property (nonatomic, retain) SeriesLoader *seriesLoader;
@property (nonatomic, retain) SeriesBannerLoader *bannerLoader;
@property (nonatomic, copy) NSString *currentSeriesId;

@end


@implementation SeriesDetailViewController

@synthesize seriesLoader, bannerLoader, currentSeriesId;
@synthesize nameLabel, overviewView, bannerView;

- (NSString *)nibName {
	return @"SeriesDetail";
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
	NSLog(@"View will appear.");
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

- (void)displayDetailsForSeries:(NSString *)seriesId {
	if (seriesId != self.currentSeriesId) {
		[self.seriesLoader loadSeries:seriesId];
		[self resetUI];
		self.currentSeriesId= seriesId;
	}
}

- (void)resetUI {
	self.nameLabel.text= nil;
	self.overviewView.text= nil;
	self.bannerView.image= nil;
}

#pragma mark SeriesModelDelegate

- (void)loadedSeries:(Series *)series {
	self.nameLabel.text= series.seriesName;
	self.overviewView.text= series.overview;
	[self.bannerLoader loadSeriesBanner:series.banner];
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
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
