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
#import "Persister.h"
#import "ServiceLocator.h"


@interface WatchedEpisodesAppDelegate () <SeriesViewControllerDelegate>


@end


@implementation WatchedEpisodesAppDelegate {
    Persister *_persister;
}

#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self registerSingletons];
    SeriesViewController *c = [[SeriesViewController alloc] init];
    c.delegate = self;
    
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:c];
    [self.window makeKeyAndVisible];

    return YES;
}

- (void)registerSingletons {
    _persister = [[Persister alloc] init];
    [ServiceLocator registerSingletonInstance:_persister forKey:[Persister class]];
    [ServiceLocator registerSingletonInstance:[[SeriesManager alloc] initWithPersister:_persister] forKey:[SeriesManager class]];
    [ServiceLocator registerSingletonInstance:[[WatchedManager alloc] initWithPersister:_persister] forKey:[WatchedManager class]];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
//	[[WatchedManager shared] closeDocument];
//	[[SeriesManager shared] closeDocument];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
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
}

- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
    // Saves changes in the application's managed object context before the application terminates.
    [_persister save];
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
