//
//  FavoritesTab.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FavoritesViewController.h"
#import "FavoritesManager.h"
#import "WatchedManager.h"
#import "SeriesDetailViewController.h"
#import "EpisodesListViewController.h"
#import "LastWatchedEpisodeViewController.h"
#import "SeriesCell.h"


@interface FavoritesViewController ()

- (PBSeries *)seriesForIndexPath:(NSIndexPath *)indexPath;

@property (nonatomic, retain) SeriesDetailViewController *seriesController;
@property (nonatomic, retain) LastWatchedEpisodeViewController *lastWatchedController;

@end


@implementation FavoritesViewController

static NSString *CellIdentifier = @"SeriesCell";

@synthesize seriesController, lastWatchedController;

- (void)viewDidLoad {
	[super viewDidLoad];
    UINib *cellNib = [UINib nibWithNibName:CellIdentifier bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:CellIdentifier];
}

- (void)viewWillAppear:(BOOL)animated {
	[self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:animated];
}

- (void)viewDidAppear:(BOOL)animated {
	[self.tableView	reloadData];
}

/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/

- (SeriesDetailViewController *)seriesController {
	if (!seriesController) {
		seriesController = [[SeriesDetailViewController alloc] init];
	}
	return seriesController;
}

- (LastWatchedEpisodeViewController *)lastWatchedController {
	if (!lastWatchedController) {
		lastWatchedController = [[LastWatchedEpisodeViewController alloc] init];
	}
	return lastWatchedController;
}

#pragma mark UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)t {
	return 1;
}

- (NSInteger)tableView:(UITableView *)t numberOfRowsInSection:(NSInteger)section {
    return [[FavoritesManager shared].allFavoriteSeries count];
}

- (UITableViewCell *)tableView:(UITableView *)t cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SeriesCell *cell = [t dequeueReusableCellWithIdentifier:CellIdentifier];
    PBSeries *series = [[FavoritesManager shared].allFavoriteSeries objectAtIndex:indexPath.row];
    cell.series = series;
    
    [[WatchedManager shared] loadWatchedStateForSeries:series.seriesId withCompletionHandler:^ {
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self.navigationController pushViewController:self.lastWatchedController animated:YES];
	[self.lastWatchedController displayLastWatchedEpisodeForSeries:[self seriesForIndexPath:indexPath]];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
	[self.navigationController pushViewController:self.seriesController animated:YES];
	[self.seriesController displayDetailsForSeries:[self seriesForIndexPath:indexPath]];
}

- (PBSeries *)seriesForIndexPath:(NSIndexPath *)indexPath {
	return [[FavoritesManager shared].allFavoriteSeries objectAtIndex:indexPath.row];
}

#pragma mark -

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
	[super viewDidUnload];
    self.seriesController = nil;
	self.lastWatchedController = nil;
}

- (void)dealloc {
	self.seriesController = nil;
	self.lastWatchedController = nil;
    [super dealloc];
}


@end

