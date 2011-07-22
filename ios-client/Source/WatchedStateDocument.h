//
//  WatchedStateDocument.h
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 7/15/11.
//  Copyright 2011 Lucas Neiva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProtocolTypes.pb.h"

@interface WatchedStateDocument : UIDocument

+ (WatchedStateDocument *)documentForSeries:(NSString *)seriesId;
- (id)initWithSeries:(NSString *)seriesId;
- (void)markEpisodeAsWatched:(PBEpisode *)episode;
- (BOOL)isEpisodeMarkedAsWatched:(PBEpisode *)episode;

@end
