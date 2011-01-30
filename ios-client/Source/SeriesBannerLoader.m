//
//  SeriesBannerModel.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 1/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SeriesBannerLoader.h"
#import "ServiceLocator.h"
#import "CommunicationAgent.h"
#import "FileHelper.h"


@interface SeriesBannerLoader () <CommunicationDelegate>

@property (nonatomic, retain) UIImage *banner;

- (BOOL)loadSeriesBannerFromCache:(NSString *)bannerPath;
- (void)storeBannerData:(NSData *)bannerData bannerPath:(NSString *)bannerPath;
- (void)loadSeriesBannerFromServer:(NSString *)bannerPath;
- (NSString *)cachePathForBanner:(NSString *)bannerPath;

@end


@implementation SeriesBannerLoader

@synthesize delegate, banner;

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
	NSURL *url= [NSURL URLWithString:[@"http://www.thetvdb.com/banners/" stringByAppendingString:bannerPath]];
	CommunicationAgent *com= [ServiceLocator singletonForClass:[CommunicationAgent class]];
	[com sendProtocolBuffersGETRequestWithURL:url requestId:bannerPath delegate:self];
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

#pragma mark CommunicationDelegate

- (void)receivedResponse:(NSData *)responseData requestId:(NSString *)bannerPath {
	self.banner= [UIImage imageWithData:responseData];
	[self storeBannerData:responseData bannerPath:bannerPath];
}

- (void)requestDidSucceed:(NSString *)requestId {
	[self.delegate loadedSeriesBanner:self.banner];
}

- (void)requestDidFail:(NSString *)requestId {
	self.banner= nil;
}

#pragma mark -

- (void)dealloc {
	self.banner= nil;
	[super dealloc];
}


@end
