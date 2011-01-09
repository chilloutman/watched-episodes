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
#import "NSString+URLEncoding.h"

@interface WatchedEpisodesViewController ()

- (void)performSearch;
- (BOOL)checkResponse:(NSHTTPURLResponse *)response;

@property (nonatomic, retain) NSArray *searchResults;

@end

@implementation WatchedEpisodesViewController

@synthesize searchResultsTable, searchField, searchResults;

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

// - (void)viewWillAppear:(BOOL)animated { }

- (IBAction)search:(UIButton *)sender {
	[self performSearch];
}

- (void)performSearch {
	//NSString *base= @"http://watched-episodes.appspot.com";
	NSString *base= @"http://localhost:8080";
	
	NSString *search= [self.searchField.text URLEncodedString];
	
	NSString *urlString= [NSString stringWithFormat:@"%@/searchSeries?name=%@&t=protobuf", base, search];
	NSLog(@"%@", urlString);
	NSURL *url= [NSURL URLWithString:urlString];
	NSURLRequest *request= [NSURLRequest requestWithURL:url];
	NSHTTPURLResponse *response;
	NSData *data= [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
	
	if ([self checkResponse:response]) {
		self.searchResults= [[PBSearchResults parseFromData:data] seriesList];
		[self.searchResultsTable reloadData];
	}
}


- (BOOL)checkResponse:(NSHTTPURLResponse *)response {
	if ([response statusCode] == 200) {
		NSDictionary *headers= [response allHeaderFields];
		NSLog(@"%@", [headers objectForKey:@"Content-Type"]);
		return ([[headers objectForKey:@"Content-Type"] isEqualToString:@"application/x-protobuf"]);
	} else {
		return NO;
	}
}

#pragma mark UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
	// TODO The request has to be async for this to make any sense.
	// [self performSelectorOnMainThread:@selector(performSearch) withObject:nil waitUntilDone:NO];
	return YES;
}

#pragma mark UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSLog(@"%d", [self.searchResults count]);
	return [self.searchResults count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier= @"searchCell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if (cell == nil) {
		cell= [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	}
	
	PBSearchResults_PBSeries *series= [self.searchResults objectAtIndex:indexPath.row];
	cell.textLabel.text= [series name];
				
	return cell;
}

#pragma mark -

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
	self.searchResults= nil;
}

- (void)viewDidUnload {
	self.searchResultsTable= nil;
	self.searchField= nil;
	self.searchResults= nil;
}

- (void)dealloc {
	self.searchResults= nil;
	self.searchResultsTable= nil;
	self.searchField= nil;
	self.searchResults= nil;
    [super dealloc];
}

@end
