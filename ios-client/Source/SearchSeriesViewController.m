//
//  WatchedEpisodesViewController.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SearchSeriesViewController.h"
#import "SearchSeriesModel.h"

@interface SearchSeriesViewController ()

@property (nonatomic, retain) NSArray *searchResults;
@property (nonatomic, retain) SearchSeriesModel *model;

- (void)performSearch;
- (BOOL)checkResponse:(NSHTTPURLResponse *)response;

@end

@implementation SearchSeriesViewController

@synthesize searchResultsTable, searchField;
@synthesize model, searchResults;

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

- (NSString *)nibName {
	return @"SearchSeries";
}

- (SearchSeriesModel *)model {
	if (!model) {
		model= [[SearchSeriesModel alloc] init];
		model.delegate= self;
	}
	return model;
}

- (IBAction)search:(UIButton *)sender {
	[self performSearch];
}

- (void)performSearch {
	[self.model searchSeries:self.searchField.text];
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

#pragma mark SearchSeriesModelDelegate

- (void)searchResultsUpdated:(NSArray *)results {
	self.searchResults= results;
	[self.searchResultsTable reloadData];
}

#pragma mark UITextFieldDelegate


#pragma mark UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.searchResults count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier= @"searchCell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if (cell == nil) {
		cell= [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	}
	
	cell.textLabel.text= [self.searchResults objectAtIndex:indexPath.row];
				
	return cell;
}

#pragma mark -

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
	self.model= nil;
}

- (void)viewDidUnload {
	self.searchResultsTable= nil;
	self.searchField= nil;
	self.searchResults= nil;
}

- (void)dealloc {
	self.searchResultsTable= nil;
	self.searchField= nil;
	self.searchResults= nil;
	self.model= nil;
    [super dealloc];
}

@end
