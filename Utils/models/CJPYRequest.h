//
//  CJPYRequest.h
//  pinterest
//
//  Created by 勇 彭 on 12-5-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CJPYUtilsHeader.h"

typedef enum CJPYRequestState{
    RequestStateStart,
    RequestStateLoading,
    RequestStateSuccess,
    RequestStateFailed,
    RequestStateCancel
} RequestState;


@interface CJPYRequest : NSObject{
    @package
    NSMutableDictionary * _dict;

}

@property(nonatomic,copy) NSString * type;
@property(nonatomic,copy) NSString * title;
@property(nonatomic,strong) NSMutableDictionary * para;

@property(nonatomic)BOOL hasMore;
@property(nonatomic)NSInteger currentPageIndex;


@property(nonatomic) NSInteger maxResultCount;
@property(nonatomic,strong) NSMutableArray * pins;


@property(nonatomic)NSInteger selectIndex;

@property RequestState state;
@property(nonatomic)NSOperation* operation;

-(id)init:(CJPYRequest*)request;
-(id)init:(NSString*)type title:(NSString*)title dict:(NSDictionary*)dict;
-(id)init:(NSString*)type title:(NSString*)title paras:(id)firstObject,...NS_REQUIRES_NIL_TERMINATION;

-(void)refresh;

-(void)addPins:(NSArray *)pins;

-(void)cancel;

-(void)more:(CJPYArrayBlock)success fail:(CJPYErrorBlock)fail;


@end
