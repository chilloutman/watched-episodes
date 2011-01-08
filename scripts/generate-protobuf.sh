#!/bin/sh

protoc --proto_path=../shared/protobuf/ --objc_out=../ios-client/generated/ --java_out=../server/src/ *.proto
