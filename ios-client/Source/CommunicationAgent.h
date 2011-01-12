//
//  CommunicationAgent.h
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 10/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommunicationDelegate.h"


@interface CommunicationAgent : NSObject {
	
}

- (void)sendRequestWithURL:(NSURL *)url delegate:(id<CommunicationDelegate>)delegate;

@end