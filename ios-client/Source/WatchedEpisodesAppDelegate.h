//
//  WatchedEpisodesAppDelegate.h
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface WatchedEpisodesAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    RootViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet RootViewController *viewController;

@end

