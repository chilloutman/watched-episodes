//
//  WatchedEpisodesViewController.h
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchSeriesModel.h"

@interface SearchSeriesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, SearchSeriesModelDelegate> {
	SearchSeriesModel *model;
	UITableView *searchResultsTable;
	UITextField *searchField;
}

@property (nonatomic, retain) IBOutlet UITableView *searchResultsTable;
@property (nonatomic, retain) IBOutlet UITextField *searchField;

- (IBAction)search:(UIButton *)sender;

@end

