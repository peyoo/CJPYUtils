//
//  PinViewController.h
//  pinterest
//
//  Created by 勇 彭 on 12-5-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJPYUtilsGlobals.h"

@class CJPYPin;
@class PinsViewController;
@interface PinViewController : UITableViewController
@property(nonatomic,copy)CJPYVoidBlock success;
@property(nonatomic,weak)PinsViewController * pop;

- (id)init:(CJPYPin*)pin;
@end
