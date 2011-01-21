//
//  SeriesDetailViewController.h
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeriesModel.h"

@interface SeriesDetailViewController : UIViewController <SeriesModelDelegate> {
@private
	SeriesModel *model;
}

- (void)displayDetailsForSeries:(NSString *)seriesId;

@end
