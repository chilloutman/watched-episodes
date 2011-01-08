#!/bin/sh

protoc --proto_path=. --objc_out=../../ios-client/generated/ --java_out=../../server/src/ *.proto
