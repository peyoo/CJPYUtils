//
//  UIStoryboardSegue+content.m
//  Utils
//
//  Created by 彭 勇 on 13-3-26.
//  Copyright (c) 2013年 cjpystuido. All rights reserved.
//

#import "UIStoryboardSegue+content.h"

@implementation UIStoryboardSegue (content)
-(id)destinationContentController{
    UIViewController * controller= self.destinationViewController;
    if ([self isKindOfClass:[UIStoryboardPopoverSegue class]]) {
       UIPopoverController * pop=((UIStoryboardPopoverSegue*)self).popoverController;
        controller=pop.contentViewController;
    }
    if ([controller isKindOfClass:[UINavigationController class]]) {
        return ((UINavigationController*)controller).childViewControllers[0];
    }
    return controller;
}

@end
