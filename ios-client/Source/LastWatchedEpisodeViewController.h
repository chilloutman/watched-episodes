//
//  LastWatchedEpisodeViewController.h
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 12/10/11.
//  Copyright (c) 2011 Lucas Neiva. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LastWatchedEpisodeViewController : UIViewController

- (void)displayLastWatchedEpisodeForSeries:(PBSeries *)series;

@property (nonatomic, retain) IBOutlet UIImageView *bannerView;
@property (nonatomic, retain) IBOutlet UILabel *seasonLabel;
@property (nonatomic, retain) IBOutlet UIStepper *seasonStepper;
@property (nonatomic, retain) IBOutlet UILabel *episodeLabel;
@property (nonatomic, retain) IBOutlet UIStepper *episodeStepper;

- (IBAction)seasonStepperValueChanged:(UIStepper *)sender;
- (IBAction)episodeStepperValueChanged:(UIStepper *)sender;

@end
