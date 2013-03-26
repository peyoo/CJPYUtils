//
//  BookmarkViewController.h
//  pinterest
//
//  Created by 勇 彭 on 12-5-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PinsViewController.h"

@interface BookmarkViewController : UITableViewController
- (id)init:(NSArray*)marks;
@property(nonatomic,weak)id<PinsSearchDelegate>  searchDelegate;
@property(nonatomic,strong)UIPopoverController * pop;
@end
