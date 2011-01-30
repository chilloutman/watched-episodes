//
//  FavoritesTab.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FavoritesViewController.h"
#import "FavoritesMananger.h"
#import "SeriesDetailViewController.h"


@interface FavoritesViewController ()

@property (nonatomic, retain) SeriesDetailViewController *seriesController;

@end


@implementation FavoritesViewController

@synthesize seriesController;

- (void)viewDidLoad {
	[super viewDidLoad];
	favoritesManager= [ServiceLocator singletonForClass:[FavoritesMananger class]];
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

- (SeriesDetailViewController *)seriesController {
	if (!seriesController) {
		seriesController= [[SeriesDetailViewController alloc] init];
	}
	return seriesController;
}

#pragma mark UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)t {
	return 1;
}

- (NSInteger)tableView:(UITableView *)t numberOfRowsInSection:(NSInteger)section {
    return [favoritesManager.allFavoriteSeries count];
}

- (UITableViewCell *)tableView:(UITableView *)t cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier= @"Cell";
    
    UITableViewCell *cell= [t dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell= [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	PBSeries *series= [favoritesManager.allFavoriteSeries objectAtIndex:indexPath.row];
    cell.textLabel.text= series.seriesName;
    
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
    [self.navigationController pushViewController:self.seriesController animated:YES];
	[self.seriesController displayDetailsForSeries:[favoritesManager.allFavoriteSeries objectAtIndex:indexPath.row]];
}

#pragma mark -

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    self.seriesController= nil;
}

- (void)dealloc {
	self.seriesController= nil;
    [super dealloc];
}


@end

