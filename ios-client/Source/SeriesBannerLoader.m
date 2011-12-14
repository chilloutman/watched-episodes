//
//  SeriesBannerModel.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/23/11.
//  Copyright 2011 Lucas Neiva. All rights reserved.
//

#import "SeriesBannerLoader.h"
#import "FileHelper.h"


@interface SeriesBannerLoader () <ProtocolBuffersFetcherDelegate>

@property (nonatomic, copy) NSString *currentBannerPath;
@property (nonatomic, copy) ImageBlock completionBlock;

- (BOOL)loadSeriesBannerFromCache:(NSString *)bannerPath;
- (void)storeBannerData:(NSData *)bannerData bannerPath:(NSString *)bannerPath;
- (void)loadSeriesBannerFromServer:(NSString *)bannerPath;
- (NSString *)cachePathForBanner:(NSString *)bannerPath;

@end


@implementation SeriesBannerLoader

@synthesize currentBannerPath, completionBlock;

- (void)loadSeriesBannerForBannerPath:(NSString *)bannerPath completionBlock:(ImageBlock)block {
    self.completionBlock = block;
    if (![self loadSeriesBannerFromCache:bannerPath]) {
		[self loadSeriesBannerFromServer:bannerPath];
	}
}

- (BOOL)loadSeriesBannerFromCache:(NSString *)bannerPath {
	NSString *cachedBanner= [self cachePathForBanner:bannerPath];
	if ([[NSFileManager defaultManager] isReadableFileAtPath:cachedBanner]) {
		self.completionBlock([UIImage imageWithContentsOfFile:cachedBanner]);
        self.completionBlock = nil;
		return YES;
	} else {
		return NO;
	}
}

- (void)loadSeriesBannerFromServer:(NSString *)bannerPath {
	self.currentBannerPath = bannerPath;
	[self.fetcher sendProtocolBuffersRequestWithURLString:[@"http://www.thetvdb.com/banners/" stringByAppendingString:bannerPath] delegate:self];
}

- (void)storeBannerData:(NSData *)bannerData bannerPath:(NSString *)bannerPath {
	[[NSFileManager defaultManager] createFileAtPath:[self cachePathForBanner:bannerPath] contents:bannerData attributes:nil];
}

- (NSString *)cachePathForBanner:(NSString *)bannerPath {
	NSString *bannersDirectory= [FileHelper cachesDirectoryNamed:@"banners"];
	NSString *bannerSubDirectory= [bannersDirectory stringByAppendingPathComponent:[bannerPath stringByDeletingLastPathComponent]];
	if ([FileHelper createDirectoryAtPath:bannerSubDirectory]) {
		return [bannersDirectory stringByAppendingPathComponent:bannerPath];
	} else {
		return nil;
	}
}

#pragma mark ProtocolBuffersFetcherDelegate

- (void)processData:(NSData *)newData {
    self.completionBlock([UIImage imageWithData:newData]);
	[self storeBannerData:newData bannerPath:self.currentBannerPath];
}

- (void)connectionFailed {
	self.currentBannerPath = nil;
}

#pragma mark -

- (void)dealloc {
	self.currentBannerPath = nil;
    self.completionBlock = nil;
	[super dealloc];
}


@end
