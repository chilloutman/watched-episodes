//
//  WatchedEpisodesAppDelegate.h
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WatchedEpisodesViewController;

@interface WatchedEpisodesAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    WatchedEpisodesViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet WatchedEpisodesViewController *viewController;

@end

