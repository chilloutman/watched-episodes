//
//  WatchedEpisodesAppDelegate.h
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SearchSeriesViewController;

@interface WatchedEpisodesAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    SearchSeriesViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet SearchSeriesViewController *viewController;

@end

