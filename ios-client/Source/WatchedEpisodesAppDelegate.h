//
//  WatchedEpisodesAppDelegate.h
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/8/11.
//  Copyright 2011 Lucas Neiva. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface WatchedEpisodesAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) UITabBarController *tabController;

@end

