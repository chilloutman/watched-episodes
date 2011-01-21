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
	
	self.rootController= [[SearchSeriesViewController alloc] init];
	self.navController= [[UINavigationController alloc] initWithRootViewController:self.rootController];
	[self.rootController release];
	
	CGRect frame = [[navController navigationBar] frame];
	frame.origin.y = 0;
	[[self.navController navigationBar] setFrame:frame];
	self.view= self.navController.view;
}

#pragma mark -

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
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
