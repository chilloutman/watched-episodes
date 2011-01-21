#!/bin/sh

protoc --proto_path=shared/protobuf/ --objc_out=ios-client/Generated/ --java_out=server/src/ shared/protobuf/*.proto
