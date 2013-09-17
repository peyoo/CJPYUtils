//
//  CJPYWebViewController.h
//  PinBoard
//
//  Created by 彭 勇 on 13-3-12.
//  Copyright (c) 2013年 ÂΩ≠Âãá. All rights reserved.
//

#import <UIKit/UIKit.h>

enum {
    CJPYWebViewControllerAvailableActionsNone             = 0,
    CJPYWebViewControllerAvailableActionsOpenInSafari     = 1 << 0,
    CJPYWebViewControllerAvailableActionsMailLink         = 1 << 1,
    CJPYWebViewControllerAvailableActionsCopyLink         = 1 << 2
};

typedef NSUInteger CJPYWebViewControllerAvailableActions;

@interface CJPYWebViewController : UIViewController

- (id)initWithAddress:(NSString*)urlString;
- (id)initWithURL:(NSURL *)URL;

@property (nonatomic, strong) UIColor *barsTintColor;

@property (nonatomic, readwrite) CJPYWebViewControllerAvailableActions availableActions;

@end
