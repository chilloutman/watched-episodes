//
//  MessagePopup.h
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 7/19/11.
//  Copyright 2011 Lucas Neiva. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessagePopupView : UIView

@property (nonatomic, retain) IBOutlet UILabel *messageLabel;
@property (nonatomic, assign) NSTimeInterval displayTime;

+ (MessagePopupView *)messagePopupView;
- (void)show;

@end
