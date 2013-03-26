////
////  PinViewController.m
////  pinterest
////
////  Created by 勇 彭 on 12-5-23.
////  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
////
//
//#import "PinViewController.h"
//#import "CJPYPin.h"
//#import "CJPYBoard.h"
//#import "CJPYUser.h"
//#import "MBProgressHUD.h"
//#import "PinterestService.h"
//#import "BoardSelectViewController.h"
//#import "CJPYUtils.h"
//#import "PinsViewController.h"
//#import "PinterestIAP.h"
//#import "RegexKitLite.h"
//#import "CJPYCacheImageView.h"
//#import "iRate.h"
//
//@interface PinViewController ()
//@property(nonatomic,strong)CJPYPin* pin;
//@property(nonatomic,strong)UITextView * textView;
//@property(nonatomic,strong)MBProgressHUD * HUD;
//@property(nonatomic,strong)CJPYBoard * board;
//@property(nonatomic,strong)UIProgressView * progress;
//@property(nonatomic,strong)CJPYCacheImageView * imageView;
//
//@end
//
//@implementation PinViewController
//
//@synthesize pin=_pin;
//@synthesize textView=_textView;
//@synthesize HUD=_HUD;
//@synthesize pop=_pop;
//@synthesize board=_board;
//@synthesize progress=_progress;
//@synthesize imageView=_imageView;
//@synthesize success=_success;
//
//- (id)init:(CJPYPin*)pin
//{
//    self = [super initWithStyle:UITableViewStyleGrouped];
//    if (self) {
//        self.pin=pin;
//        if (self.pin) {
//            if ([self.pin.ownnerUser.userName isEqualToString:[CJPYUser loginUser].userName]) {
//                self.title=@"Edit";
//            }else {
//                self.title=@"Repin";
//            }
//        }else {
//             self.title=@"Create a Pin";
//        }
//    }
//    return self;
//}
//
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    self.HUD=[[MBProgressHUD alloc] initWithView:self.view ];
//    [self.view addSubview:self.HUD];
//
//    if([self.navigationController.viewControllers count]==1){
//        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancel)];
//    }
//    NSString* title=self.pin.pinId?@"Repin":@"Pin";
//    if (self.pin.pinId!=nil&&[self.pin.ownnerUser.userName isEqualToString:[CJPYUser loginUser].userName]) {
//        title=@"Done";
//    }
//    self.navigationItem.rightBarButtonItem= [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStyleDone target:self action:@selector(repin)];
//    
//
//    if (self.pin.image||[self.pin.URL.absoluteString hasPrefix:@"assets"]){
//        [self.navigationItem.rightBarButtonItem setEnabled:NO];
//    }
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(boardSelect:) name:@"selectBoard" object:nil];
//}
//
//-(void)cancel{
//    [self dismissViewControllerAnimated:YES completion:NULL];
//}
//
//
//-(void)boardSelect:(NSNotification*)notification{
//    if (notification) {
//        NSDictionary * dict=[notification object];
//        self.board=[dict objectForKey:@"board"];
//        NSIndexPath * path=[NSIndexPath indexPathForRow:0 inSection:0];
//        UITableViewCell * cell=[self.tableView cellForRowAtIndexPath:path];
//        cell.detailTextLabel.text=self.board.label;
//    }
//}
//
//-(void)repin{
//    if (!self.board) {
//        NSString * boardId=[[NSUserDefaults standardUserDefaults] objectForKey:@"lastBoardSelectId"];
//        self.board=[[CJPYUser loginUser] board:boardId];
//    }
//    NSString * description=self.textView.text;
//
////    if (![PinterestIAP instance].isRemoveAllAd) {
////            if ([description rangeOfRegex:@"Pin++"].location==NSNotFound) {
////                description=[description stringByAppendingFormat:@"\n\n # %@ #",@"Pin++ for Pinterest"];
////            }
////    }
//    
//    [self.HUD show:YES];
//    
//    if (self.pin.pinId) {
//        //edit
//        if ([self.pin.ownnerUser.userName isEqualToString:[CJPYUser loginUser].userName]) {
//            [[ServiceFactory service] editPin:self.pin details:description board:self.board.boardId success:^(id p) {
//                self.HUD.mode=MBProgressHUDModeCustomView;
//                self.HUD.labelText=@"Edit Success";
//                [self.HUD hide:YES afterDelay:1];
//                if (self.pop) {
//                    [self.pop dismissViewControllerAnimated:YES completion:nil];
//                }
//                self.pin.board=self.board;
//                self.pin.caption=description;
//                self.pin.summaryCaption=description;
//                [self.navigationController popViewControllerAnimated:YES];
//                if (self.success) {
//                    self.success();
//                }
//            } fail:^(NSError * error) {
//                if (error.localizedDescription) {
//                    UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Edit Failed" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
//                    [alert show];
//                }
//                 NSLog(@"error:%@",error);
//                self.HUD.mode=MBProgressHUDModeCustomView;
//                self.HUD.labelText=@"Edit Failed";
//                [self.HUD hide:YES afterDelay:1];
//            }];
//            
//        }else {
//            //repin
//            [[ServiceFactory service] repin:self.pin details:description board:self.board.boardId success:^{
//                self.pin.repinCount++;
//                if (self.pop) {
//                    [self.pop dismissViewControllerAnimated:YES completion:nil];
//                }
//                [self.navigationController popViewControllerAnimated:YES];
//                if (self.success) {
//                    self.success();
//                }
//                [self.HUD hide:YES];
//            } fail:^(NSError * error) {
////                [self.tracker trackException:NO withNSError:error];
////                [[GANTracker sharedTracker] trackEvent:@"error" action:@"repinError" label:error.localizedDescription value:-1 withError:nil];
//                self.HUD.mode=MBProgressHUDModeCustomView;
//                self.HUD.labelText=@"Repin Failed";
//                //            [self.pop dismissViewControllerAnimated:YES completion:nil];
//                [self.HUD hide:YES afterDelay:1];
//                if (error.localizedDescription) {
//                    
//                    UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Repin Failed" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
//                    [alert show];
//                }
//                NSLog(@"error:%@",error);
//            }]; 
//        }
//        
//        
//    }else {
//        [[ServiceFactory service] createPin:self.pin.URL.absoluteString details:description board:self.board.boardId success:^(id obj){
//            [self.pop dismissViewControllerAnimated:YES completion:nil];
//            [self.HUD hide:YES];
//            if (self.success) {
//                self.success();
//            }
//        } fail:^(NSError * error) {
//            NSLog(@"error:%@",error);
////            [self.tracker trackException:NO withNSError:error];
////            [[GANTracker sharedTracker] trackEvent:@"error" action:@"pinError" label:error.localizedDescription value:-1 withError:nil];
//            self.HUD.mode=MBProgressHUDModeCustomView;
//            self.HUD.labelText=@"Repin Failed";
////            [self.pop dismissViewControllerAnimated:YES completion:nil];
//            [self.HUD hide:YES afterDelay:1];
//            if (error.localizedDescription) {
//                
//                UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Repin Failed" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
//                [alert show];
//            }
//        }];
//    }
//    
//    
//    
//    
//}
//
//-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section==1) {
//        if (indexPath.row==0) {
//            return 132;
//        }else {
//            return 80;
//        }
//    }
//    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
//}
//
//-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    if (section==1) {
//        return @"Description";
//    }
//    return nil;
//}
//-(void)viewWillAppear:(BOOL)animated{
//    [self reloadViewHeight];
//    [super viewWillAppear:animated]; 
//    
//    
//}
//-(void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    [self forcePopoverSize];
//    if (![PinterestIAP instance].isRemoveAllAd) {
//        if (![PinterestIAP instance].notAlertPinAppendSuffix) {
//            [[PinterestIAP instance] alertPinCaption];
//        }
//    }
//    if ([self.pin.URL.absoluteString hasPrefix:@"assets"]) {
//        [CJPYUtils assetURLToTempFile:self.pin.URL success:^(id tmp){
//            [self.imageView setupImage:[[UIImage alloc] initWithContentsOfFile:tmp]]; 
//            
//            [[ServiceFactory service] uploadPinImage:tmp success:^(id u){
//                self.pin.URL=[NSURL URLWithString:u];
//                [self.navigationItem.rightBarButtonItem setEnabled:YES];
//            } fail:^(NSError * error){
//                NSLog(@"error:%@",error);
////                [[GANTracker sharedTracker] trackEvent:@"error" action:@"uploadImageError" label:error.localizedDescription value:-1 withError:nil];
//            } progress:self.progress];
//        }];
//        
//        
//        return;
//    }
//    if (self.pin.URL) {
//        return;
//    }
//    
//    if (self.pin.image) {
//        NSString* tmpUrl= [CJPYUtils imageToTempfile:self.pin.image];
//        [[ServiceFactory service] uploadPinImage:tmpUrl success:^(id url){
//            self.pin.URL=[NSURL URLWithString:url];
//            [self.navigationItem.rightBarButtonItem setEnabled:YES];
//        }fail:^(NSError * error){
////            [[GANTracker sharedTracker] trackEvent:@"error" action:@"uploadImageError" label:error.localizedDescription value:-1 withError:nil];
//            NSLog(@"error:%@",error);
//        }
//            progress:self.progress     
//         ];
//        return;
//    }
//    
//    
//    
//    
//    
//}
//
//- (void) forcePopoverSize {
//    CGSize currentSetSizeForPopover = self.contentSizeForViewInPopover;
//    CGSize fakeMomentarySize = CGSizeMake(currentSetSizeForPopover.width - 1.0f, currentSetSizeForPopover.height - 1.0f);
//    self.contentSizeForViewInPopover = fakeMomentarySize;
//    self.contentSizeForViewInPopover = currentSetSizeForPopover;
//}
//
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
//    self.contentSizeForViewInPopover = CGSizeMake(500, MAX(currentTotal,60));
//}
//- (void)viewDidUnload
//{
//    [super viewDidUnload];
//    // Release any retained subviews of the main view.
//    // e.g. self.myOutlet = nil;
//}
//
//
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    return YES;
//}
//
//#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 2;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    if (section==0) {
//        return 1;
//    }
//    if (section==1) {
//        if (![PinterestIAP instance].isRemoveAllAd&&[PinterestIAP instance].notAlertPinAppendSuffix) {
//            return 2;
//        }
//        return 1;
//    }
//    return 1;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    
//    if (indexPath.section==0) {
//        if (!cell) {
//            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
//        }
//        cell.textLabel.text=@"Board";
//        if ([CJPYUser loginUser].boardLabels &&[[CJPYUser loginUser].boardLabels count]) {
//            cell.detailTextLabel.text=[[CJPYUser loginUser].boardLabels objectAtIndex:0];
//        }
//        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
//        cell.selectionStyle=UITableViewCellSelectionStyleNone;
//    }
//    if (indexPath.section==1) {
//        if (indexPath.row==0) {
//            if (!cell) {
//                cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
//            }
//            self.imageView=[[CJPYCacheImageView alloc] initWithFrame:CGRectMake(0, 0, 132, 132)];
//            [cell.contentView addSubview:self.imageView];
//            if (self.pin.image) {
//                [self.imageView setupImage:self.pin.image];
//            }else {
//                [self.imageView resetUrl:self.pin.URL];
//            }
//            cell.selectionStyle=UITableViewCellSelectionStyleNone;
//            
//            UITextView * text=[[UITextView alloc] initWithFrame:CGRectMake(132, 0, cell.frame.size.width-132, 132)];
//            text.autoresizingMask=UIViewAutoresizingFlexibleWidth;
//            [cell.contentView addSubview:text];
//            if (!self.pin.caption) {
//                [text becomeFirstResponder];
//            }
//            text.text=self.pin.caption;
//            text.font=[UIFont systemFontOfSize:14];
//
//            self.textView=text;
//            if (self.pin.image||[self.pin.URL.absoluteString hasPrefix:@"assets"]) {
//                self.progress=[[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
//                self.progress.autoresizingMask =UIViewAutoresizingFlexibleWidth;
//                CGRect frame= self.progress.frame;
//                frame.size.width=cell.frame.size.width;
//                self.progress.frame=frame;
//                [self.progress setProgress:0.0];
//                
//                [cell.contentView addSubview:self.progress];
//                return cell;
//            }
//
//        }else {
//            if (!cell) {
//                cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
//            }
//            UILabel * label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 340, 80)];
//            label.lineBreakMode=UILineBreakModeWordWrap;
//            label.numberOfLines=4;
//            label.text=[[PinterestIAP instance] pinDescrition];
//            [cell.contentView addSubview:label];
//            UIButton * btn =[UIButton buttonWithType:UIButtonTypeRoundedRect];
//            [btn setTitle:@"Upgrade" forState:UIControlStateNormal];
//            btn.frame=CGRectMake(350, 25, 80, 30);
//            [btn addTarget:self action:@selector(upgrade) forControlEvents:UIControlEventTouchDown];
//            [cell.contentView addSubview:btn];
//        }
//    }
//    
//    
//    return cell;
//}
//
//-(void)upgrade{
////    [[GANTracker sharedTracker] trackPageview:@"/upgrade/pinDescriptionUpgrade" withError:nil];
//    [[PinterestIAP instance] purchase];
//}
//
//#pragma mark - Table view delegate
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.section==0) {
//        BoardSelectViewController * boardSelector=[[BoardSelectViewController alloc] init:@"selectBoard" user:[CJPYUser loginUser]];
//        [self.navigationController pushViewController:boardSelector animated:YES];
//        return;
//    }
//    
//}
//
//@end
