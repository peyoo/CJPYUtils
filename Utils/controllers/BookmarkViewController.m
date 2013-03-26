////
////  BookmarkViewController.m
////  pinterest
////
////  Created by 勇 彭 on 12-5-18.
////  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
////
//
//#import "BookmarkViewController.h"
//#import "CJPYBookmark.h"
//#import "PinsViewController.h"
//#import "CJPYRequest.h"
////#import "NewBookmarkViewController.h"
//
//@interface BookmarkViewController ()
//@property(nonatomic,strong)NSArray* marks;
//@end
//
//@implementation BookmarkViewController
//@synthesize marks=_marks;
//@synthesize searchDelegate=_searchDelegate;
//@synthesize pop=_pop;
//
//- (id)init:(NSArray*)marks
//{
//    self = [super initWithStyle:UITableViewStylePlain];
//    if (self) {
//        self.title=@"Bookmarks";
//        if (marks) {
//            self.marks=marks;
//        }else {
//            self.marks=[CJPYBookmark marks];
//        }
//    }
//    return self;
//}
//
//
//
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
////    [self reloadViewHeight];
//
//    // Uncomment the following line to preserve selection between presentations.
//    // self.clearsSelectionOnViewWillAppear = NO;
// 
//    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//    
//}
//
//
//
//- (void)viewDidUnload
//{
//    [super viewDidUnload];
//    // Release any retained subviews of the main view.
//    // e.g. self.myOutlet = nil;
//}
//
//- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
//    [super setEditing:editing animated:animated];
//    [self.tableView setEditing:editing animated:YES];
//    if (editing) {
//        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"New Folder" style:UIBarButtonItemStyleBordered target:self action:@selector(newFolder)];
//    }else {
//        self.navigationItem.leftBarButtonItem=nil;
//    }
//}
//-(void)newFolder{
////    NewBookmarkViewController * newbookmark=[[NewBookmarkViewController alloc] init:nil];
////    [self.navigationController pushViewController:newbookmark animated:YES];
//}
//
//-(void)tableView:(UITableView*)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//}
//
//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    return UITableViewCellEditingStyleDelete;
//}
//
//-(void)viewWillAppear:(BOOL)animated{
//    [self reloadViewHeight];
//    [super viewWillAppear:animated];
////    self.navigationItem.rightBarButtonItem = self.editButtonItem;
//    
//}
//-(void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    [self forcePopoverSize];
//}
//- (void) forcePopoverSize {
//    CGSize currentSetSizeForPopover = self.contentSizeForViewInPopover;
//    CGSize fakeMomentarySize = CGSizeMake(currentSetSizeForPopover.width - 1.0f, currentSetSizeForPopover.height - 1.0f);
//    self.contentSizeForViewInPopover = fakeMomentarySize;
//    self.contentSizeForViewInPopover = currentSetSizeForPopover;
//}
//-(void) reloadViewHeight
//{
//    float currentTotal = 0;
//    //Need to total each section
//    for (int i = 0; i < [self.tableView numberOfSections]; i++) 
//    {
//        CGRect sectionRect = [self.tableView rectForSection:i];
//        currentTotal += sectionRect.size.height;
//    }
//    //Set the contentSizeForViewInPopover
//    self.contentSizeForViewInPopover = CGSizeMake(self.tableView.frame.size.width, currentTotal);
//}
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    return YES;
//}
//
//#pragma mark - Table vihew data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return [self.marks count];
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    CJPYBookmark * mark=[self.marks objectAtIndex:indexPath.row];
//    if (!cell) {
//        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
//    }
//    if (mark.folder) {
//        cell.editingAccessoryType=UITableViewCellAccessoryDisclosureIndicator;
//    }else {
//        cell.selectionStyle =UITableViewCellSelectionStyleBlue;
//    }
//    UIImageView * image=[[UIImageView alloc] initWithImage:[UIImage imageNamed:mark.folder?@"folder":@"bookmark"]];
//    image.frame=CGRectMake(20, 4, 32, 32);
//    [cell.contentView addSubview:image];
//    cell.accessoryType = [mark haveSub]? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
//    UILabel * label=[[UILabel alloc] initWithFrame:CGRectMake(60, 4, 200, 32)];
//    label.text=mark.label;
//    [cell.contentView addSubview:label];
//    
//    return cell;
//}
//
//
//// Override to support conditional editing of the table view.
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    CJPYBookmark * mark=[self.marks objectAtIndex:indexPath.row];
//    return mark.editable;
//}
//
//
//
//// Override to support editing the table view.
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        // Delete the row from the data source
//        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    }   
//    else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }   
//}
//
//
//
//// Override to support rearranging the table view.
//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
//{
//    
//}
//
//
//
//// Override to support conditional rearranging of the table view.
//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Return NO if you do not want the item to be re-orderable.
//    return YES;
//}
//
//
//#pragma mark - Table view delegate
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    CJPYBookmark * mark=[self.marks objectAtIndex:indexPath.row];
//    if ([mark haveSub]) {
//        BookmarkViewController * controller=[[BookmarkViewController alloc] init:mark.submarks];
//        controller.searchDelegate=self.searchDelegate;
//        controller.pop=self.pop;
//        [self.navigationController pushViewController:controller animated:YES];
//    }else {
//        [self.searchDelegate search:[[CJPYRequest alloc] init:mark.request]];
//        [self.pop dismissPopoverAnimated:YES];
//    }
//}
//
//@end
