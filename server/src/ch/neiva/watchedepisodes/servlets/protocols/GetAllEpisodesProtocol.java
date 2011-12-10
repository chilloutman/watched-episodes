// Generated by the protocol buffer compiler.  DO NOT EDIT!

package ch.neiva.watchedepisodes.servlets.protocols;

public final class GetAllEpisodesProtocol {
  private GetAllEpisodesProtocol() {}
  public static void registerAllExtensions(
      com.google.protobuf.ExtensionRegistry registry) {
  }
  public static final class GetAllEpisodesResponse extends
      com.google.protobuf.GeneratedMessage {
    // Use GetAllEpisodesResponse.newBuilder() to construct.
    private GetAllEpisodesResponse() {}
    
    private static final GetAllEpisodesResponse defaultInstance = new GetAllEpisodesResponse();
    public static GetAllEpisodesResponse getDefaultInstance() {
      return defaultInstance;
    }
    
    public GetAllEpisodesResponse getDefaultInstanceForType() {
      return defaultInstance;
    }
    
    public static final com.google.protobuf.Descriptors.Descriptor
        getDescriptor() {
      return ch.neiva.watchedepisodes.servlets.protocols.GetAllEpisodesProtocol.internal_static_GetAllEpisodesResponse_descriptor;
    }
    
    protected com.google.protobuf.GeneratedMessage.FieldAccessorTable
        internalGetFieldAccessorTable() {
      return ch.neiva.watchedepisodes.servlets.protocols.GetAllEpisodesProtocol.internal_static_GetAllEpisodesResponse_fieldAccessorTable;
    }
    
    // repeated .PBEpisode episodes = 1;
    public static final int EPISODES_FIELD_NUMBER = 1;
    private java.util.List<ch.neiva.watchedepisodes.servlets.protocols.ProtocolTypes.PBEpisode> episodes_ =
      java.util.Collections.emptyList();
    public java.util.List<ch.neiva.watchedepisodes.servlets.protocols.ProtocolTypes.PBEpisode> getEpisodesList() {
      return episodes_;
    }
    public int getEpisodesCount() { return episodes_.size(); }
    public ch.neiva.watchedepisodes.servlets.protocols.ProtocolTypes.PBEpisode getEpisodes(int index) {
      return episodes_.get(index);
    }
    
    public final boolean isInitialized() {
      for (ch.neiva.watchedepisodes.servlets.protocols.ProtocolTypes.PBEpisode element : getEpisodesList()) {
        if (!element.isInitialized()) return false;
      }
      return true;
    }
    
    public void writeTo(com.google.protobuf.CodedOutputStream output)
                        throws java.io.IOException {
      for (ch.neiva.watchedepisodes.servlets.protocols.ProtocolTypes.PBEpisode element : getEpisodesList()) {
        output.writeMessage(1, element);
      }
      getUnknownFields().writeTo(output);
    }
    
    private int memoizedSerializedSize = -1;
    public int getSerializedSize() {
      int size = memoizedSerializedSize;
      if (size != -1) return size;
    
      size = 0;
      for (ch.neiva.watchedepisodes.servlets.protocols.ProtocolTypes.PBEpisode element : getEpisodesList()) {
        size += com.google.protobuf.CodedOutputStream
          .computeMessageSize(1, element);
      }
      size += getUnknownFields().getSerializedSize();
      memoizedSerializedSize = size;
      return size;
    }
    
    public static ch.neiva.watchedepisodes.servlets.protocols.GetAllEpisodesProtocol.GetAllEpisodesResponse parseFrom(
        com.google.protobuf.ByteString data)
        throws com.google.protobuf.InvalidProtocolBufferException {
      return newBuilder().mergeFrom(data).buildParsed();
    }
    public static ch.neiva.watchedepisodes.servlets.protocols.GetAllEpisodesProtocol.GetAllEpisodesResponse parseFrom(
        com.google.protobuf.ByteString data,
        com.google.protobuf.ExtensionRegistryLite extensionRegistry)
        throws com.google.protobuf.InvalidProtocolBufferException {
      return newBuilder().mergeFrom(data, extensionRegistry)
               .buildParsed();
    }
    public static ch.neiva.watchedepisodes.servlets.protocols.GetAllEpisodesProtocol.GetAllEpisodesResponse parseFrom(byte[] data)
        throws com.google.protobuf.InvalidProtocolBufferException {
      return newBuilder().mergeFrom(data).buildParsed();
    }
    public static ch.neiva.watchedepisodes.servlets.protocols.GetAllEpisodesProtocol.GetAllEpisodesResponse parseFrom(
        byte[] data,
        com.google.protobuf.ExtensionRegistryLite extensionRegistry)
        throws com.google.protobuf.InvalidProtocolBufferException {
      return newBuilder().mergeFrom(data, extensionRegistry)
               .buildParsed();
    }
    public static ch.neiva.watchedepisodes.servlets.protocols.GetAllEpisodesProtocol.GetAllEpisodesResponse parseFrom(java.io.InputStream input)
        throws java.io.IOException {
      return newBuilder().mergeFrom(input).buildParsed();
    }
    public static ch.neiva.watchedepisodes.servlets.protocols.GetAllEpisodesProtocol.GetAllEpisodesResponse parseFrom(
        java.io.InputStream input,
        com.google.protobuf.ExtensionRegistryLite extensionRegistry)
        throws java.io.IOException {
      return newBuilder().mergeFrom(input, extensionRegistry)
               .buildParsed();
    }
    public static ch.neiva.watchedepisodes.servlets.protocols.GetAllEpisodesProtocol.GetAllEpisodesResponse parseDelimitedFrom(java.io.InputStream input)
        throws java.io.IOException {
      return newBuilder().mergeDelimitedFrom(input).buildParsed();
    }
    public static ch.neiva.watchedepisodes.servlets.protocols.GetAllEpisodesProtocol.GetAllEpisodesResponse parseDelimitedFrom(
        java.io.InputStream input,
        com.google.protobuf.ExtensionRegistryLite extensionRegistry)
        throws java.io.IOException {
      return newBuilder().mergeDelimitedFrom(input, extensionRegistry)
               .buildParsed();
    }
    public static ch.neiva.watchedepisodes.servlets.protocols.GetAllEpisodesProtocol.GetAllEpisodesResponse parseFrom(
        com.google.protobuf.CodedInputStream input)
        throws java.io.IOException {
      return newBuilder().mergeFrom(input).buildParsed();
    }
    public static ch.neiva.watchedepisodes.servlets.protocols.GetAllEpisodesProtocol.GetAllEpisodesResponse parseFrom(
        com.google.protobuf.CodedInputStream input,
        com.google.protobuf.ExtensionRegistryLite extensionRegistry)
        throws java.io.IOException {
      return newBuilder().mergeFrom(input, extensionRegistry)
               .buildParsed();
    }
    
    public static Builder newBuilder() { return Builder.create(); }
    public Builder newBuilderForType() { return newBuilder(); }
    public static Builder newBuilder(ch.neiva.watchedepisodes.servlets.protocols.GetAllEpisodesProtocol.GetAllEpisodesResponse prototype) {
      return newBuilder().mergeFrom(prototype);
    }
    public Builder toBuilder() { return newBuilder(this); }
    
    public static final class Builder extends
        com.google.protobuf.GeneratedMessage.Builder<Builder> {
      private ch.neiva.watchedepisodes.servlets.protocols.GetAllEpisodesProtocol.GetAllEpisodesResponse result;
      
      // Construct using watchedepisodes.servlets.protocols.GetAllEpisodesProtocol.GetAllEpisodesResponse.newBuilder()
      private Builder() {}
      
      private static Builder create() {
        Builder builder = new Builder();
        builder.result = new ch.neiva.watchedepisodes.servlets.protocols.GetAllEpisodesProtocol.GetAllEpisodesResponse();
        return builder;
      }
      
      protected ch.neiva.watchedepisodes.servlets.protocols.GetAllEpisodesProtocol.GetAllEpisodesResponse internalGetResult() {
        return result;
      }
      
      public Builder clear() {
        if (result == null) {
          throw new IllegalStateException(
            "Cannot call clear() after build().");
        }
        result = new ch.neiva.watchedepisodes.servlets.protocols.GetAllEpisodesProtocol.GetAllEpisodesResponse();
        return this;
      }
      
      public Builder clone() {
        return create().mergeFrom(result);
      }
      
      public com.google.protobuf.Descriptors.Descriptor
          getDescriptorForType() {
        return ch.neiva.watchedepisodes.servlets.protocols.GetAllEpisodesProtocol.GetAllEpisodesResponse.getDescriptor();
      }
      
      public ch.neiva.watchedepisodes.servlets.protocols.GetAllEpisodesProtocol.GetAllEpisodesResponse getDefaultInstanceForType() {
        return ch.neiva.watchedepisodes.servlets.protocols.GetAllEpisodesProtocol.GetAllEpisodesResponse.getDefaultInstance();
      }
      
      public boolean isInitialized() {
        return result.isInitialized();
      }
      public ch.neiva.watchedepisodes.servlets.protocols.GetAllEpisodesProtocol.GetAllEpisodesResponse build() {
        if (result != null && !isInitialized()) {
          throw newUninitializedMessageException(result);
        }
        return buildPartial();
      }
      
      private ch.neiva.watchedepisodes.servlets.protocols.GetAllEpisodesProtocol.GetAllEpisodesResponse buildParsed()
          throws com.google.protobuf.InvalidProtocolBufferException {
        if (!isInitialized()) {
          throw newUninitializedMessageException(
            result).asInvalidProtocolBufferException();
        }
        return buildPartial();
      }
      
      public ch.neiva.watchedepisodes.servlets.protocols.GetAllEpisodesProtocol.GetAllEpisodesResponse buildPartial() {
        if (result == null) {
          throw new IllegalStateException(
            "build() has already been called on this Builder.");
        }
        if (result.episodes_ != java.util.Collections.EMPTY_LIST) {
          result.episodes_ =
            java.util.Collections.unmodifiableList(result.episodes_);
        }
        ch.neiva.watchedepisodes.servlets.protocols.GetAllEpisodesProtocol.GetAllEpisodesResponse returnMe = result;
        result = null;
        return returnMe;
      }
      
      public Builder mergeFrom(com.google.protobuf.Message other) {
        if (other instanceof ch.neiva.watchedepisodes.servlets.protocols.GetAllEpisodesProtocol.GetAllEpisodesResponse) {
          return mergeFrom((ch.neiva.watchedepisodes.servlets.protocols.GetAllEpisodesProtocol.GetAllEpisodesResponse)other);
        } else {
          super.mergeFrom(other);
          return this;
        }
      }
      
      public Builder mergeFrom(ch.neiva.watchedepisodes.servlets.protocols.GetAllEpisodesProtocol.GetAllEpisodesResponse other) {
        if (other == ch.neiva.watchedepisodes.servlets.protocols.GetAllEpisodesProtocol.GetAllEpisodesResponse.getDefaultInstance()) return this;
        if (!other.episodes_.isEmpty()) {
          if (result.episodes_.isEmpty()) {
            result.episodes_ = new java.util.ArrayList<ch.neiva.watchedepisodes.servlets.protocols.ProtocolTypes.PBEpisode>();
          }
          result.episodes_.addAll(other.episodes_);
        }
        this.mergeUnknownFields(other.getUnknownFields());
        return this;
      }
      
      public Builder mergeFrom(
          com.google.protobuf.CodedInputStream input,
          com.google.protobuf.ExtensionRegistryLite extensionRegistry)
          throws java.io.IOException {
        com.google.protobuf.UnknownFieldSet.Builder unknownFields =
          com.google.protobuf.UnknownFieldSet.newBuilder(
            this.getUnknownFields());
        while (true) {
          int tag = input.readTag();
          switch (tag) {
            case 0:
              this.setUnknownFields(unknownFields.build());
              return this;
            default: {
              if (!parseUnknownField(input, unknownFields,
                                     extensionRegistry, tag)) {
                this.setUnknownFields(unknownFields.build());
                return this;
              }
              break;
            }
            case 10: {
              ch.neiva.watchedepisodes.servlets.protocols.ProtocolTypes.PBEpisode.Builder subBuilder = ch.neiva.watchedepisodes.servlets.protocols.ProtocolTypes.PBEpisode.newBuilder();
              input.readMessage(subBuilder, extensionRegistry);
              addEpisodes(subBuilder.buildPartial());
              break;
            }
          }
        }
      }
      
      
      // repeated .PBEpisode episodes = 1;
      public java.util.List<ch.neiva.watchedepisodes.servlets.protocols.ProtocolTypes.PBEpisode> getEpisodesList() {
        return java.util.Collections.unmodifiableList(result.episodes_);
      }
      public int getEpisodesCount() {
        return result.getEpisodesCount();
      }
      public ch.neiva.watchedepisodes.servlets.protocols.ProtocolTypes.PBEpisode getEpisodes(int index) {
        return result.getEpisodes(index);
      }
      public Builder setEpisodes(int index, ch.neiva.watchedepisodes.servlets.protocols.ProtocolTypes.PBEpisode value) {
        if (value == null) {
          throw new NullPointerException();
        }
        result.episodes_.set(index, value);
        return this;
      }
      public Builder setEpisodes(int index, ch.neiva.watchedepisodes.servlets.protocols.ProtocolTypes.PBEpisode.Builder builderForValue) {
        result.episodes_.set(index, builderForValue.build());
        return this;
      }
      public Builder addEpisodes(ch.neiva.watchedepisodes.servlets.protocols.ProtocolTypes.PBEpisode value) {
        if (value == null) {
          throw new NullPointerException();
        }
        if (result.episodes_.isEmpty()) {
          result.episodes_ = new java.util.ArrayList<ch.neiva.watchedepisodes.servlets.protocols.ProtocolTypes.PBEpisode>();
        }
        result.episodes_.add(value);
        return this;
      }
      public Builder addEpisodes(ch.neiva.watchedepisodes.servlets.protocols.ProtocolTypes.PBEpisode.Builder builderForValue) {
        if (result.episodes_.isEmpty()) {
          result.episodes_ = new java.util.ArrayList<ch.neiva.watchedepisodes.servlets.protocols.ProtocolTypes.PBEpisode>();
        }
        result.episodes_.add(builderForValue.build());
        return this;
      }
      public Builder addAllEpisodes(
          java.lang.Iterable<? extends ch.neiva.watchedepisodes.servlets.protocols.ProtocolTypes.PBEpisode> values) {
        if (result.episodes_.isEmpty()) {
          result.episodes_ = new java.util.ArrayList<ch.neiva.watchedepisodes.servlets.protocols.ProtocolTypes.PBEpisode>();
        }
        super.addAll(values, result.episodes_);
        return this;
      }
      public Builder clearEpisodes() {
        result.episodes_ = java.util.Collections.emptyList();
        return this;
      }
    }
    
    static {
      ch.neiva.watchedepisodes.servlets.protocols.GetAllEpisodesProtocol.getDescriptor();
    }
    
    static {
      ch.neiva.watchedepisodes.servlets.protocols.GetAllEpisodesProtocol.internalForceInit();
    }
  }
  
