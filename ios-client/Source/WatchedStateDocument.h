//
//  WatchedStateDocument.h
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 12/12/11.
//  Copyright (c) 2011 Lucas Neiva. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WatchedStateDocument : UIDocument

- (NSMutableDictionary *)lastWatchedEpisodeDictionaryForSeries:(NSString *)seriesId;

@end
