//
//  SeriesDetailViewController.h
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeriesLoader.h"
#import "SeriesBannerLoader.h"

@class FavoritesManager;

@interface SeriesDetailViewController : UIViewController <SeriesLoaderDelegate, SeriesBannerLoaderDelegate, UITextViewDelegate> {
	SeriesLoader *seriesLoader;
	SeriesBannerLoader *bannerLoader;
	PBSeries *currentSeries;
	BOOL showsFaveButton;
	
	UILabel *nameLabel;
	UITextView *overviewView;
	UIImageView *bannerView;
	UIActivityIndicatorView *spindicator;
	UIBarButtonItem *faveButton;
}

@property (nonatomic, copy) NSString *seriesId;
@property (nonatomic, assign) BOOL showsFaveButton;

#pragma mark IB

- (IBAction)faveSeries;

@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UITextView *overviewView;
@property (nonatomic, retain) IBOutlet UIImageView *bannerView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *spindicator;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *faveButton;

@end
