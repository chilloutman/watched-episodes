//
//  WatchedStateDocument.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 12/12/11.
//  Copyright (c) 2011 Lucas Neiva. All rights reserved.
//

#import "WatchedStateDocument.h"
#import "FileHelper.h"

@interface WatchedStateDocument ()

@property (nonatomic, retain) NSMutableDictionary *lastWatchedEpisodes;

@end


@implementation WatchedStateDocument

@synthesize lastWatchedEpisodes;

- (id)init {
	NSURL *fileURL = [FileHelper URLForDocumentNamed:@"LastWatched.json"];
	self = [super initWithFileURL:fileURL];
	if (self) {
		self.lastWatchedEpisodes = [NSMutableDictionary dictionary];
	}
	return self;
}

- (NSMutableDictionary *)lastWatchedEpisodeDictionaryForSeries:(NSString *)seriesId {
	NSMutableDictionary *dictionary = [self.lastWatchedEpisodes objectForKey:seriesId];
	if (!dictionary) {
		dictionary = [NSMutableDictionary dictionary];
		[self.lastWatchedEpisodes setObject:dictionary forKey:seriesId];
	}
	
	return dictionary;
}

#pragma mark UIDocument

- (BOOL)loadFromContents:(NSData *)contents ofType:(NSString *)typeName error:(NSError **)outError {
	NSError *error = nil;
	if ([contents length] > 0) {
		self.lastWatchedEpisodes = [NSJSONSerialization JSONObjectWithData:contents options:NSJSONReadingMutableContainers error:&error];
    }
	
	if (error && outError) {
		*outError = error;
		return NO;
	} else {
		return YES;
	}
}

- (NSData *)contentsForType:(NSString *)typeName error:(NSError **)outError {
    return ([self.lastWatchedEpisodes count] > 0) ? [NSJSONSerialization dataWithJSONObject:self.lastWatchedEpisodes options:0 error:outError] : [NSData data];
}

#pragma mark -

- (void)dealloc {
	self.lastWatchedEpisodes = nil;
	[super dealloc];
}


@end
