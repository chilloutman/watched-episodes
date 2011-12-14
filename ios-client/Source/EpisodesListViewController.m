//
//  EpisodesListViewController.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 3/17/11.
//  Copyright 2011 Lucas Neiva Informatik AG. All rights reserved.
//

#import "EpisodesListViewController.h"
#import "SeriesDetailViewController.h"
#import "EpisodesDataProvider.h"
#import "EpisodesLoader.h"
#import "WatchedManager.h"

@interface EpisodesListViewController ()

@property (nonatomic, copy) NSString *currentSeriesId;
@property (nonatomic, retain) EpisodesDataProvider *model;
@property (nonatomic, retain) EpisodesLoader *episodesLoader;

- (PBEpisode *)episodeForIndexPath:(NSIndexPath *)indexPath;

@end


@implementation EpisodesListViewController

@synthesize currentSeriesId, model, episodesLoader;

- (EpisodesLoader *)episodesLoader {
	if (!episodesLoader) {
		episodesLoader = [[EpisodesLoader alloc] init];
	}
	return episodesLoader;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"Episodes";
	self.navigationItem.backBarButtonItem.title = @"Episodes";
	UIBarButtonItem *infoButton = [[UIBarButtonItem alloc] initWithTitle:@"Series Info" style:UIBarButtonItemStyleBordered target:self action:@selector(showSeriesInfo)];
	self.navigationItem.rightBarButtonItem = infoButton;
	[infoButton release];
    self.model = [[[EpisodesDataProvider alloc] init] autorelease];
}

- (void)showSeriesInfo {
	SeriesDetailViewController *seriesInfo = [[SeriesDetailViewController alloc] init];	
	[self.navigationController pushViewController:seriesInfo animated:YES];
	seriesInfo.seriesId = self.currentSeriesId;
	[seriesInfo release];
}

- (void)displayEpisodesForSeriesWithId:(NSString *)seriesId {
    if (![self.currentSeriesId isEqualToString:seriesId]) {
        self.currentSeriesId = seriesId;
        [self.episodesLoader loadAllEpisodesForSeries:seriesId completionBlock:^ (NSArray *episodes) {
			self.model = [EpisodesDataProvider providerWithEpisodes:episodes];
			[self.tableView reloadData];
		}];
    }
}

#pragma mark UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)t {
	return [self.model numberOfseasons];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"Season %d", section+1];
}

- (NSInteger)tableView:(UITableView *)t numberOfRowsInSection:(NSInteger)section {
    return [self.model numberOfEpisodesForSeason:section+1];
}

- (UITableViewCell *)tableView:(UITableView *)t cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [t dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	PBEpisode *episode = [self episodeForIndexPath:indexPath];
	cell.textLabel.text = episode.episodeName;
    cell.accessoryType = ([[WatchedManager shared] isEpisodeMarkedAsWatched:episode]) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
	
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	// TODO Something could happen here. Episode details maybe?
}

- (PBEpisode *)episodeForIndexPath:(NSIndexPath *)indexPath {
    return [[self.model episodesForSeason:indexPath.section+1] objectAtIndex:indexPath.row];
}

#pragma mark -

- (void)viewDidUnload {
    self.currentSeriesId = nil;
}

- (void)dealloc {
	self.model = nil;
    self.episodesLoader = nil;
    self.currentSeriesId = nil;
	[super dealloc];
}

@end
