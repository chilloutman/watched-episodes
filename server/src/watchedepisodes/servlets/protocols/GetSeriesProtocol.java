// Generated by the protocol buffer compiler.  DO NOT EDIT!

package watchedepisodes.servlets.protocols;

public final class GetSeriesProtocol {
  private GetSeriesProtocol() {}
  public static void registerAllExtensions(
      com.google.protobuf.ExtensionRegistry registry) {
  }
  public static final class PBSeries extends
      com.google.protobuf.GeneratedMessage {
    // Use PBSeries.newBuilder() to construct.
    private PBSeries() {}
    
    private static final PBSeries defaultInstance = new PBSeries();
    public static PBSeries getDefaultInstance() {
      return defaultInstance;
    }
    
    public PBSeries getDefaultInstanceForType() {
      return defaultInstance;
    }
    
    public static final com.google.protobuf.Descriptors.Descriptor
        getDescriptor() {
      return watchedepisodes.servlets.protocols.GetSeriesProtocol.internal_static_PBSeries_descriptor;
    }
    
    protected com.google.protobuf.GeneratedMessage.FieldAccessorTable
        internalGetFieldAccessorTable() {
      return watchedepisodes.servlets.protocols.GetSeriesProtocol.internal_static_PBSeries_fieldAccessorTable;
    }
    
    // required string seriesId = 1;
    public static final int SERIESID_FIELD_NUMBER = 1;
    private boolean hasSeriesId;
    private java.lang.String seriesId_ = "";
    public boolean hasSeriesId() { return hasSeriesId; }
    public java.lang.String getSeriesId() { return seriesId_; }
    
    // required string language = 2;
    public static final int LANGUAGE_FIELD_NUMBER = 2;
    private boolean hasLanguage;
    private java.lang.String language_ = "";
    public boolean hasLanguage() { return hasLanguage; }
    public java.lang.String getLanguage() { return language_; }
    
    // required string seriesName = 3;
    public static final int SERIESNAME_FIELD_NUMBER = 3;
    private boolean hasSeriesName;
    private java.lang.String seriesName_ = "";
    public boolean hasSeriesName() { return hasSeriesName; }
    public java.lang.String getSeriesName() { return seriesName_; }
    
    // required string overview = 4;
    public static final int OVERVIEW_FIELD_NUMBER = 4;
    private boolean hasOverview;
    private java.lang.String overview_ = "";
    public boolean hasOverview() { return hasOverview; }
    public java.lang.String getOverview() { return overview_; }
    
    // required string firstAired = 5;
    public static final int FIRSTAIRED_FIELD_NUMBER = 5;
    private boolean hasFirstAired;
    private java.lang.String firstAired_ = "";
    public boolean hasFirstAired() { return hasFirstAired; }
    public java.lang.String getFirstAired() { return firstAired_; }
    
    // repeated string actors = 6;
    public static final int ACTORS_FIELD_NUMBER = 6;
    private java.util.List<java.lang.String> actors_ =
      java.util.Collections.emptyList();
    public java.util.List<java.lang.String> getActorsList() {
      return actors_;
    }
    public int getActorsCount() { return actors_.size(); }
    public java.lang.String getActors(int index) {
      return actors_.get(index);
    }
    
    // required string banner = 7;
    public static final int BANNER_FIELD_NUMBER = 7;
    private boolean hasBanner;
    private java.lang.String banner_ = "";
    public boolean hasBanner() { return hasBanner; }
    public java.lang.String getBanner() { return banner_; }
    
    // required string imdbId = 8;
    public static final int IMDBID_FIELD_NUMBER = 8;
    private boolean hasImdbId;
    private java.lang.String imdbId_ = "";
    public boolean hasImdbId() { return hasImdbId; }
    public java.lang.String getImdbId() { return imdbId_; }
    
    public final boolean isInitialized() {
      if (!hasSeriesId) return false;
      if (!hasLanguage) return false;
      if (!hasSeriesName) return false;
      if (!hasOverview) return false;
      if (!hasFirstAired) return false;
      if (!hasBanner) return false;
      if (!hasImdbId) return false;
      return true;
    }
    
    public void writeTo(com.google.protobuf.CodedOutputStream output)
                        throws java.io.IOException {
      if (hasSeriesId()) {
        output.writeString(1, getSeriesId());
      }
      if (hasLanguage()) {
        output.writeString(2, getLanguage());
      }
      if (hasSeriesName()) {
        output.writeString(3, getSeriesName());
      }
      if (hasOverview()) {
        output.writeString(4, getOverview());
      }
      if (hasFirstAired()) {
        output.writeString(5, getFirstAired());
      }
      for (java.lang.String element : getActorsList()) {
        output.writeString(6, element);
      }
      if (hasBanner()) {
        output.writeString(7, getBanner());
      }
      if (hasImdbId()) {
        output.writeString(8, getImdbId());
      }
      getUnknownFields().writeTo(output);
    }
    
    private int memoizedSerializedSize = -1;
    public int getSerializedSize() {
      int size = memoizedSerializedSize;
      if (size != -1) return size;
    
      size = 0;
      if (hasSeriesId()) {
        size += com.google.protobuf.CodedOutputStream
          .computeStringSize(1, getSeriesId());
      }
      if (hasLanguage()) {
        size += com.google.protobuf.CodedOutputStream
          .computeStringSize(2, getLanguage());
      }
      if (hasSeriesName()) {
        size += com.google.protobuf.CodedOutputStream
          .computeStringSize(3, getSeriesName());
      }
      if (hasOverview()) {
        size += com.google.protobuf.CodedOutputStream
          .computeStringSize(4, getOverview());
      }
      if (hasFirstAired()) {
        size += com.google.protobuf.CodedOutputStream
          .computeStringSize(5, getFirstAired());
      }
      {
        int dataSize = 0;
        for (java.lang.String element : getActorsList()) {
          dataSize += com.google.protobuf.CodedOutputStream
            .computeStringSizeNoTag(element);
        }
        size += dataSize;
        size += 1 * getActorsList().size();
      }
      if (hasBanner()) {
        size += com.google.protobuf.CodedOutputStream
          .computeStringSize(7, getBanner());
      }
      if (hasImdbId()) {
        size += com.google.protobuf.CodedOutputStream
          .computeStringSize(8, getImdbId());
      }
      size += getUnknownFields().getSerializedSize();
      memoizedSerializedSize = size;
      return size;
    }
    
    public static watchedepisodes.servlets.protocols.GetSeriesProtocol.PBSeries parseFrom(
        com.google.protobuf.ByteString data)
        throws com.google.protobuf.InvalidProtocolBufferException {
      return newBuilder().mergeFrom(data).buildParsed();
    }
    public static watchedepisodes.servlets.protocols.GetSeriesProtocol.PBSeries parseFrom(
        com.google.protobuf.ByteString data,
        com.google.protobuf.ExtensionRegistryLite extensionRegistry)
        throws com.google.protobuf.InvalidProtocolBufferException {
      return newBuilder().mergeFrom(data, extensionRegistry)
               .buildParsed();
    }
    public static watchedepisodes.servlets.protocols.GetSeriesProtocol.PBSeries parseFrom(byte[] data)
        throws com.google.protobuf.InvalidProtocolBufferException {
      return newBuilder().mergeFrom(data).buildParsed();
    }
    public static watchedepisodes.servlets.protocols.GetSeriesProtocol.PBSeries parseFrom(
        byte[] data,
        com.google.protobuf.ExtensionRegistryLite extensionRegistry)
        throws com.google.protobuf.InvalidProtocolBufferException {
      return newBuilder().mergeFrom(data, extensionRegistry)
               .buildParsed();
    }
    public static watchedepisodes.servlets.protocols.GetSeriesProtocol.PBSeries parseFrom(java.io.InputStream input)
        throws java.io.IOException {
      return newBuilder().mergeFrom(input).buildParsed();
    }
    public static watchedepisodes.servlets.protocols.GetSeriesProtocol.PBSeries parseFrom(
        java.io.InputStream input,
        com.google.protobuf.ExtensionRegistryLite extensionRegistry)
        throws java.io.IOException {
      return newBuilder().mergeFrom(input, extensionRegistry)
               .buildParsed();
    }
    public static watchedepisodes.servlets.protocols.GetSeriesProtocol.PBSeries parseDelimitedFrom(java.io.InputStream input)
        throws java.io.IOException {
      return newBuilder().mergeDelimitedFrom(input).buildParsed();
    }
    public static watchedepisodes.servlets.protocols.GetSeriesProtocol.PBSeries parseDelimitedFrom(
        java.io.InputStream input,
        com.google.protobuf.ExtensionRegistryLite extensionRegistry)
        throws java.io.IOException {
      return newBuilder().mergeDelimitedFrom(input, extensionRegistry)
               .buildParsed();
    }
    public static watchedepisodes.servlets.protocols.GetSeriesProtocol.PBSeries parseFrom(
        com.google.protobuf.CodedInputStream input)
        throws java.io.IOException {
      return newBuilder().mergeFrom(input).buildParsed();
    }
    public static watchedepisodes.servlets.protocols.GetSeriesProtocol.PBSeries parseFrom(
        com.google.protobuf.CodedInputStream input,
        com.google.protobuf.ExtensionRegistryLite extensionRegistry)
        throws java.io.IOException {
      return newBuilder().mergeFrom(input, extensionRegistry)
               .buildParsed();
    }
    
    public static Builder newBuilder() { return Builder.create(); }
    public Builder newBuilderForType() { return newBuilder(); }
    public static Builder newBuilder(watchedepisodes.servlets.protocols.GetSeriesProtocol.PBSeries prototype) {
      return newBuilder().mergeFrom(prototype);
    }
    public Builder toBuilder() { return newBuilder(this); }
    
    public static final class Builder extends
        com.google.protobuf.GeneratedMessage.Builder<Builder> {
      private watchedepisodes.servlets.protocols.GetSeriesProtocol.PBSeries result;
      
      // Construct using watchedepisodes.servlets.protocols.GetSeriesProtocol.PBSeries.newBuilder()
      private Builder() {}
      
      private static Builder create() {
        Builder builder = new Builder();
        builder.result = new watchedepisodes.servlets.protocols.GetSeriesProtocol.PBSeries();
        return builder;
      }
      
      protected watchedepisodes.servlets.protocols.GetSeriesProtocol.PBSeries internalGetResult() {
        return result;
      }
      
      public Builder clear() {
        if (result == null) {
          throw new IllegalStateException(
            "Cannot call clear() after build().");
        }
        result = new watchedepisodes.servlets.protocols.GetSeriesProtocol.PBSeries();
        return this;
      }
      
      public Builder clone() {
        return create().mergeFrom(result);
      }
      
      public com.google.protobuf.Descriptors.Descriptor
          getDescriptorForType() {
        return watchedepisodes.servlets.protocols.GetSeriesProtocol.PBSeries.getDescriptor();
      }
      
      public watchedepisodes.servlets.protocols.GetSeriesProtocol.PBSeries getDefaultInstanceForType() {
        return watchedepisodes.servlets.protocols.GetSeriesProtocol.PBSeries.getDefaultInstance();
      }
      
      public boolean isInitialized() {
        return result.isInitialized();
      }
      public watchedepisodes.servlets.protocols.GetSeriesProtocol.PBSeries build() {
        if (result != null && !isInitialized()) {
          throw newUninitializedMessageException(result);
        }
        return buildPartial();
      }
      
      private watchedepisodes.servlets.protocols.GetSeriesProtocol.PBSeries buildParsed()
          throws com.google.protobuf.InvalidProtocolBufferException {
        if (!isInitialized()) {
          throw newUninitializedMessageException(
            result).asInvalidProtocolBufferException();
        }
        return buildPartial();
      }
      
      public watchedepisodes.servlets.protocols.GetSeriesProtocol.PBSeries buildPartial() {
        if (result == null) {
          throw new IllegalStateException(
            "build() has already been called on this Builder.");
        }
        if (result.actors_ != java.util.Collections.EMPTY_LIST) {
          result.actors_ =
            java.util.Collections.unmodifiableList(result.actors_);
        }
        watchedepisodes.servlets.protocols.GetSeriesProtocol.PBSeries returnMe = result;
        result = null;
        return returnMe;
      }
      
      public Builder mergeFrom(com.google.protobuf.Message other) {
        if (other instanceof watchedepisodes.servlets.protocols.GetSeriesProtocol.PBSeries) {
          return mergeFrom((watchedepisodes.servlets.protocols.GetSeriesProtocol.PBSeries)other);
        } else {
          super.mergeFrom(other);
          return this;
        }
      }
      
      public Builder mergeFrom(watchedepisodes.servlets.protocols.GetSeriesProtocol.PBSeries other) {
        if (other == watchedepisodes.servlets.protocols.GetSeriesProtocol.PBSeries.getDefaultInstance()) return this;
        if (other.hasSeriesId()) {
          setSeriesId(other.getSeriesId());
        }
        if (other.hasLanguage()) {
          setLanguage(other.getLanguage());
        }
        if (other.hasSeriesName()) {
          setSeriesName(other.getSeriesName());
        }
        if (other.hasOverview()) {
          setOverview(other.getOverview());
        }
        if (other.hasFirstAired()) {
          setFirstAired(other.getFirstAired());
        }
        if (!other.actors_.isEmpty()) {
          if (result.actors_.isEmpty()) {
            result.actors_ = new java.util.ArrayList<java.lang.String>();
          }
          result.actors_.addAll(other.actors_);
        }
        if (other.hasBanner()) {
          setBanner(other.getBanner());
        }
        if (other.hasImdbId()) {
          setImdbId(other.getImdbId());
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
              setSeriesId(input.readString());
              break;
            }
            case 18: {
              setLanguage(input.readString());
              break;
            }
            case 26: {
              setSeriesName(input.readString());
              break;
            }
            case 34: {
              setOverview(input.readString());
              break;
            }
            case 42: {
              setFirstAired(input.readString());
              break;
            }
            case 50: {
              addActors(input.readString());
              break;
            }
            case 58: {
              setBanner(input.readString());
              break;
            }
            case 66: {
              setImdbId(input.readString());
              break;
            }
          }
        }
      }
      
      
      // required string seriesId = 1;
      public boolean hasSeriesId() {
        return result.hasSeriesId();
      }
      public java.lang.String getSeriesId() {
        return result.getSeriesId();
      }
      public Builder setSeriesId(java.lang.String value) {
        if (value == null) {
    throw new NullPointerException();
  }
  result.hasSeriesId = true;
        result.seriesId_ = value;
        return this;
      }
      public Builder clearSeriesId() {
        result.hasSeriesId = false;
        result.seriesId_ = getDefaultInstance().getSeriesId();
        return this;
      }
      
