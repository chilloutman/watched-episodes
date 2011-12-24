//
//  SeriesBannerModel.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/23/11.
//  Copyright 2011 Lucas Neiva. All rights reserved.
//

#import "SeriesBannerLoader.h"
#import "Files.h"
#import "FileCache.h"
#import "ServiceLocator.h"


@interface SeriesBannerLoader ()

@property (nonatomic, copy) ImageBlock completionBlock;

- (BOOL)loadSeriesBannerFromCache:(NSString *)bannerPath;
- (void)loadSeriesBannerFromServer:(NSString *)bannerPath;
- (NSString *)cacheKeyForBannerPath:(NSString *)bannerPath;

- (void)finishedLoadingData:(NSData *)data;
- (void)completedWithBanner:(UIImage *)banner;

@end


@implementation SeriesBannerLoader

@synthesize completionBlock;

- (FileCache *)cache {
	return [FileCache sharedCacheWithDirectoryName:self.cacheDirectoryPath];
}

- (NSString *)cacheDirectoryPath {
	return @"BannerCache";
}

- (void)loadSeriesBannerForBannerPath:(NSString *)bannerPath completionBlock:(ImageBlock)block {
    self.completionBlock = block;
	
	if (![self loadSeriesBannerFromCache:bannerPath]) {
		[self loadSeriesBannerFromServer:bannerPath];
	}
}

- (BOOL)loadSeriesBannerFromCache:(NSString *)bannerPath {
	NSData *data = [self.cache loadDataForKey:[self cacheKeyForBannerPath:bannerPath]];
	if (data) {
		[self finishedLoadingData:data];
		return YES;
	} else {
		return NO;
	}
}

- (void)loadSeriesBannerFromServer:(NSString *)bannerPath {
	[self sendHTTPRequestWithURLString:[@"http://www.thetvdb.com/banners/_cache/" stringByAppendingString:bannerPath] completionBlock:^ (NSData *data) {
		if (data) {
			[self finishedLoadingData:data];
			[self.cache cacheData:data forKey:[self cacheKeyForBannerPath:bannerPath]];
		}
	}];
}

- (NSString *)cacheKeyForBannerPath:(NSString *)bannerPath {
	return [bannerPath lastPathComponent];
}

- (void)finishedLoadingData:(NSData *)data {
	if (self.completionBlock) {
		dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^ {
			UIImage *banner = [UIImage imageWithData:data];
			[self completedWithBanner:banner];
		});
	}
}

- (void)completedWithBanner:(UIImage *)banner {
	dispatch_async(dispatch_get_main_queue(), ^ {
		if (self.completionBlock) {
			self.completionBlock(banner);
		}
	});
}

- (void)cancel {
	[super cancel];
	self.completionBlock = nil;
}

#pragma mark -

- (void)dealloc {
    self.completionBlock = nil;
	[super dealloc];
}

@end
