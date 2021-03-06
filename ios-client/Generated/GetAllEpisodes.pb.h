// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "ProtocolBuffers.h"

#import "ProtocolTypes.pb.h"

@class GetAllEpisodesResponse;
@class GetAllEpisodesResponse_Builder;
@class PBEpisode;
@class PBEpisode_Builder;
@class PBSeries;
@class PBSeriesSummary;
@class PBSeriesSummary_Builder;
@class PBSeries_Builder;

@interface GetAllEpisodesRoot : NSObject {
}
+ (PBExtensionRegistry*) extensionRegistry;
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry;
@end

@interface GetAllEpisodesResponse : PBGeneratedMessage {
@private
  NSMutableArray* mutableEpisodesList;
}
- (NSArray*) episodesList;
- (PBEpisode*) episodesAtIndex:(int32_t) index;

+ (GetAllEpisodesResponse*) defaultInstance;
- (GetAllEpisodesResponse*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (GetAllEpisodesResponse_Builder*) builder;
+ (GetAllEpisodesResponse_Builder*) builder;
+ (GetAllEpisodesResponse_Builder*) builderWithPrototype:(GetAllEpisodesResponse*) prototype;

+ (GetAllEpisodesResponse*) parseFromData:(NSData*) data;
+ (GetAllEpisodesResponse*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (GetAllEpisodesResponse*) parseFromInputStream:(NSInputStream*) input;
+ (GetAllEpisodesResponse*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (GetAllEpisodesResponse*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (GetAllEpisodesResponse*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface GetAllEpisodesResponse_Builder : PBGeneratedMessage_Builder {
@private
  GetAllEpisodesResponse* result;
}

- (GetAllEpisodesResponse*) defaultInstance;

- (GetAllEpisodesResponse_Builder*) clear;
- (GetAllEpisodesResponse_Builder*) clone;

- (GetAllEpisodesResponse*) build;
- (GetAllEpisodesResponse*) buildPartial;

- (GetAllEpisodesResponse_Builder*) mergeFrom:(GetAllEpisodesResponse*) other;
- (GetAllEpisodesResponse_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (GetAllEpisodesResponse_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (NSArray*) episodesList;
- (PBEpisode*) episodesAtIndex:(int32_t) index;
- (GetAllEpisodesResponse_Builder*) replaceEpisodesAtIndex:(int32_t) index with:(PBEpisode*) value;
- (GetAllEpisodesResponse_Builder*) addEpisodes:(PBEpisode*) value;
- (GetAllEpisodesResponse_Builder*) addAllEpisodes:(NSArray*) values;
- (GetAllEpisodesResponse_Builder*) clearEpisodesList;
@end

