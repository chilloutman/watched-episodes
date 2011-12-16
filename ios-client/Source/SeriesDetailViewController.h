//
//  SeriesDetailViewController.h
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/21/11.
//  Copyright 2011 Lucas Neiva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeriesLoader.h"
#import "SeriesBannerLoader.h"

@class SeriesManager;

@interface SeriesDetailViewController : UIViewController <UITextViewDelegate>

@property (nonatomic, copy) NSString *seriesId;
@property (nonatomic, assign) BOOL showsFaveButton;

@end
