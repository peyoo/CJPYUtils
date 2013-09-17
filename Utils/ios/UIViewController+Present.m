//
//  UIViewController+Transition.m
//  PhotosLikePinterest
//
//  Created by 彭 勇 on 12-11-29.
//  Copyright (c) 2012年 彭 勇. All rights reserved.
//

#import "UIViewController+Present.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIViewController (Transition)
-(UIViewController *)navPresent:(UIViewController *)controller presentationStyle:(UIModalPresentationStyle)style transitionStyle:(UIModalTransitionStyle)transitionStyle completion:(void (^)(void))completion{
    if ([controller isKindOfClass:[UINavigationController class]]) {
        controller.modalPresentationStyle=style;
        controller.modalTransitionStyle=transitionStyle;
        [self presentViewController:controller animated:YES completion:completion];
        return controller;
    }else{
        UINavigationController * nav=[[UINavigationController alloc] initWithRootViewController:controller];
        nav.modalPresentationStyle=style;
        nav.modalTransitionStyle=transitionStyle;
        if ([controller conformsToProtocol:@protocol(UINavigationControllerDelegate)]) {
            nav.delegate=(id<UINavigationControllerDelegate>)controller;
        }
        [self presentViewController:nav animated:YES completion:completion];
        return nav;
    }
}

//viewWillAppear at begin
-(void) reloadViewHeight:(UITableView*)tableView width:(float)width min:(float)minHeight max:(float)maxHeight extra:(float)extraHeight
{
    float currentTotal = 0;
    //Need to total each section
    for (int i = 0; i < [tableView numberOfSections]; i++)
    {
        CGRect sectionRect = [tableView rectForSection:i];
        currentTotal += sectionRect.size.height;
    }
    //Set the contentSizeForViewInPopover
    currentTotal+=extraHeight;
    float height=MIN(MAX(currentTotal,minHeight),maxHeight);
    self.contentSizeForViewInPopover = CGSizeMake(width, height);
}

- (void) forcePopoverSize {
    CGSize currentSetSizeForPopover = self.contentSizeForViewInPopover;
    CGSize fakeMomentarySize = CGSizeMake(currentSetSizeForPopover.width - 1.0f, currentSetSizeForPopover.height - 1.0f);
    self.contentSizeForViewInPopover = fakeMomentarySize;
    self.contentSizeForViewInPopover = currentSetSizeForPopover;
}
@end
