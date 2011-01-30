//
//  AbstractTab.h
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NavigationControllerTab : UIViewController <UINavigationControllerDelegate> {
	UINavigationController *navController;
	UIViewController *rootController;
	Class rootControllerClass;
}

+ (NavigationControllerTab *)controllerWithRootController:(Class)controllerClass tabBarItem:(UITabBarItem *)item;

@end
