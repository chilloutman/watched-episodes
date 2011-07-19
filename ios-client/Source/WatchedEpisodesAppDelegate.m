//
//  WatchedEpisodesAppDelegate.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WatchedEpisodesAppDelegate.h"

#import "NavigationControllerTab.h"
#import "SearchSeriesViewController.h"
#import "FavoritesViewController.h"

@implementation WatchedEpisodesAppDelegate

@synthesize window;
@synthesize tabController;

#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	UITabBarItem *tabBarItem = [[[UITabBarItem alloc] initWithTitle:@"Find" image:[UIImage imageNamed:@"Find"] tag:0] autorelease];
	NavigationControllerTab *find = [NavigationControllerTab controllerWithRootController:[SearchSeriesViewController class]
                                                                              tabBarItem:tabBarItem];
	tabBarItem = [[[UITabBarItem alloc] initWithTitle:@"Favorites" image:[UIImage imageNamed:@"Heart"] tag:1] autorelease];
	NavigationControllerTab *favs = [NavigationControllerTab controllerWithRootController:[FavoritesViewController class]
																			  tabBarItem:tabBarItem];
	
	self.tabController = [[[UITabBarController alloc] init] autorelease];
	[self.tabController setViewControllers:[NSArray arrayWithObjects:find, favs, nil]];
	
    [self.window addSubview:self.tabController.view];
    [self.window makeKeyAndVisible];

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
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
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
	self.tabController = nil;
	self.window = nil;
    [super dealloc];
}


@end
