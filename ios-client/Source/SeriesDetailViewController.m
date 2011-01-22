//
//  SeriesDetailViewController.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SeriesDetailViewController.h"
#import "SeriesModel.h"


@interface SeriesDetailViewController ()

@property (nonatomic, retain) SeriesModel *model;

@end


@implementation SeriesDetailViewController

@synthesize model;
@synthesize nameLabel, overviewView, bannerView;

- (NSString *)nibName {
	return @"SeriesDetail";
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (SeriesModel *)model {
	if (!model) {
		model= [[SeriesModel alloc] init];
		model.delegate= self;
	}
	return model;
}

- (void)displayDetailsForSeries:(NSString *)seriesId {
	[self.model getSeries:seriesId];
}

#pragma mark SeriesModelDelegate

- (void)seriesUpdated:(Series *)updatedSeries {
	self.nameLabel.text= updatedSeries.seriesName;
	self.overviewView.text= updatedSeries.overview;
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
