//
//  UITableViewController+AutoHeight.m
//  PhotosLikePinterest
//
//  Created by 彭 勇 on 12-12-2.
//  Copyright (c) 2012年 彭 勇. All rights reserved.
//

#import "UITableViewController+AutoHeight.h"

@implementation UITableViewController (AutoHeight)

 //viewDidAppear at end
- (void) forcePopoverSize {
    CGSize currentSetSizeForPopover = self.contentSizeForViewInPopover;
    CGSize fakeMomentarySize = CGSizeMake(currentSetSizeForPopover.width - 1.0f, currentSetSizeForPopover.height - 1.0f);
    self.contentSizeForViewInPopover = fakeMomentarySize;
    self.contentSizeForViewInPopover = currentSetSizeForPopover;
}
//viewWillAppear at begin (UITableViewController)
-(void) reloadViewHeight:(float)width min:(float)minHeight max:(float)maxHeight
{
    [self reloadViewHeight:self.tableView width:width min:minHeight max:maxHeight];
}

//viewWillAppear at begin
-(void) reloadViewHeight:(UITableView*)tableView width:(float)width min:(float)minHeight max:(float)maxHeight
{
    float currentTotal = 0;
    //Need to total each section
    for (int i = 0; i < [tableView?tableView:self.tableView numberOfSections]; i++)
    {
        CGRect sectionRect = [tableView?tableView:self.tableView rectForSection:i];
        currentTotal += sectionRect.size.height;
    }
    //Set the contentSizeForViewInPopover
    float height=MIN(MAX(currentTotal,minHeight),maxHeight);
    self.contentSizeForViewInPopover = CGSizeMake(width, height);
}

@end
