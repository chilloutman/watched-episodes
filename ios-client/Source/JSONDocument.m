//
//  JSONDocument.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 12/15/11.
//  Copyright (c) 2011 Lucas Neiva. All rights reserved.
//

#import "JSONDocument.h"
#import "Files.h"


@interface JSONDocument ()

@property (nonatomic, assign) id<JSONDocumentDataProvider>dataProvider;

@end


@implementation JSONDocument

@synthesize dataProvider;

- (id)initWithDocumentName:(NSString *)documentName dataProvider:(id<JSONDocumentDataProvider>)provider {
	NSURL *fileURL = [Files URLForDocumentNamed:documentName];
	self = [super initWithFileURL:fileURL];
	if (self) {
		self.dataProvider = provider;
	}
	return self;
}

#pragma mark UIDocument

- (BOOL)loadFromContents:(NSData *)contents ofType:(NSString *)typeName error:(NSError **)outError {
	NSError *error = nil;
	if ([contents length] > 0) {
		dataProvider.JSONObject = [NSJSONSerialization JSONObjectWithData:contents options:NSJSONReadingMutableContainers error:&error];
    }
	
	if (error && outError) {
		*outError = error;
		return NO;
	} else {
		return YES;
	}
}

- (NSData *)contentsForType:(NSString *)typeName error:(NSError **)outError {
	NSLog(@"is Valid JSON object: %@", [NSNumber numberWithBool:[NSJSONSerialization isValidJSONObject:self.dataProvider.JSONObject]]);
	
    return (self.dataProvider.isJSONObjectEmpty) ? [NSData data] : [NSJSONSerialization dataWithJSONObject:self.dataProvider.JSONObject options:0 error:outError];
}

- (void)openWithCompletionHandler:(void (^)(BOOL))completionHandler {
	if ([Files fileExistsAtPath:self.fileURL.path]) {
		[super openWithCompletionHandler:^ (BOOL success) {
			NSLog(@"Opening %@ - success: %@", self.fileURL.path, [NSNumber numberWithBool:success]);
			completionHandler(success);
		}];
	} else {
		[self saveToURL:self.fileURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^ (BOOL success) {
			NSLog(@"Saving %@ - success: %@", self.fileURL.path, [NSNumber numberWithBool:success]);
			completionHandler(success);
		}];
	}
}

- (void)closeWithCompletionHandler:(void (^)(BOOL))completionHandler {
	[super closeWithCompletionHandler:^ (BOOL success) {
		NSLog(@"Closing %@ - success: %@", self.fileURL.path, [NSNumber numberWithBool:success]);
		completionHandler(success);
	}];
}


@end
