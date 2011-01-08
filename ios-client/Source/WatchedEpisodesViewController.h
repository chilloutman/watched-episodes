//
//  WatchedEpisodesViewController.h
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WatchedEpisodesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate> {
	UITableView *searchResultsTable;
	UITextField *searchField;
}

@property (nonatomic, retain) IBOutlet UITableView *searchResultsTable;
@property (nonatomic, retain) IBOutlet UITextField *searchField;

- (IBAction)search:(UIButton *)sender;

@end

