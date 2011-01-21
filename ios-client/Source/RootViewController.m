//
//  RootViewController.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "SearchSeriesTab.h"


@interface RootViewController ()

@property (nonatomic, retain) UITabBarController *tabController;

@end


@implementation RootViewController

@synthesize tabController;

- (void)loadView {
	NSArray *viewControllers= [NSArray arrayWithObjects:[[[SearchSeriesTab alloc] init] autorelease], nil];
	
	self.tabController= [[[UITabBarController alloc] init] autorelease];
	[self.tabController setViewControllers:viewControllers];
	
	self.view= tabController.view;
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

#pragma mark -

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
	self.tabController= nil;
}

- (void)dealloc {
    [super dealloc];
	self.tabController= nil;
}


@end
