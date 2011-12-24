//
//  JSONDocument.h
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 12/15/11.
//  Copyright (c) 2011 Lucas Neiva. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol JSONDocumentDataProvider

@property (nonatomic, assign) id JSONObject;

@end


@interface JSONDocument : UIDocument

- (id)initWithDocumentName:(NSString *)documentName dataProvider:(id<JSONDocumentDataProvider>)dataProvider;

@end
