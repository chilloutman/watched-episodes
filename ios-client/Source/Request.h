//
//  CBServerCall.h
//  CoreBanking
//
//  Created by Lucas Neiva on 12/15/10.
//  Copyright 2010 Ergon Informatik AG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommunicationDelegate.h"


@interface Request : NSObject {
	id<CommunicationDelegate> delegate;
	NSURL *url;
	BOOL protobuf;
}

@property (nonatomic, assign) BOOL protobuf;
@property (nonatomic, retain) id<NSObject> requestId;

- (id)initWithURL:(NSURL *)u delegate:(id<CommunicationDelegate>)d;
- (void)excecute;

@end
