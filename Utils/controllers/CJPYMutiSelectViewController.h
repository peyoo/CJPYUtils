//
//  CJPYMutiSelectViewController.h
//  PhotosLikePinterest
//
//  Created by 彭 勇 on 12-11-26.
//  Copyright (c) 2012年 彭 勇. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CJPYMultiSelectBlock)(NSArray *);

@interface CJPYMutiSelectViewController : UITableViewController
@property(nonatomic,strong)NSMutableArray * titles;
@property(nonatomic,strong)NSMutableArray * values;
@property(nonatomic,strong)NSMutableArray * selecteds;
@property(nonatomic,strong)UIPopoverController* pop;
@property(nonatomic,strong)CJPYMultiSelectBlock selectBlock;
@property(nonatomic,strong)UIBarButtonItem * cancelItem;
@property(nonatomic,strong)UIBarButtonItem * selectItem;


- (id)init:(NSArray*)titles values:(NSArray*)values selectValues:(NSArray*)selects;
-(void)add:(NSArray*)titles values:(NSArray*)values;
-(void)editCell:(UITableViewCell*)cell;

@end
