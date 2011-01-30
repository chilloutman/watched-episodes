    //
//  AbstractTab.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NavigationControllerTab.h"


@interface NavigationControllerTab ()

@property (nonatomic, retain) UINavigationController * navController;
@property (nonatomic, retain) UIViewController *rootController;

- (id)initWithRootControllerClass:(Class)controllerClass;

@end


@implementation NavigationControllerTab

@synthesize navController, rootController;

+ (NavigationControllerTab *)controllerWithRootController:(Class)controllerClass tabBarItem:(UITabBarItem *)item {
	NavigationControllerTab *tab= [[NavigationControllerTab alloc] initWithRootControllerClass:controllerClass];
	tab.title= item.title;
	tab.tabBarItem= item;
	
	return [tab autorelease];
}

- (id)initWithRootControllerClass:(Class)controllerClass {
	if (self= [super init]) {
		rootControllerClass= controllerClass;
	}
	return self;
}

- (void)loadView {
	self.rootController= [[[rootControllerClass alloc] init] autorelease];
	self.rootController.title= self.title;
	
	self.navController= [[[UINavigationController alloc] initWithRootViewController:self.rootController] autorelease];
	self.navController.delegate= self;
	CGRect f= navController.navigationBar.frame;
	f.origin.y= 0; // Remove status bar spacing
	self.navController.navigationBar.frame= f;
	
	self.view= [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
	[self.view addSubview:self.navController.view];
}

- (void)viewWillAppear:(BOOL)animated {
	[self.navController.topViewController viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
	[self.navController.topViewController viewDidAppear:animated];
}

- (void)navigationController:(UINavigationController *)n willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
	[viewController viewWillAppear:animated];
}

- (void)navigationController:(UINavigationController *)n didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
	[viewController viewDidAppear:animated];
}

#pragma mark -

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
	// WTF... But it's the best thing I came up with that works
	self.navController.navigationBarHidden= YES;
	self.navController.navigationBarHidden= NO;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
	self.navController= nil;
	self.rootController= nil;
}

- (void)dealloc {
	self.navController= nil;
	self.rootController= nil;
	[super dealloc];
}

@end
