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

@interface SeriesDetailViewController : UIViewController <SeriesLoaderDelegate, SeriesBannerLoaderDelegate, UITextViewDelegate> {
	SeriesLoader *seriesLoader;
	SeriesBannerLoader *bannerLoader;
	PBSeries *currentSeries;
	
	UILabel *nameLabel;
	UITextView *overviewView;
	UIImageView *bannerView;
	UIActivityIndicatorView *spindicator;
}

- (void)displayDetailsForUnloadedSeries:(NSString *)seriesId;
- (void)displayDetailsForSeries:(PBSeries *)series;

@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UITextView *overviewView;
@property (nonatomic, retain) IBOutlet UIImageView *bannerView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *spindicator;

@end
