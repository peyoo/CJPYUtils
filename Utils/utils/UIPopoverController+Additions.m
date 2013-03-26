//
//  UIPopoverController+Additions.m
//  PhotosLikePinterest
//
//  Created by 彭 勇 on 12-12-3.
//  Copyright (c) 2012年 彭 勇. All rights reserved.
//

#import "UIPopoverController+Additions.h"


static NSMutableArray * cjpypops;
@implementation UIPopoverController (Additions)

+(void)addPop:(UIPopoverController*)pop{
    if (!cjpypops) {
        cjpypops=[NSMutableArray array];
    }
    [cjpypops addObject:pop];
}

+(void)addPopFromSegue:(UIStoryboardSegue*)segue{
    if ([segue isKindOfClass:[UIStoryboardPopoverSegue class]]) {
        UIStoryboardPopoverSegue * popSegue=(UIStoryboardPopoverSegue*)segue;
        [self addPop:popSegue.popoverController];
    }
}

+(UIPopoverController*)pop:(UIViewController*)controller {
    if (!cjpypops) {
        cjpypops=[NSMutableArray array];
    }
    for (UIPopoverController * pop in cjpypops) {
        if (pop.contentViewController==controller) {
            return pop;
        }
    }
    UIPopoverController * pop=[[UIPopoverController alloc] initWithContentViewController:controller];
    [cjpypops addObject:pop];
    return pop;
}

+(UIPopoverController*)pop:(UIViewController*)controller rect:(CGRect)rect inView:(UIView*)view{
    UIPopoverController * pop=[UIPopoverController pop:controller];
    if (pop.isPopoverVisible) {
        return pop;
    }
    [pop presentPopoverFromRect:rect inView:view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    return pop;
}

+(UIPopoverController*)pop:(UIViewController*)controller present:(id)item{
    UIPopoverController * pop=[UIPopoverController pop:controller];
    if (pop.isPopoverVisible) {
        return pop;
    }
    if ([item isKindOfClass:[UIBarButtonItem class]]) {
        UIBarButtonItem * barItem=item;
        [pop presentPopoverFromBarButtonItem:barItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }else{
        UIView * view=item;
        [pop presentPopoverFromRect:view.frame inView:[view superview] permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
    return pop;
}

+(UIPopoverController*)navPop:(UIViewController*)controller present:(id)view{
    if ([controller isKindOfClass:[UINavigationController class]]) {
        return [UIPopoverController pop:controller present:view];
    }
    UINavigationController * nav=[[UINavigationController alloc] initWithRootViewController:controller];
    return [UIPopoverController pop:nav present:view];
}

+(UIPopoverController*)popOfContent:(UIViewController*)contentViewController{
    for (UIPopoverController * pop in cjpypops) {
        if (pop.contentViewController==contentViewController) {
            return pop;
        }
    }
    return nil;
}

+(void)dismiss:(UIViewController*)contentViewController animated:(BOOL)animated{
    UIPopoverController * dismissPop=nil;
    for (UIPopoverController * pop in cjpypops) {
        if (pop.contentViewController==contentViewController) {
            dismissPop=pop;
            break;
        }
    }
    if (dismissPop) {
        [dismissPop dismissPopoverAnimated:animated];
        [cjpypops removeObject:dismissPop];
    }
}
+(void)dismissAll:(BOOL)animated{
    for (UIPopoverController * pop in cjpypops) {
       [pop dismissPopoverAnimated:animated];
    }
    [cjpypops removeAllObjects];
}


@end
