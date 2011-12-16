//
//  SeriesManager.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/26/11.
//  Copyright 2011 Lucas Neiva. All rights reserved.
//

#import "SeriesManager.h"
#import "Files.h"
#import "ServiceLocator.h"
#import "JSONDocument.h"


@interface SeriesManager () <JSONDocumentDataProvider>

@property (nonatomic, retain) JSONDocument *document;
@property (nonatomic, retain) NSMutableArray *seriesIds;

@end


@implementation SeriesManager

@synthesize document, seriesIds;

+ (SeriesManager *)shared {
    return [ServiceLocator singletonForClass:[SeriesManager class]];
}

- (id)init {
    self = [super init];
	if (self != nil) {
		self.seriesIds = [NSMutableArray array];
	}
	return self;
}

- (JSONDocument *)document {
	if (!document) {
		document = [[JSONDocument alloc] initWithDocumentName:@"Series.json" dataProvider:self];
	}
	return document;
}

- (NSArray *)favoriteSeriesIds {
	return self.seriesIds;
}

- (void)addSeriesToFavorites:(NSString *)seriesId {
	if (![self.seriesIds containsObject:seriesId]) {
		[self.seriesIds addObject:seriesId];
		[self.document updateChangeCount:UIDocumentChangeDone];
	}
}

- (BOOL)isSeriesInFavorites:(NSString *)seriesId {
	return [self.seriesIds containsObject:seriesId];
}

- (void)loadFavoritesWithCompletionBlock:(void (^) ())block {
	[self.document openWithCompletionHandler:^ (BOOL success) {
		if (success) {
			block();
		}
	}];
}

- (void)save {
	[self.document savePresentedItemChangesWithCompletionHandler:^ (NSError *error) { }];
}

- (void)closeDocument {
	[self.document closeWithCompletionHandler:^ (BOOL success) {
		self.document = nil;
	}];
}

#pragma mark JSONDocumentDataProvider

- (id)JSONObject {
	return self.seriesIds;
}

- (void)setJSONObject:(id)JSONObject {
	self.seriesIds = JSONObject;
}

- (BOOL)isJSONObjectEmpty {
	return [self.seriesIds count] == 0;
}

#pragma mark -

- (void)dealloc {
	self.document = nil;
	self.seriesIds = nil;
	[super dealloc];
}

@end
