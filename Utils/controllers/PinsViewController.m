////
////  PinBoardViewController.m
////  pin it++
////
////  Created by 勇 彭 on 12-4-14.
////  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
////
//#import "PinsViewController.h"
//
//#import "CJPYRequest.h"
//#import "GAI.h"
//#import "CJPYReuseFactory.h"
//#import "CJPYLoadMoreFooterView.h"
//#import "UIPopoverController+Additions.h"
//#import "UIAlertView+Blocks.h"
//
//@interface PinsViewController ()
//
//
//
//
//
//-(void) morePins;
//-(void) layoutPins:(float)width;
//
////layout
//@property(nonatomic)UIInterfaceOrientation pinDisplayOrientation;
//@property(nonatomic)NSInteger startPinIndex;
//@property(nonatomic)NSInteger endPinIndex;
//@property(nonatomic)NSInteger layoutEndPinIndex;
//@property(nonatomic)BOOL viewsCleared;
//
//
//
//@end
//
//@implementation PinsViewController
//
//@synthesize scrollView=_scrollView;
//@synthesize currentRequest=_currentRequest;
//
//@synthesize pinDisplayOrientation=_pinDisplayOrientation;
//
//@synthesize headerView=_headerView;
//@synthesize startpoints=_startpoints;
//@synthesize minStartpointY=_minStartpointY;
//@synthesize refreshControl=_refreshControl;
//@synthesize loadMoreView=_loadMoreView;
//
//@synthesize scrollToTopButton=_scrollToTopButton;
//@synthesize firstPage=_firstPage;
//
//
//@synthesize startPinIndex=_startPinIndex;
//@synthesize endPinIndex=_endPinIndex;
//@synthesize layoutEndPinIndex=_layoutEndPinIndex;
//@synthesize viewsCleared=_viewsCleared;
//
//#pragma mark - init
//-(id)init:(CJPYRequest*)request{
//    self=[super init];
//    if (self) {
//        self.currentRequest=request;
//    }
//    return self;
//}
//
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    
//    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
//    self.scrollView.delegate=self;
//    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin |UIViewAutoresizingFlexibleBottomMargin;
//    self.scrollView.multipleTouchEnabled=YES;
//    self.scrollView.scrollEnabled=YES;
//    self.scrollView.directionalLockEnabled=YES;
//    self.scrollView.delaysContentTouches=YES;
//    self.scrollView.clipsToBounds=YES;
//    self.scrollView.alwaysBounceVertical=YES;
//    self.scrollView.bounces=YES;
//    self.scrollView.showsHorizontalScrollIndicator=NO;
//    self.scrollView.showsVerticalScrollIndicator=NO;
//    self.scrollView.contentSize=CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
//    [self.view addSubview:self.scrollView];
//    
//    
//    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
//    [refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
//    [self.scrollView addSubview:refreshControl];
//    self.refreshControl=refreshControl;
//    
//    CJPYLoadMoreFooterView * loadmore=[[CJPYLoadMoreFooterView alloc] initWithFrame:CGRectMake(0, self.scrollView.contentSize.height, self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
//    self.loadMoreView=loadmore;
//    loadmore.delegate=self;
//    [self.scrollView addSubview:self.loadMoreView];
//    
//    
//    self.scrollToTopButton=[UIButton buttonWithType:UIButtonTypeCustom];
//    [self.scrollToTopButton setBackgroundImage:[UIImage imageNamed:@"top"] forState:UIControlStateNormal];
//    self.scrollToTopButton.frame=CGRectMake((self.view.frame.size.width-60)/2, self.view.frame.size.height-30, 60, 30);
//    self.scrollToTopButton.autoresizingMask=UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
//    [self.scrollToTopButton addTarget:self action:@selector(scrollToTop) forControlEvents:UIControlEventTouchDown];
//    [self.view addSubview:self.scrollToTopButton];
//    
//    self.trackedViewName=self.currentRequest.type;
//    
//    self.navigationItem.leftItemsSupplementBackButton=YES;
//    [self refreshNavigationBar];
//}
//
//-(void) viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:NO];
//    [self.navigationController setToolbarHidden:YES animated:animated];
//    self.navigationController.navigationBar.translucent = NO;
//    self.navigationController.navigationBar.barStyle=UIBarStyleBlack;
//
//    if ([self.currentRequest.pins count]) {
//        [self refreshHeaderView];
//        if (self.interfaceOrientation!=self.pinDisplayOrientation) {
//            [self setupStartpoints:[self calWidth:self.interfaceOrientation]];
//            [self addPins:self.currentRequest.pins refresh:YES];
//        }else{
//            if (self.viewsCleared) {
//                [self addPins:self.currentRequest.pins refresh:NO];
//            }
//        }
//    }else {
//        [self pullToRefresh];
//    }
//}
//
//-(void)viewDidDisappear:(BOOL)animated{
//    [super viewDidDisappear:animated];
//    if (self.viewsCleared) {
//        [self clearViews];
//    } 
//}
//
//-(void)scrollToTop{
//    self.scrollView.contentOffset=CGPointMake(0, 0);
//    self.startPinIndex=self.endPinIndex=0;
//    [self loadOrUnload];
//}
//
////config header view
//-(void)refreshHeaderView{}
//
//-(void)removePin:(id)obj{
//    NSInteger index=[self.currentRequest.pins indexOfObject:obj];
//    if (index!=NSNotFound) {
//        [self.currentRequest.pins removeObject:obj];
//        CJPYMediaView * view=[_pinViews objectAtIndex:index];
//        [view reuse];
//        [_pinViews removeObjectAtIndex:index];
//        [self layoutPins:[self calWidth:self.interfaceOrientation]];
//    }
//}
//
////config navigation bar according current request
//#pragma mark baritemaction
//-(void)refreshNavigationBar{}
//
//
//-(void)home{
//    [UIPopoverController dismissAll:NO];
//    if ([self.currentRequest.type isEqualToString:PINSWITHFOLLOWING]) {
//        [self refresh];
//    }else {
//        [self search:[[CJPYRequest alloc] init:PINSWITHFOLLOWING title:@"Followings" paras:nil]];
//    }
//}
//
//-(void)profile:(id)sender{
//    [UIPopoverController dismissAll:NO];
////    CJPYUser * user=[self.currentRequest.para objectForKey:@"user"];
////    if ([self.currentRequest.type rangeOfString:@"WithUser"].location!=NSNotFound&&[user.userName isEqualToString:[CJPYUser loginUser].userName]) {
////        [self refresh];
////    }else {
////        [self search:[[CJPYRequest alloc] init:PINSWITHUSERPINS title:[CJPYUser loginUser].fullName paras:[CJPYUser loginUser],@"user",nil]];
////    }
//}
//
//
//#pragma mark tap scrollview to small current larged image
//
////-(CGRect)pinPhotoFrame:(CJPYPhoto*)photo forView:(UIView*)view{
////    return CGRectZero;
////}
//
//#pragma mark - scroll
////load or unload image
//-(void)loadOrUnload{
//    NSInteger count=[_pinViews count];
//    if (count==0||self.startPinIndex<0||self.endPinIndex>=count) {
//        return;
//    }
//    CGPoint offset=self.scrollView.contentOffset;
//    CGSize size= self.scrollView.bounds.size;
//    float minMinY=offset.y-2*size.height;
//    float maxMinY=offset.y-size.height;
//    float minMaxY=offset.y+2*size.height;
//    float maxMaxY=offset.y+3*size.height;
//    
//    
//    CJPYPinView * endView=[_pinViews objectAtIndex:self.endPinIndex];
//    CGPoint endPoint=endView.frame.origin;
//    BOOL endLoad=NO;
//    while (endPoint.y<minMaxY) {
//        [endView load];
//        endLoad=YES;
//        if (self.endPinIndex>=count-1) {
//            break;
//        }
//        endView=[_pinViews objectAtIndex:++self.endPinIndex];
//        endPoint=endView.frame.origin;
//    }
//    if (!endLoad) {
//        while (endPoint.y>maxMaxY&&self.endPinIndex>self.startPinIndex) {
//            [endView unload];
//            endView=[_pinViews objectAtIndex:--self.endPinIndex];
//            endPoint=endView.frame.origin;
//        }
//    }
//    
//    CJPYPinView * startView=[_pinViews objectAtIndex:self.startPinIndex];
//    CGRect startFrame=startView.frame;
//    BOOL startLoad=NO;
//    while (startFrame.origin.y+startFrame.size.height>maxMinY) {
//        [startView load];
//        startLoad=YES;
//        if (self.startPinIndex==0) {
//            break;
//        }
//        startView=[_pinViews objectAtIndex:--self.startPinIndex];
//        startFrame=startView.frame;
//    }
//    if (!startLoad) {
//        while (startFrame.origin.y+startFrame.size.height<minMinY&&self.startPinIndex<self.endPinIndex) {
//            [startView unload];
//            startView=[_pinViews objectAtIndex:++self.startPinIndex];
//            startFrame=startView.frame;
//        }
//    }
//    
//}
//
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    //load more pins
//    [self.loadMoreView loadMoreScrollViewDidScroll:scrollView];
//}
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    //load more
//    [self.loadMoreView loadMoreScrollViewDidEndDragging:scrollView];
//    //refresh
//    [self loadOrUnload];
//}
//
//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    [self loadOrUnload];
//}
//#pragma mark -
//
//#pragma mark LoadMoreFooterDelegate Methods
//- (void)loadMoreTableFooterDidTriggerLoadmore:(CJPYLoadMoreFooterView *)view{
//    [self morePins];
//}
//- (BOOL)loadMoreTableFooterDataSourceIsLoading:(CJPYLoadMoreFooterView *)view{
//    return [self currentRequest].state==RequestStateLoading;
//}
//#pragma mark -
//
//
//#pragma mark - rotate
//-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
//    [self layoutPins:[self calWidth:toInterfaceOrientation]];
//}
//
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    return YES;
//}
//#pragma mark -
//
//#pragma mark - layout
//-(void) layoutPins:(float)width {
////    [self setupStartpoints:width];
////    NSInteger index=0;
////    for (CJPYPinView * view in _pinViews) {
////        NSInteger minIndex=0;
////        float minY=((NSValue *)[self.startpoints objectAtIndex:minIndex]).CGPointValue.y;
////        for (int i=1; i<[self.startpoints count]; i++) {
////            CGPoint point=((NSValue *)[self.startpoints objectAtIndex:i]).CGPointValue;
////            if (point.y<minY) {
////                minIndex=i;
////                minY=point.y;
////            }
////        }
////        CGPoint startPoint=((NSValue * )[self.startpoints objectAtIndex:minIndex]).CGPointValue;
////        CJPYPinModel* pin=view.obj;
////        
////        pin.point=startPoint;
////        CGRect frame=view.frame;
////        frame.origin=startPoint;
////        view.frame=frame;
////        view.tag=index++;
////
////        //refresh startpoint
////        startPoint.y=startPoint.y+view.frame.size.height+PIN_GAP;
////        [self.startpoints replaceObjectAtIndex:minIndex withObject:[NSValue valueWithCGPoint:startPoint]];
////    }
////    [self refreshScrollViewContentSize];
//}
//
//-(void)refreshScrollViewContentSize{
//    float maxHeight=((NSValue *)[self.startpoints objectAtIndex:0]).CGPointValue.y;
//    for (int i=1; i<[self.startpoints count]; i++) {
//        CGPoint point=((NSValue *)[self.startpoints objectAtIndex:i]).CGPointValue;
//        if (point.y>maxHeight) {
//            maxHeight=point.y;
//        }
//    }
//    self.scrollView.contentSize=CGSizeMake(self.scrollView.contentSize.width, maxHeight);
//}
//
//
//
//
//#pragma mark - next or pre image
//-(CJPYPin*)pinAtIndex:(NSInteger)index{
//    CJPYRequest * request=self.currentRequest;
//    if (index>=0&&index<[request.pins count]) {
//        return  [self.currentRequest.pins objectAtIndex:index];
//    }
//    return nil;
//    
//}
//
//#pragma mark - current request
//-(CJPYRequest*)currentRequest{
//    if (!_currentRequest) {
//        self.currentRequest=[self defaultRequest];
//    }
//    return _currentRequest;
//}
//
//-(CJPYRequest*)defaultRequest{
//    CJPYRequest* request=[[CJPYRequest alloc] init];
//    request.type=PINSWITHFOLLOWING;
//    request.title=@"Followings";
//    return request;
//}
//
//
//
//
//
//#pragma mark - history back or forward
//
//#pragma mark - explore
//
//
//-(void)search:(NSString*)type title:(NSString*)title paras:(id)firstObject,... {
//    CJPYRequest * request=[[CJPYRequest alloc] init];
//    request.type=type;
//    request.title=title;
//    if (firstObject) {
//        NSMutableArray* values = [NSMutableArray arrayWithObject:firstObject];
//        NSMutableArray* keys = [NSMutableArray array];
//        va_list args;
//        va_start(args, firstObject);
//        id arg;
//        int i = 0;
//        while ( ( arg = va_arg( args, id) ) != nil ) {
//            //       NSLog(@"%@",arg);
//            if( (++i)%2 )
//                [keys addObject: arg];
//            else
//                [values addObject: arg];
//        }
//        NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
//        for (int i=0; i<[keys count]; i++) {
//            id key=[keys objectAtIndex:i];
//            id value=[values objectAtIndex:i];
//            if (value) {
//                [dict setValue:value forKey:key];
//            }
//        }
//        request.para=dict;
//    }
//    [self search:request];
//}
//
//
//#pragma mark - search
//-(void)search:(CJPYRequest*)request{
////    [UIPopoverController dismissAll:NO];
////    [[self currentRequest] cancel];
////    [self clearViews];
////    CJPYRequest * current=[self currentRequest];
////    if ([current.type rangeOfString:@"WithUser"].location!=NSNotFound&&[request.type rangeOfString:@"WithUser"].location!=NSNotFound) {
////        CJPYUser * currentUser=[current.para objectForKey:@"user"];
////        CJPYUser * user=[request.para objectForKey:@"user"];
////        if ([currentUser.userName isEqualToString:user.userName]) {
////            self.currentRequest=request;
////            [self refresh];
////            return;
////        }
////    }else if ([current.type rangeOfString:@"WithPin"].location!=NSNotFound&&[request.type rangeOfString:@"WithPin"].location!=NSNotFound) {
//////        EGOPhotoViewController * controller=[[EGOPhotoViewController alloc] initWithPhotoSource:current];
//////        [self.navigationController pushViewController:controller animated:YES];
////        return;
////    }
////    if ([current.type rangeOfString:@"WithSearch"].location!=NSNotFound&&[request.type rangeOfString:@"WithSearch"].location!=NSNotFound) {
////        self.currentRequest=request;
////        [self refresh];
////        return;
////    }
////    
////    [self.navigationController pushViewController:[self pinsViewController:request] animated:YES];
//}
//
//-(PinsViewController*)pinsViewController:(CJPYRequest*)request{
//    return [[PinsViewController alloc] init:request];
//}
//
//-(UIView*)createPinView:(CGPoint)startPoint obj:(id)obj{return nil;}
//
//-(void) addPins:(NSArray *)pins refresh:(BOOL)refresh{
////    if (pins&&[pins count]) {
////        self.viewsCleared=NO;
////        NSInteger index=[_pinViews count];
////        
////        float minLoadY=self.scrollView.contentOffset.y;
////        float maxLoadY=self.scrollView.bounds.size.height+self.scrollView.contentOffset.y;
////        
////        if (!refresh) {
////            for (CJPYPinModel* pin in pins) {
////                UIView * view=[self createPinView:pin.point obj:pin];
////                view.tag=index++;
////                if (index>=self.startPinIndex&&index<=self.endPinIndex) {
////                    [((CJPYMediaView*)view) load];
////                }
////                [self.scrollView addSubview:view];
////                [_pinViews addObject:view];
////            }
////        }else{
////            for (CJPYPinModel* pin in pins) {
////                NSInteger minIndex=0;
////                float minY=((NSValue *)[self.startpoints objectAtIndex:minIndex]).CGPointValue.y;
////                for (int i=1; i<[self.startpoints count]; i++) {
////                    CGPoint point=((NSValue *)[self.startpoints objectAtIndex:i]).CGPointValue;
////                    if (point.y<minY) {
////                        minIndex=i;
////                        minY=point.y;
////                    }
////                }
////                CGPoint startPoint=((NSValue * )[self.startpoints objectAtIndex:minIndex]).CGPointValue;
////                
////                UIView* view=[self createPinView:startPoint obj:pin];
////                
////                view.tag=index++;
////                pin.point=startPoint;
////                pin.height=view.frame.size.height;
////                if(!(pin.point.y>maxLoadY||pin.point.y+pin.height<minLoadY)) {
////                    [((CJPYMediaView*)view) load];
////                    if (self.endPinIndex<view.tag) {
////                        self.endPinIndex=view.tag;
////                    }
////                    if (self.startPinIndex!=0&&self.startPinIndex>view.tag) {
////                        self.startPinIndex=view.tag;
////                    }
////                }
////                startPoint.y=startPoint.y+view.frame.size.height+PIN_GAP;
////                [self.startpoints replaceObjectAtIndex:minIndex withObject:[NSValue valueWithCGPoint:startPoint]];
////                [self.scrollView addSubview:view];
////                [_pinViews addObject:view];
////            }
////        }
////        [self refreshScrollViewContentSize];
////    }
//}
//
//-(void)pullToRefresh{
//    
//    [self refresh];
//}
//
//-(void) refresh{
//    if (!self.refreshControl.isRefreshing) {
//        [self.refreshControl beginRefreshing];
//    }   
//    self.startPinIndex=0;
//    self.endPinIndex=0;
//    self.layoutEndPinIndex=-1;
//    if (self.scrollView.contentOffset.y>0) {
//        [self.scrollView setContentOffset:CGPointMake(0,0)];
//    }
//    [self clearViews];
//    [self.currentRequest refresh];
//    [self refreshHeaderView];
//    [self setupStartpoints:[self calWidth:self.interfaceOrientation]];
//    [self morePins];
//}
//
//-(void)clearViews{
//    self.viewsCleared=YES;
//    [self.headerView removeFromSuperview];
//    self.headerView=nil;
//    for(UIView *v in _pinViews)
//    {
//        if ([v isKindOfClass:[CJPYMediaView class]]) {
//            
//            [v removeFromSuperview];
//            [((CJPYMediaView*)v) reuse];
//        }
//    }
//    _pinViews=[[NSMutableArray alloc] init];
//}
//
//
//-(float)calWidth:(UIInterfaceOrientation) orientation{
//    if (UIInterfaceOrientationIsLandscape(orientation)) {
//        return [[UIScreen mainScreen] bounds].size.height;
//    }else {
//        return [[UIScreen mainScreen] bounds].size.width;
//    }
//}
//
//
//-(void)setupStartpoints:(float)screenWidth{
//    self.pinDisplayOrientation=self.interfaceOrientation;
//    UIView * startView=self.headerView;
//    float startY=startView.frame.origin.y+startView.bounds.size.height+PIN_GAP;
//    self.startpoints=[[NSMutableArray alloc] init];
//    NSInteger colNum=screenWidth/(PIN_WIDTH+PIN_GAP);
//    float screenGap=(screenWidth-PIN_WIDTH*colNum-PIN_GAP*(colNum-1))/2;
//    for (int i=0; i<colNum; i++) {
//        CGPoint p=CGPointMake(i*(PIN_WIDTH+PIN_GAP)+screenGap, startY);
//        NSValue * point=[NSValue valueWithCGPoint:p];
//        [self.startpoints addObject:point];
//    }
//}
//
//-(void) morePins{
//    __block CJPYRequest * currentRequest=self.currentRequest;
//    BOOL mayHasMore=currentRequest.currentPageIndex<0;
//    self.loadMoreView.hasMore=mayHasMore;
//    if (mayHasMore) {
//        [currentRequest more:^(NSArray * pins) {
//            [self refreshHeaderView];
//            
//            [self addPins:pins refresh:YES];
//            
//            [self.loadMoreView loadMoreScrollViewDataSourceDidFinishedLoading:self.scrollView];
//            [self.refreshControl endRefreshing];
//            self.loadMoreView.hasMore=([pins count]!=0);
//        } fail:^(NSError * error) {
//            [self.loadMoreView loadMoreScrollViewDataSourceDidFinishedLoading:self.scrollView];
//            [self.refreshControl endRefreshing];
//            if (error.code!=NSURLErrorCancelled) {
//                if ([_pinViews count]==0) {
//                    NSString * errorMessage=error?error.localizedDescription:@"Fetch Failed.";
//                    [UIAlertView alertViewWithTitle:errorMessage message:@"Please try to Refresh." cancelButtonTitle:@"Cancel" otherButtonTitles:@[@"Refresh"] onDismiss:^(int buttonIndex) {
//                        [self refresh];
//                    } onCancel:nil];
//                }
//                [self.tracker trackException:NO withNSError:error];
//            }
//        } ];
//    }
//}
//
//-(void)didReceiveMemoryWarning{
//    [super didReceiveMemoryWarning];
////    [[GANTracker sharedTracker] trackEvent:@"warning" action:@"memorywarning" label:nil value:-1 withError:nil];
//}
//
//
//-(void)dealloc{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}
//
////-(void)scrollToVisualble:(CJPYPhoto*)photo{}
//
//
//@end
