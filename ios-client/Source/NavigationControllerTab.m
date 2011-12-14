//
//  NavigationControllerTab.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/26/11.
//  Copyright 2011 Lucas Neiva. All rights reserved.
//

#import "NavigationControllerTab.h"


@implementation NavigationControllerTab

+ (NavigationControllerTab *)controllerWithRootController:(Class)controllerClass tabBarItem:(UITabBarItem *)item {
	id rootController = [[controllerClass alloc] init];
	NavigationControllerTab *tab = [[NavigationControllerTab alloc] initWithRootViewController:rootController];
	tab.title = item.title;
	tab.tabBarItem = item;
	
	[rootController release];
	return [tab autorelease];
}

@end
