//
//  MessagePopup.m
//  WatchedEpisodes
//
//  Created by Lucas Neiva on 7/19/11.
//  Copyright 2011 Lucas Neiva. All rights reserved.
//

#import "MessagePopupView.h"
#import <QuartzCore/QuartzCore.h>


#define AnimationDuration 0.2


@implementation MessagePopupView

@synthesize messageLabel, displayTime;

+ (MessagePopupView *)messagePopupView {
    UINib *nib = [UINib nibWithNibName:@"MessagePopupView" bundle:nil];
    MessagePopupView *popupView = [[nib instantiateWithOwner:nil options:nil] lastObject];
    popupView.layer.cornerRadius = 8;
    popupView.displayTime = 2;
    return popupView;
}

- (void)show {
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    self.center = CGPointMake(screenSize.width/2, screenSize.height/2);
    self.alpha = 0;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [UIView animateWithDuration:AnimationDuration animations:^ {
        self.alpha = 1;
    } completion:^ (BOOL finished) {
        [UIView animateWithDuration:AnimationDuration delay:self.displayTime options:0 animations:^ {
            self.alpha = 0;
        } completion:^ (BOOL finished) {
            [self removeFromSuperview];
        }];
    }];
}

- (void)dealloc {
    self.messageLabel = nil;
    [super dealloc];
}

@end
