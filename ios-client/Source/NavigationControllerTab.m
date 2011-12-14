    //
//  AbstractTab.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/26/11.
//  Copyright 2011 Lucas Neiva. All rights reserved.
//

#import "NavigationControllerTab.h"


@interface NavigationControllerTab ()

@property (nonatomic, retain) UIViewController *rootController;

- (id)initWithRootControllerClass:(Class)controllerClass;

@end


@implementation NavigationControllerTab

@synthesize rootController;

+ (NavigationControllerTab *)controllerWithRootController:(Class)controllerClass tabBarItem:(UITabBarItem *)item {
	NavigationControllerTab *tab = [[NavigationControllerTab alloc] initWithRootViewController:[[[controllerClass alloc] init] autorelease]];
	tab.title = item.title;
	tab.tabBarItem = item;
	
	return [tab autorelease];
}

- (id)initWithRootControllerClass:(Class)controllerClass {
	if ((self = [super init]) != nil) {
		rootControllerClass = controllerClass;
	}
	return self;
}

#pragma mark -

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
	self.rootController = nil;
}

- (void)dealloc {
	self.rootController = nil;
	[super dealloc];
}

@end