      // required string language = 2;
      public boolean hasLanguage() {
        return result.hasLanguage();
      }
      public java.lang.String getLanguage() {
        return result.getLanguage();
      }
      public Builder setLanguage(java.lang.String value) {
        if (value == null) {
    throw new NullPointerException();
  }
  result.hasLanguage = true;
        result.language_ = value;
        return this;
      }
      public Builder clearLanguage() {
        result.hasLanguage = false;
        result.language_ = getDefaultInstance().getLanguage();
        return this;
      }
      
      // required string seriesName = 3;
      public boolean hasSeriesName() {
        return result.hasSeriesName();
      }
      public java.lang.String getSeriesName() {
        return result.getSeriesName();
      }
      public Builder setSeriesName(java.lang.String value) {
        if (value == null) {
    throw new NullPointerException();
  }
  result.hasSeriesName = true;
        result.seriesName_ = value;
        return this;
      }
      public Builder clearSeriesName() {
        result.hasSeriesName = false;
        result.seriesName_ = getDefaultInstance().getSeriesName();
        return this;
      }
      
      // required string overview = 4;
      public boolean hasOverview() {
        return result.hasOverview();
      }
      public java.lang.String getOverview() {
        return result.getOverview();
      }
      public Builder setOverview(java.lang.String value) {
        if (value == null) {
    throw new NullPointerException();
  }
  result.hasOverview = true;
        result.overview_ = value;
        return this;
      }
      public Builder clearOverview() {
        result.hasOverview = false;
        result.overview_ = getDefaultInstance().getOverview();
        return this;
      }
      
