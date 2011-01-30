// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "GetAllEpisodes.pb.h"

@implementation GetAllEpisodesRoot
static PBExtensionRegistry* extensionRegistry = nil;
+ (PBExtensionRegistry*) extensionRegistry {
  return extensionRegistry;
}

+ (void) initialize {
  if (self == [GetAllEpisodesRoot class]) {
    PBMutableExtensionRegistry* registry = [PBMutableExtensionRegistry registry];
    [self registerAllExtensions:registry];
    [ProtocolTypesRoot registerAllExtensions:registry];
    extensionRegistry = [registry retain];
  }
}
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry {
}
@end

@interface GetAllEpisodesResponse ()
@property (retain) NSMutableArray* mutableEpisodesList;
@end

@implementation GetAllEpisodesResponse

@synthesize mutableEpisodesList;
- (void) dealloc {
  self.mutableEpisodesList = nil;
  [super dealloc];
}
- (id) init {
  if ((self = [super init])) {
  }
  return self;
}
static GetAllEpisodesResponse* defaultGetAllEpisodesResponseInstance = nil;
+ (void) initialize {
  if (self == [GetAllEpisodesResponse class]) {
    defaultGetAllEpisodesResponseInstance = [[GetAllEpisodesResponse alloc] init];
  }
}
+ (GetAllEpisodesResponse*) defaultInstance {
  return defaultGetAllEpisodesResponseInstance;
}
- (GetAllEpisodesResponse*) defaultInstance {
  return defaultGetAllEpisodesResponseInstance;
}
- (NSArray*) episodesList {
  return mutableEpisodesList;
}
- (PBEpisode*) episodesAtIndex:(int32_t) index {
  id value = [mutableEpisodesList objectAtIndex:index];
  return value;
}
- (BOOL) isInitialized {
  for (PBEpisode* element in self.episodesList) {
    if (!element.isInitialized) {
      return NO;
    }
  }
  return YES;
}
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output {
  for (PBEpisode* element in self.episodesList) {
    [output writeMessage:1 value:element];
  }
  [self.unknownFields writeToCodedOutputStream:output];
}
- (int32_t) serializedSize {
  int32_t size = memoizedSerializedSize;
  if (size != -1) {
    return size;
  }

  size = 0;
  for (PBEpisode* element in self.episodesList) {
    size += computeMessageSize(1, element);
  }
  size += self.unknownFields.serializedSize;
  memoizedSerializedSize = size;
  return size;
}
+ (GetAllEpisodesResponse*) parseFromData:(NSData*) data {
  return (GetAllEpisodesResponse*)[[[GetAllEpisodesResponse builder] mergeFromData:data] build];
}
+ (GetAllEpisodesResponse*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (GetAllEpisodesResponse*)[[[GetAllEpisodesResponse builder] mergeFromData:data extensionRegistry:extensionRegistry] build];
}
+ (GetAllEpisodesResponse*) parseFromInputStream:(NSInputStream*) input {
  return (GetAllEpisodesResponse*)[[[GetAllEpisodesResponse builder] mergeFromInputStream:input] build];
}
+ (GetAllEpisodesResponse*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (GetAllEpisodesResponse*)[[[GetAllEpisodesResponse builder] mergeFromInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (GetAllEpisodesResponse*) parseFromCodedInputStream:(PBCodedInputStream*) input {
  return (GetAllEpisodesResponse*)[[[GetAllEpisodesResponse builder] mergeFromCodedInputStream:input] build];
}
+ (GetAllEpisodesResponse*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (GetAllEpisodesResponse*)[[[GetAllEpisodesResponse builder] mergeFromCodedInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (GetAllEpisodesResponse_Builder*) builder {
  return [[[GetAllEpisodesResponse_Builder alloc] init] autorelease];
}
+ (GetAllEpisodesResponse_Builder*) builderWithPrototype:(GetAllEpisodesResponse*) prototype {
  return [[GetAllEpisodesResponse builder] mergeFrom:prototype];
}
- (GetAllEpisodesResponse_Builder*) builder {
  return [GetAllEpisodesResponse builder];
}
@end

@interface GetAllEpisodesResponse_Builder()
@property (retain) GetAllEpisodesResponse* result;
@end

@implementation GetAllEpisodesResponse_Builder
@synthesize result;
- (void) dealloc {
  self.result = nil;
  [super dealloc];
}
- (id) init {
  if ((self = [super init])) {
    self.result = [[[GetAllEpisodesResponse alloc] init] autorelease];
  }
  return self;
}
- (PBGeneratedMessage*) internalGetResult {
  return result;
}
- (GetAllEpisodesResponse_Builder*) clear {
  self.result = [[[GetAllEpisodesResponse alloc] init] autorelease];
  return self;
}
- (GetAllEpisodesResponse_Builder*) clone {
  return [GetAllEpisodesResponse builderWithPrototype:result];
}
- (GetAllEpisodesResponse*) defaultInstance {
  return [GetAllEpisodesResponse defaultInstance];
}
- (GetAllEpisodesResponse*) build {
  [self checkInitialized];
  return [self buildPartial];
}
- (GetAllEpisodesResponse*) buildPartial {
  GetAllEpisodesResponse* returnMe = [[result retain] autorelease];
  self.result = nil;
  return returnMe;
}
- (GetAllEpisodesResponse_Builder*) mergeFrom:(GetAllEpisodesResponse*) other {
  if (other == [GetAllEpisodesResponse defaultInstance]) {
    return self;
  }
  if (other.mutableEpisodesList.count > 0) {
    if (result.mutableEpisodesList == nil) {
      result.mutableEpisodesList = [NSMutableArray array];
    }
    [result.mutableEpisodesList addObjectsFromArray:other.mutableEpisodesList];
  }
  [self mergeUnknownFields:other.unknownFields];
  return self;
}
- (GetAllEpisodesResponse_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input {
  return [self mergeFromCodedInputStream:input extensionRegistry:[PBExtensionRegistry emptyRegistry]];
}
- (GetAllEpisodesResponse_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  PBUnknownFieldSet_Builder* unknownFields = [PBUnknownFieldSet builderWithUnknownFields:self.unknownFields];
  while (YES) {
    int32_t tag = [input readTag];
    switch (tag) {
      case 0:
        [self setUnknownFields:[unknownFields build]];
        return self;
      default: {
        if (![self parseUnknownField:input unknownFields:unknownFields extensionRegistry:extensionRegistry tag:tag]) {
          [self setUnknownFields:[unknownFields build]];
          return self;
        }
        break;
      }
      case 10: {
        PBEpisode_Builder* subBuilder = [PBEpisode builder];
        [input readMessage:subBuilder extensionRegistry:extensionRegistry];
        [self addEpisodes:[subBuilder buildPartial]];
        break;
      }
    }
  }
}
- (NSArray*) episodesList {
  if (result.mutableEpisodesList == nil) { return [NSArray array]; }
  return result.mutableEpisodesList;
}
- (PBEpisode*) episodesAtIndex:(int32_t) index {
  return [result episodesAtIndex:index];
}
- (GetAllEpisodesResponse_Builder*) replaceEpisodesAtIndex:(int32_t) index with:(PBEpisode*) value {
  [result.mutableEpisodesList replaceObjectAtIndex:index withObject:value];
  return self;
}
- (GetAllEpisodesResponse_Builder*) addAllEpisodes:(NSArray*) values {
  if (result.mutableEpisodesList == nil) {
    result.mutableEpisodesList = [NSMutableArray array];
  }
  [result.mutableEpisodesList addObjectsFromArray:values];
  return self;
}
- (GetAllEpisodesResponse_Builder*) clearEpisodesList {
  result.mutableEpisodesList = nil;
  return self;
}
- (GetAllEpisodesResponse_Builder*) addEpisodes:(PBEpisode*) value {
  if (result.mutableEpisodesList == nil) {
    result.mutableEpisodesList = [NSMutableArray array];
  }
  [result.mutableEpisodesList addObject:value];
  return self;
}
@end

