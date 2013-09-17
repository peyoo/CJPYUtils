//
//  CJPYRequest.h
//  pinterest
//
//  Created by 勇 彭 on 12-5-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum CJPYRequestState{
    RequestStateStart,
    RequestStateLoading,
    RequestStateSuccess,
    RequestStateFailed,
    RequestStateCanceled
} RequestState;


@interface CJPYRequest : NSObject

@property(nonatomic,copy) NSString * type;
@property(nonatomic,copy) NSString * title;
@property(nonatomic,strong) NSMutableDictionary * para;


//paging
@property(nonatomic)BOOL hasMore;
@property(nonatomic)NSInteger currentPageIndex;
@property(nonatomic)NSInteger maxPageNum;
@property(nonatomic)NSInteger numOfPage;
@property(nonatomic,strong)NSString * nextURL;


@property RequestState state;
@property(nonatomic)NSOperation* operation;



-(id)init:(CJPYRequest*)request;
-(id)init:(NSString*)type title:(NSString*)title dict:(NSDictionary*)dict;

-(BOOL)isRefreshable;
-(void)refresh;
-(BOOL)beginLoad:(BOOL(^)())loadable;
-(void)endLoad;
-(void)cancel;

@end
