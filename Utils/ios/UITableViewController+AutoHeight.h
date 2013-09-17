//
//  UITableViewController+AutoHeight.h
//  PhotosLikePinterest
//
//  Created by 彭 勇 on 12-12-2.
//  Copyright (c) 2012年 彭 勇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewController (AutoHeight)


//viewWillAppear at begin
-(void) reloadViewHeight:(float)width min:(float)minHeight max:(float)maxHeight;

-(void) reloadViewHeight:(UITableView*)tableView width:(float)width min:(float)minHeight max:(float)maxHeight;

//viewDidAppear at end
- (void) forcePopoverSize ;
@end
