//
//  CJPYMutiSelectViewController.m
//  PhotosLikePinterest
//
//  Created by 彭 勇 on 12-11-26.
//  Copyright (c) 2012年 彭 勇. All rights reserved.
//

#import "CJPYMutiSelectViewController.h"

@interface CJPYMutiSelectViewController ()


@end

@implementation CJPYMutiSelectViewController
@synthesize titles=_titles;
@synthesize values=_values;
@synthesize selecteds=_selecteds;
@synthesize pop=_pop;
@synthesize selectBlock=_selectBlock;
@synthesize cancelItem=_cancelItem;
@synthesize selectItem=_selectItem;

- (id)init:(NSArray*)titles values:(NSArray*)values selectValues:(NSArray*)selects
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        self.titles=[NSMutableArray arrayWithArray:titles];
        self.values=[NSMutableArray arrayWithArray:values];
        self.selecteds=[NSMutableArray arrayWithArray:selects];
    }
    return self;
}

-(void)add:(NSArray*)titles values:(NSArray*)values{
    [self.titles addObjectsFromArray:titles];
    [self.values addObjectsFromArray:values];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [self reloadViewHeight];
    [super viewWillAppear:animated];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self forcePopoverSize];
}
- (void) forcePopoverSize {
    CGSize currentSetSizeForPopover = self.contentSizeForViewInPopover;
    CGSize fakeMomentarySize = CGSizeMake(currentSetSizeForPopover.width - 1.0f, currentSetSizeForPopover.height - 1.0f);
    self.contentSizeForViewInPopover = fakeMomentarySize;
    self.contentSizeForViewInPopover = currentSetSizeForPopover;
}

-(void) reloadViewHeight
{
    float currentTotal = 0;
    //Need to total each section
    for (int i = 0; i < [self.tableView numberOfSections]; i++)
    {
        CGRect sectionRect = [self.tableView rectForSection:i];
        currentTotal += sectionRect.size.height;
    }
    //Set the contentSizeForViewInPopover
    self.contentSizeForViewInPopover = CGSizeMake(300, MAX(currentTotal,60));
}
- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    self.cancelItem=self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelSelect)];
    self.selectItem=self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doSelect)];
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30.0;
}

-(void)cancelSelect{
    [self.navigationController popViewControllerAnimated:YES];

}

-(void)doSelect{
    if (self.selectBlock) {
        self.selectBlock(self.selecteds);
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.titles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    if (indexPath.row<[self.titles count]) {
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.textLabel.text=[self.titles objectAtIndex:indexPath.row];
        id value=[self.values objectAtIndex:indexPath.row];
        
        if ([self.selecteds containsObject:value]) {
            cell.accessoryType=UITableViewCellAccessoryCheckmark;
        }
    }
    
    return cell;
}

-(void)editCell:(UITableViewCell*)cell{


}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id value=[self.values objectAtIndex:indexPath.row];
    UITableViewCell * cell=[self.tableView cellForRowAtIndexPath:indexPath];
    if (![self.selecteds containsObject:value]) {
        cell.accessoryType=UITableViewCellAccessoryCheckmark;
        [self.selecteds addObject:value];
    }
}

@end
