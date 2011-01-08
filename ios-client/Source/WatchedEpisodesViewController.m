//
//  WatchedEpisodesViewController.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WatchedEpisodesViewController.h"
#import "ProtocolBuffers.h"
#import "SearchSeries.pb.h"

@implementation WatchedEpisodesViewController



/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

- (void)viewWillAppear:(BOOL)animated {
	//NSURL *url= [NSURL URLWithString:@"http://localhost:8080/searchSeries?name=simpsons"];
	NSURL *url= [NSURL URLWithString:@"http://watched-episodes.appspot.com/searchSeries?name=walking+dead"];
	NSURLRequest *request= [NSURLRequest requestWithURL:url];
	NSData *data= [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
	
	NSArray *searchResults= [[PBSearchResults parseFromData:data] seriesList];
	
	NSLog(@"Search Results: ");
	for (PBSearchResults_PBSeries *s in searchResults) {
		NSLog(@"%@ -> %@\n", [s id], [s name]);
	}
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

#pragma mark -

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
