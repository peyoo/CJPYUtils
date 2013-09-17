//
//  UIPopoverController+Additions.h
//  PhotosLikePinterest
//
//  Created by 彭 勇 on 12-12-3.
//  Copyright (c) 2012年 彭 勇. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UIStoryboardSegue;
@interface UIPopoverController (Additions)

+(void)addPop:(UIPopoverController*)pop;

+(void)addPopFromSegue:(UIStoryboardSegue*)segue;

+(UIPopoverController*)pop:(UIViewController*)controller;

+(UIPopoverController*)pop:(UIViewController*)controller present:(id)view;

+(UIPopoverController*)pop:(UIViewController*)controller rect:(CGRect)rect inView:(UIView*)view;

+(UIPopoverController*)navPop:(UIViewController*)controller present:(id)view;

+(UIPopoverController*)popOfContent:(UIViewController*)contentViewController;

+(void)dismiss:(UIViewController*)contentViewController animated:(BOOL)animated;

+(void)dismissAll:(BOOL)animated;
@end