  private static com.google.protobuf.Descriptors.Descriptor
    internal_static_GetAllEpisodesResponse_descriptor;
  private static
    com.google.protobuf.GeneratedMessage.FieldAccessorTable
      internal_static_GetAllEpisodesResponse_fieldAccessorTable;
  
  public static com.google.protobuf.Descriptors.FileDescriptor
      getDescriptor() {
    return descriptor;
  }
  private static com.google.protobuf.Descriptors.FileDescriptor
      descriptor;
  static {
    java.lang.String[] descriptorData = {
      "\n\026get_all_episodes.proto\032\024protocol_types" +
      ".proto\"6\n\026GetAllEpisodesResponse\022\034\n\010epis" +
      "odes\030\001 \003(\0132\n.PBEpisodeB<\n\"watchedepisode" +
      "s.servlets.protocolsB\026GetAllEpisodesProt" +
      "ocol"
    };
    com.google.protobuf.Descriptors.FileDescriptor.InternalDescriptorAssigner assigner =
      new com.google.protobuf.Descriptors.FileDescriptor.InternalDescriptorAssigner() {
        public com.google.protobuf.ExtensionRegistry assignDescriptors(
            com.google.protobuf.Descriptors.FileDescriptor root) {
          descriptor = root;
          internal_static_GetAllEpisodesResponse_descriptor =
            getDescriptor().getMessageTypes().get(0);
          internal_static_GetAllEpisodesResponse_fieldAccessorTable = new
            com.google.protobuf.GeneratedMessage.FieldAccessorTable(
              internal_static_GetAllEpisodesResponse_descriptor,
              new java.lang.String[] { "Episodes", },
              ch.neiva.watchedepisodes.servlets.protocols.GetAllEpisodesProtocol.GetAllEpisodesResponse.class,
              ch.neiva.watchedepisodes.servlets.protocols.GetAllEpisodesProtocol.GetAllEpisodesResponse.Builder.class);
          return null;
        }
      };
    com.google.protobuf.Descriptors.FileDescriptor
      .internalBuildGeneratedFileFrom(descriptorData,
        new com.google.protobuf.Descriptors.FileDescriptor[] {
          ch.neiva.watchedepisodes.servlets.protocols.ProtocolTypes.getDescriptor(),
        }, assigner);
  }
  
  public static void internalForceInit() {}
}