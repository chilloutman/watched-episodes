//
//  WatchedEpisodesViewController.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SearchSeriesViewController.h"
#import "SearchLoader.h"
#import "SeriesDetailViewController.h"


@interface SearchSeriesViewController ()

@property (nonatomic, retain) NSArray *searchResults;
@property (nonatomic, retain) SearchLoader *model;
@property (nonatomic, retain) SeriesDetailViewController *seriesController;
@property (nonatomic, retain) NSString *lastSearchString;

- (void)search;
- (BOOL)shouldSearch:(NSString *)searchString;

@end


@implementation SearchSeriesViewController

@synthesize model, seriesController, searchResults, lastSearchString;

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


- (void)viewDidLoad {
    [super viewDidLoad];
}

- (NSString *)nibName {
	return @"SearchSeries";
}

- (SearchLoader *)model {
	if (!model) {
		model= [[SearchLoader alloc] init];
		model.delegate= self;
	}
	return model;
}

- (SeriesDetailViewController *)seriesController {
	if (!seriesController) {
		seriesController= [[SeriesDetailViewController alloc] init];
		seriesController.showsFaveButton = YES;
	}
	return seriesController;
}

- (void)search {
	NSString *searchString= self.searchDisplayController.searchBar.text;
	if ([self shouldSearch:searchString]) {
		[self.model searchSeries:searchString];
	}
}

- (BOOL)shouldSearch:(NSString *)searchString {
	searchString= [searchString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	return (searchString &&
			![searchString isEqualToString:@""]);
}

#pragma mark SearchSeriesModelDelegate

- (void)searchResultsUpdated:(NSArray *)results {
	self.searchResults= results;
	[self.searchDisplayController.searchResultsTableView reloadData];
}

#pragma mark UISearchDisplay

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
	[self search];
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
	// TODO: This would allow searching without the need of hitting the search key.
	return NO;
}

#pragma mark UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.searchResults count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier= @"searchCell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if (cell == nil) {
		cell= [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
	}
	
	PBSeriesSummary *series= [self.searchResults objectAtIndex:indexPath.row];
	cell.textLabel.text= series.seriesName;
				
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self.navigationController pushViewController:self.seriesController animated:YES];
	PBSeriesSummary *series= [self.searchResults objectAtIndex:indexPath.row];
	[self.seriesController displayDetailsForSeriesWithId:series.seriesId];
}

#pragma mark -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
	self.model= nil;
}

- (void)viewDidUnload {
	self.searchResults= nil;
}

- (void)dealloc {
	self.model= nil;
	self.searchResults= nil;
	self.lastSearchString= nil;
    [super dealloc];
}

@end