      // required string firstAired = 5;
      public boolean hasFirstAired() {
        return result.hasFirstAired();
      }
      public java.lang.String getFirstAired() {
        return result.getFirstAired();
      }
      public Builder setFirstAired(java.lang.String value) {
        if (value == null) {
    throw new NullPointerException();
  }
  result.hasFirstAired = true;
        result.firstAired_ = value;
        return this;
      }
      public Builder clearFirstAired() {
        result.hasFirstAired = false;
        result.firstAired_ = getDefaultInstance().getFirstAired();
        return this;
      }
      
      // repeated string actors = 6;
      public java.util.List<java.lang.String> getActorsList() {
        return java.util.Collections.unmodifiableList(result.actors_);
      }
      public int getActorsCount() {
        return result.getActorsCount();
      }
      public java.lang.String getActors(int index) {
        return result.getActors(index);
      }
      public Builder setActors(int index, java.lang.String value) {
        if (value == null) {
    throw new NullPointerException();
  }
  result.actors_.set(index, value);
        return this;
      }
      public Builder addActors(java.lang.String value) {
        if (value == null) {
    throw new NullPointerException();
  }
  if (result.actors_.isEmpty()) {
          result.actors_ = new java.util.ArrayList<java.lang.String>();
        }
        result.actors_.add(value);
        return this;
      }
      public Builder addAllActors(
          java.lang.Iterable<? extends java.lang.String> values) {
        if (result.actors_.isEmpty()) {
          result.actors_ = new java.util.ArrayList<java.lang.String>();
        }
        super.addAll(values, result.actors_);
        return this;
      }
      public Builder clearActors() {
        result.actors_ = java.util.Collections.emptyList();
        return this;
      }
      
