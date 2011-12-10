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

@property (nonatomic, retain) UIImage *banner;
@property (nonatomic, copy) NSString *currentBannerPath;

- (BOOL)loadSeriesBannerFromCache:(NSString *)bannerPath;
- (void)storeBannerData:(NSData *)bannerData bannerPath:(NSString *)bannerPath;
- (void)loadSeriesBannerFromServer:(NSString *)bannerPath;
- (NSString *)cachePathForBanner:(NSString *)bannerPath;

@end


@implementation SeriesBannerLoader

@synthesize delegate, banner, currentBannerPath;

- (void)loadSeriesBanner:(NSString *)bannerPath {	
	if (![self loadSeriesBannerFromCache:bannerPath]) {
		[self loadSeriesBannerFromServer:bannerPath];
	}
}

- (BOOL)loadSeriesBannerFromCache:(NSString *)bannerPath {
	NSString *cachedBanner= [self cachePathForBanner:bannerPath];
	if ([[NSFileManager defaultManager] isReadableFileAtPath:cachedBanner]) {
		self.banner= [UIImage imageWithContentsOfFile:cachedBanner];
		[self.delegate loadedSeriesBanner:self.banner];
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
	self.banner = [UIImage imageWithData:newData];
	[self.delegate loadedSeriesBanner:self.banner];
	[self storeBannerData:newData bannerPath:self.currentBannerPath];
}

- (void)connectionFailed {
	self.banner = nil;
	self.currentBannerPath = nil;
}

#pragma mark -

- (void)dealloc {
	self.banner = nil;
	self.currentBannerPath = nil;
	[super dealloc];
}


@end
