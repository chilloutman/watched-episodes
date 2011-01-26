// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "ProtocolBuffers.h"

@class PBSearchResults;
@class PBSearchResults_Builder;
@class PBSeriesSummary;
@class PBSeriesSummary_Builder;

@interface SearchSeriesRoot : NSObject {
}
+ (PBExtensionRegistry*) extensionRegistry;
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry;
@end

@interface PBSearchResults : PBGeneratedMessage {
@private
  NSMutableArray* mutableSeriesList;
}
- (NSArray*) seriesList;
- (PBSeriesSummary*) seriesAtIndex:(int32_t) index;

+ (PBSearchResults*) defaultInstance;
- (PBSearchResults*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (PBSearchResults_Builder*) builder;
+ (PBSearchResults_Builder*) builder;
+ (PBSearchResults_Builder*) builderWithPrototype:(PBSearchResults*) prototype;

+ (PBSearchResults*) parseFromData:(NSData*) data;
+ (PBSearchResults*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (PBSearchResults*) parseFromInputStream:(NSInputStream*) input;
+ (PBSearchResults*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (PBSearchResults*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (PBSearchResults*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface PBSearchResults_Builder : PBGeneratedMessage_Builder {
@private
  PBSearchResults* result;
}

- (PBSearchResults*) defaultInstance;

- (PBSearchResults_Builder*) clear;
- (PBSearchResults_Builder*) clone;

- (PBSearchResults*) build;
- (PBSearchResults*) buildPartial;

- (PBSearchResults_Builder*) mergeFrom:(PBSearchResults*) other;
- (PBSearchResults_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (PBSearchResults_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (NSArray*) seriesList;
- (PBSeriesSummary*) seriesAtIndex:(int32_t) index;
- (PBSearchResults_Builder*) replaceSeriesAtIndex:(int32_t) index with:(PBSeriesSummary*) value;
- (PBSearchResults_Builder*) addSeries:(PBSeriesSummary*) value;
- (PBSearchResults_Builder*) addAllSeries:(NSArray*) values;
- (PBSearchResults_Builder*) clearSeriesList;
@end

@interface PBSeriesSummary : PBGeneratedMessage {
@private
  BOOL hasSeriesId_:1;
  BOOL hasSeriesName_:1;
  NSString* seriesId;
  NSString* seriesName;
}
- (BOOL) hasSeriesId;
- (BOOL) hasSeriesName;
@property (readonly, retain) NSString* seriesId;
@property (readonly, retain) NSString* seriesName;

+ (PBSeriesSummary*) defaultInstance;
- (PBSeriesSummary*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (PBSeriesSummary_Builder*) builder;
+ (PBSeriesSummary_Builder*) builder;
+ (PBSeriesSummary_Builder*) builderWithPrototype:(PBSeriesSummary*) prototype;

+ (PBSeriesSummary*) parseFromData:(NSData*) data;
+ (PBSeriesSummary*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (PBSeriesSummary*) parseFromInputStream:(NSInputStream*) input;
+ (PBSeriesSummary*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (PBSeriesSummary*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (PBSeriesSummary*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface PBSeriesSummary_Builder : PBGeneratedMessage_Builder {
@private
  PBSeriesSummary* result;
}

- (PBSeriesSummary*) defaultInstance;

- (PBSeriesSummary_Builder*) clear;
- (PBSeriesSummary_Builder*) clone;

- (PBSeriesSummary*) build;
- (PBSeriesSummary*) buildPartial;

- (PBSeriesSummary_Builder*) mergeFrom:(PBSeriesSummary*) other;
- (PBSeriesSummary_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (PBSeriesSummary_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasSeriesId;
- (NSString*) seriesId;
- (PBSeriesSummary_Builder*) setSeriesId:(NSString*) value;
- (PBSeriesSummary_Builder*) clearSeriesId;

- (BOOL) hasSeriesName;
- (NSString*) seriesName;
- (PBSeriesSummary_Builder*) setSeriesName:(NSString*) value;
- (PBSeriesSummary_Builder*) clearSeriesName;
@end

