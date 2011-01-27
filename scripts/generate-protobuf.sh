#!/bin/sh

OBJC_GEN_PATH="ios-client/Generated/"
JAVA_GEN_PATH="server/src/"

rm $OBJC_GEN_PATH*
protoc --proto_path=shared/protobuf/ --objc_out=$OBJC_GEN_PATH --java_out=$JAVA_GEN_PATH shared/protobuf/*.proto
