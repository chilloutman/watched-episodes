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
@property (nonatomic, copy) ImageHandler completionHandler;

- (BOOL)loadSeriesBannerFromCache:(NSString *)bannerPath;
- (void)storeBannerData:(NSData *)bannerData bannerPath:(NSString *)bannerPath;
- (void)loadSeriesBannerFromServer:(NSString *)bannerPath;
- (NSString *)cachePathForBanner:(NSString *)bannerPath;

@end


@implementation SeriesBannerLoader

@synthesize currentBannerPath, completionHandler;

- (void)loadSeriesBanner:(NSString *)bannerPath withHandler:(ImageHandler)handler {
    self.completionHandler = handler;
    if (![self loadSeriesBannerFromCache:bannerPath]) {
		[self loadSeriesBannerFromServer:bannerPath];
	}
}

- (BOOL)loadSeriesBannerFromCache:(NSString *)bannerPath {
	NSString *cachedBanner= [self cachePathForBanner:bannerPath];
	if ([[NSFileManager defaultManager] isReadableFileAtPath:cachedBanner]) {
		self.completionHandler([UIImage imageWithContentsOfFile:cachedBanner]);
        self.completionHandler = nil;
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
    self.completionHandler([UIImage imageWithData:newData]);
	[self storeBannerData:newData bannerPath:self.currentBannerPath];
}

- (void)connectionFailed {
	self.currentBannerPath = nil;
}

#pragma mark -

- (void)dealloc {
	self.currentBannerPath = nil;
    self.completionHandler = nil;
	[super dealloc];
}


@end