      // required string banner = 7;
      public boolean hasBanner() {
        return result.hasBanner();
      }
      public java.lang.String getBanner() {
        return result.getBanner();
      }
      public Builder setBanner(java.lang.String value) {
        if (value == null) {
    throw new NullPointerException();
  }
  result.hasBanner = true;
        result.banner_ = value;
        return this;
      }
      public Builder clearBanner() {
        result.hasBanner = false;
        result.banner_ = getDefaultInstance().getBanner();
        return this;
      }
      
      // required string imdbId = 8;
      public boolean hasImdbId() {
        return result.hasImdbId();
      }
      public java.lang.String getImdbId() {
        return result.getImdbId();
      }
      public Builder setImdbId(java.lang.String value) {
        if (value == null) {
    throw new NullPointerException();
  }
  result.hasImdbId = true;
        result.imdbId_ = value;
        return this;
      }
      public Builder clearImdbId() {
        result.hasImdbId = false;
        result.imdbId_ = getDefaultInstance().getImdbId();
        return this;
      }
    }
    
    static {
      watchedepisodes.servlets.protocols.GetSeriesProtocol.getDescriptor();
    }
    
    static {
      watchedepisodes.servlets.protocols.GetSeriesProtocol.internalForceInit();
    }
  }
  
  private static com.google.protobuf.Descriptors.Descriptor
    internal_static_PBSeries_descriptor;
  private static
    com.google.protobuf.GeneratedMessage.FieldAccessorTable
      internal_static_PBSeries_fieldAccessorTable;
  
  public static com.google.protobuf.Descriptors.FileDescriptor
      getDescriptor() {
    return descriptor;
  }
  private static com.google.protobuf.Descriptors.FileDescriptor
      descriptor;
  static {
    java.lang.String[] descriptorData = {
      "\n\020get_series.proto\"\230\001\n\010PBSeries\022\020\n\010serie" +
      "sId\030\001 \002(\t\022\020\n\010language\030\002 \002(\t\022\022\n\nseriesNam" +
      "e\030\003 \002(\t\022\020\n\010overview\030\004 \002(\t\022\022\n\nfirstAired\030" +
      "\005 \002(\t\022\016\n\006actors\030\006 \003(\t\022\016\n\006banner\030\007 \002(\t\022\016\n" +
      "\006imdbId\030\010 \002(\tB7\n\"watchedepisodes.servlet" +
      "s.protocolsB\021GetSeriesProtocol"
    };
    com.google.protobuf.Descriptors.FileDescriptor.InternalDescriptorAssigner assigner =
      new com.google.protobuf.Descriptors.FileDescriptor.InternalDescriptorAssigner() {
        public com.google.protobuf.ExtensionRegistry assignDescriptors(
            com.google.protobuf.Descriptors.FileDescriptor root) {
          descriptor = root;
          internal_static_PBSeries_descriptor =
            getDescriptor().getMessageTypes().get(0);
          internal_static_PBSeries_fieldAccessorTable = new
            com.google.protobuf.GeneratedMessage.FieldAccessorTable(
              internal_static_PBSeries_descriptor,
              new java.lang.String[] { "SeriesId", "Language", "SeriesName", "Overview", "FirstAired", "Actors", "Banner", "ImdbId", },
              watchedepisodes.servlets.protocols.GetSeriesProtocol.PBSeries.class,
              watchedepisodes.servlets.protocols.GetSeriesProtocol.PBSeries.Builder.class);
          return null;
        }
      };
    com.google.protobuf.Descriptors.FileDescriptor
      .internalBuildGeneratedFileFrom(descriptorData,
        new com.google.protobuf.Descriptors.FileDescriptor[] {
        }, assigner);
  }
  
  public static void internalForceInit() {}
}
