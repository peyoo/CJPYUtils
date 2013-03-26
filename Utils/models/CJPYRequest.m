//
//  CJPYRequest.m
//  pinterest
//
//  Created by 勇 彭 on 12-5-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CJPYRequest.h"
#import "CJPYService.h"


@implementation CJPYRequest

-(id)init:(CJPYRequest*)request{
    self=[super init];
    if (self) {
        self.type=request.type;
        self.title=request.title;
        self.para=[NSMutableDictionary dictionaryWithDictionary:request.para];
        self.pins=[NSMutableArray array];
        [self refresh];
    }
    return self;
}

-(id)init:(NSString*)type title:(NSString*)title dict:(NSDictionary*)dict{
    self=[super init];
    if (self) {
        self.type=type;
        self.title=title;
        self.para=[NSMutableDictionary dictionaryWithDictionary:dict];
        self.pins=[NSMutableArray array];
        [self refresh];
    }
    return self;
}

-(id)init:(NSString*)type title:(NSString*)title paras:(id)firstObject,...{
    self=[super init];
    if (self) {
        self.type=type;
        self.title=title;
        if (firstObject) {
            NSMutableArray* values = [NSMutableArray arrayWithObject:firstObject];
            NSMutableArray* keys = [NSMutableArray array];
            va_list args;
            va_start(args, firstObject);
            id arg;
            int i = 0;
            while ( ( arg = va_arg( args, id) ) != nil ) {
                //       NSLog(@"%@",arg);
                if( (++i)%2 )
                    [keys addObject: arg];
                else
                    [values addObject: arg];
            }
            NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
            for (int i=0; i<[keys count]; i++) {
                id key=[keys objectAtIndex:i];
                id value=[values objectAtIndex:i];
                if (value) {
                    [dict setValue:value forKey:key];
                }
            }
            self.para=dict;
        }
        self.pins=[NSMutableArray array];
        _dict=[NSMutableDictionary dictionary];
        [self refresh];
    }
    return self;    
}



-(id)init{
    self=[super init];
    [self refresh];
    self.para=[NSMutableDictionary dictionary];
    return self;
}

-(void)cancel{
    if (self.operation) {
        [self.operation cancel];
    }
}
-(void)refresh{
    self.state=RequestStateStart;
    self.currentPageIndex=0;
    self.hasMore=YES;
    if (!_dict) {
        _dict=[NSMutableDictionary dictionary];
    }
    [_dict removeAllObjects];
}

-(void)addPins:(NSArray *)pins{
    [self.pins addObjectsFromArray:pins];
}


-(void)more:(CJPYArrayBlock)success fail:(CJPYErrorBlock)fail{
    
        self.state=RequestStateLoading;
        [[ServiceFactory service] query:self success:^(NSArray* array){
            if (self.currentPageIndex==0) {
                [self.pins removeAllObjects];
            }
            self.currentPageIndex+=1;
            if ([array count]==0) {
                self.hasMore=NO;
            }
            [self.pins addObjectsFromArray:array];
            if (success) {
                success(array);
            }
            self.state=RequestStateSuccess;
        } fail:^(NSError * error){
            self.state=RequestStateFailed;
            fail(error);
        }];
    
}

-(NSDictionary*)asJsonDictionary{
    NSMutableDictionary * dict=[NSMutableDictionary dictionary];
    [dict setObject:self.type forKey:@"type"];
    [dict setObject:self.title forKey:@"title"];
    return nil;
}
@end
