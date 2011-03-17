//
//  EpisodesListViewController.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 3/17/11.
//  Copyright 2011 Ergon Informatik AG. All rights reserved.
//

#import "EpisodesListViewController.h"

@interface EpisodesListViewController () <EpisodesLoaderDelegate>

@property (nonatomic, retain) EpisodesLoader *episodesLoader;
@property (nonatomic, retain) NSArray *episodes;

@end


@implementation EpisodesListViewController

@synthesize episodesLoader, episodes;

- (void)viewDidLoad {
	
}

- (EpisodesLoader *)episodesLoader {
	if (!episodesLoader) {
		episodesLoader = [[EpisodesLoader alloc] init];
		episodesLoader.delegate = self;
	}
	return episodesLoader;
}

- (void)displayEpisodesForSeriesWithId:(NSString *)seriesId {
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
