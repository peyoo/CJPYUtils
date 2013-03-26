//
//  UIViewController+Transition.h
//  PhotosLikePinterest
//
//  Created by 彭 勇 on 12-11-29.
//  Copyright (c) 2012年 彭 勇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Transition)

-(UIViewController *)navPresent:(UIViewController *)controller presentationStyle:(UIModalPresentationStyle)style transitionStyle:(UIModalTransitionStyle)transitionStyle completion:(void (^)(void))completion;

-(void) reloadViewHeight:(UITableView*)tableView width:(float)width min:(float)minHeight max:(float)maxHeight extra:(float)extraHeight;

- (void) forcePopoverSize;
@end
