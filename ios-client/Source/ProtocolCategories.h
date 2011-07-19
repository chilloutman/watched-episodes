//
//  ProtocolCategories.h
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 7/19/11.
//  Copyright 2011 Lucas Neiva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProtocolTypes.pb.h"

@interface PBEpisode (StringGetters)

@property (nonatomic, readonly) NSString *seasonString;
@property (nonatomic, readonly) NSString *episodeNumberString;

@end