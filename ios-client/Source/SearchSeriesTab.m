    //
//  SearchSeriesRootController.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SearchSeriesTab.h"
#import "SearchSeriesViewController.h"


@interface SearchSeriesTab ()

@property (nonatomic, retain) UINavigationController * navController;
@property (nonatomic, retain) SearchSeriesViewController *rootController;

@end


@implementation SearchSeriesTab

@synthesize navController, rootController;

- (void)loadView {
	self.title= @"Find";
	
	self.rootController= [[[SearchSeriesViewController alloc] init] autorelease];
	self.navController= [[[UINavigationController alloc] initWithRootViewController:self.rootController] autorelease];
	
	// Remove status bar spacing
	CGRect f= navController.navigationBar.frame;
	f.origin.y= 0;
	self.navController.navigationBar.frame= f;
	
	self.view= self.navController.view;
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
