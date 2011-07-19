//
//  WatchedStateDocument.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 7/15/11.
//  Copyright 2011 Lucas Neiva. All rights reserved.
//

#import "WatchedStateDocument.h"
#import "FileHelper.h"

@interface WatchedStateDocument ()

@property (nonatomic, retain) NSMutableDictionary *state;

@end

@implementation WatchedStateDocument

@synthesize state;

+ (WatchedStateDocument *)documentForSeries:(NSString *)seriesId {
    NSString *filePath = [[FileHelper documentDirectoryNamed:@"watched"] stringByAppendingPathComponent:seriesId];
    WatchedStateDocument *document = [[WatchedStateDocument alloc] initWithFileURL:[NSURL fileURLWithPath:filePath isDirectory:NO]];
    return [document autorelease];
}

- (BOOL)loadFromContents:(id)contents ofType:(NSString *)typeName error:(NSError **)outError {
    BOOL success = NO;
    if (contents == nil) {
        self.state = [NSMutableDictionary dictionary];
        success = YES;
    } else {
        self.state = [NSJSONSerialization JSONObjectWithData:contents options:NSJSONReadingMutableContainers error:NULL];
        success = YES;
    }
    return success;
}

- (id)contentsForType:(NSString *)typeName error:(NSError **)outError {
    return ([self.state count] > 0) ? [NSJSONSerialization dataWithJSONObject:self.state options:0 error:NULL] : [NSData data];
}

- (void)markEpisodeAsWatched:(PBEpisode *)episode {
	if (![self isEpisodeMarkedAsWatched:episode]) {
		NSMutableArray *season = [self.state objectForKey:episode.seasonString];
		if (season == nil) {
			season = [NSMutableArray arrayWithObject:episode.episodeNumberString];
			[self.state setObject:season forKey:episode.seasonString];
		} else {
			[season addObject:episode.episodeNumberString];
		}
        [self updateChangeCount:UIDocumentChangeDone];
	}
}

- (BOOL)isEpisodeMarkedAsWatched:(PBEpisode *)episode {
	return [[self.state objectForKey:episode.seasonString] containsObject:episode.episodeNumberString];
}

@end
