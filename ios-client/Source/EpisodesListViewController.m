//
//  EpisodesListViewController.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 3/17/11.
//  Copyright 2011 Ergon Informatik AG. All rights reserved.
//

#import "EpisodesListViewController.h"
#import "SeriesDetailViewController.h"

@interface EpisodesListViewController () <EpisodesLoaderDelegate>

@property (nonatomic, copy) NSString *currentSeriesId;
@property (nonatomic, retain) EpisodesLoader *episodesLoader;
@property (nonatomic, retain) NSArray *episodes;

@end


@implementation EpisodesListViewController

@synthesize currentSeriesId, episodesLoader, episodes;

- (void)viewDidLoad {
	self.title = @"Episodes";
	self.navigationItem.backBarButtonItem.title = @"Episodes";
	UIBarButtonItem *infoButton = [[UIBarButtonItem alloc] initWithTitle:@"Series Info" style:UIBarButtonItemStyleBordered target:self action:@selector(showSeriesInfo)];
	self.navigationItem.rightBarButtonItem = infoButton;
	[infoButton release];
}

- (void)showSeriesInfo {
	SeriesDetailViewController *seriesInfo = [[SeriesDetailViewController alloc] init];
	[seriesInfo displayDetailsForSeriesWithId:self.currentSeriesId];
	[self.navigationController pushViewController:seriesInfo animated:YES];
	[seriesInfo release];
}

- (EpisodesLoader *)episodesLoader {
	if (!episodesLoader) {
		episodesLoader = [[EpisodesLoader alloc] init];
		episodesLoader.delegate = self;
	}
	return episodesLoader;
}

- (void)displayEpisodesForSeriesWithId:(NSString *)seriesId {
	self.currentSeriesId = seriesId;
	[self.episodesLoader loadAllEpisodesForSeries:seriesId];
}

#pragma mark EpisodesLoaderDelegate

- (void)loadedEpisodes:(NSArray *)loadedEpisodes {
	self.episodes = loadedEpisodes;
	[self.tableView reloadData];
}

#pragma mark UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)t {
	return 1;
}

- (NSInteger)tableView:(UITableView *)t numberOfRowsInSection:(NSInteger)section {
    return [self.episodes count];
}

- (UITableViewCell *)tableView:(UITableView *)t cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier= @"Cell";
    
    UITableViewCell *cell = [t dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	PBEpisode *episode = [self.episodes objectAtIndex:indexPath.row];
    cell.textLabel.text = episode.episodeName;
    
    return cell;
}

#pragma mark -

- (void)dealloc {
	self.episodesLoader = nil;
	[super dealloc];
}

@end
