//
//  NavigationControllerTab.h
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/26/11.
//  Copyright 2011 Lucas Neiva. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NavigationControllerTab : UINavigationController <UINavigationControllerDelegate>

+ (NavigationControllerTab *)controllerWithRootController:(Class)controllerClass tabBarItem:(UITabBarItem *)item;

@end
