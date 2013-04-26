//
//  WatchedEpisodesAppDelegate.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/8/11.
//  Copyright 2011 Lucas Neiva. All rights reserved.
//

#import "WatchedEpisodesAppDelegate.h"

#import "NavigationControllerTab.h"
#import "SearchSeriesViewController.h"
#import "SeriesViewController.h"
#import "WatchedManager.h"
#import "SeriesManager.h"


@interface WatchedEpisodesAppDelegate () <SeriesViewControllerDelegate>


@end


@implementation WatchedEpisodesAppDelegate

#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    SeriesViewController *c = [[SeriesViewController alloc] init];
    c.delegate = self;
    
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:c];
    [self.window makeKeyAndVisible];

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
	[[WatchedManager shared] closeDocument];
	[[SeriesManager shared] closeDocument];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
	[[WatchedManager shared] save];
	[[SeriesManager shared] save];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
	
	[[WatchedManager shared] loadLastWatchedEpisodesWithCompletionBlock:^ {
		[[NSNotificationCenter defaultCenter] postNotificationName:WatchedManagerDidFinishLoadingNotification object:[WatchedManager shared]];
	}];
	
	[[SeriesManager shared] loadFavoritesWithCompletionBlock:^ {
		
	}];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}

#pragma mark SeriesViewControllerDelegate

- (void)seriesViewControllerWantsToSearchShows:(SeriesViewController *)controller {
    SearchSeriesViewController *search = [[SearchSeriesViewController alloc] init];
    UIViewController *controllerToPresent = [[UINavigationController alloc] initWithRootViewController:search];
    [controller presentViewController:controllerToPresent animated:YES completion:nil];
}

#pragma mark -

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}

@end
