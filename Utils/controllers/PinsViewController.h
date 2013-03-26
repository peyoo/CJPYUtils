//
//  PinBoardViewController.h
//  pin it++
//
//  Created by 勇 彭 on 12-4-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MBProgressHUD+Message.h"
#import "GAI.h"

@class CJPYRequest;
@class CJPYRequestHistory;

@protocol PinsSearchDelegate<NSObject>
@optional
-(void)search:(NSString*)type title:(NSString*)title paras:(id)firstObject,...NS_REQUIRES_NIL_TERMINATION;
-(void)search:(CJPYRequest*)request;

@end

@interface PinsViewController : GAITrackedViewController<UIScrollViewDelegate,UISearchBarDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UIGestureRecognizerDelegate,PinsSearchDelegate,UINavigationControllerDelegate>{
    
    NSMutableArray * _pinViews;
}

@property(nonatomic,strong) UIScrollView * scrollView;
@property(nonatomic,strong) UIButton * scrollToTopButton;
@property(nonatomic,strong) UIRefreshControl * refreshControl;
@property(nonatomic,strong) UIView * headerView;

@property(nonatomic,strong) CJPYRequest * currentRequest;


@property(nonatomic)BOOL firstPage;
@property(nonatomic,strong)NSMutableArray* startpoints;
@property(nonatomic)float minStartpointY;



-(id)init:(CJPYRequest*)request;


-(CJPYRequest*)defaultRequest;

-(void) addPins:(NSArray *)pins refresh:(BOOL)refresh;
-(void) refresh;
-(void)refreshNavigationBar;

-(void)search:(CJPYRequest*)request;

-(UIView*)createPinView:(CGPoint)startPoint obj:(id)obj;

-(PinsViewController*)pinsViewController:(CJPYRequest*)request;


-(void)refreshHeaderView;
-(void)clearViews;
-(void) morePins;
-(float)calWidth:(UIInterfaceOrientation) orientation;

-(void) setupStartpoints:(float)width;

-(void) removePin:(id)obj;

//-(CGRect)pinPhotoFrame:(CJPYPhoto*)photo forView:(UIView*)view;
//-(void)scrollToVisualble:(CJPYPhoto*)photo;
@end
