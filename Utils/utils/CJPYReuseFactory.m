//
//  CJPYReuseFactory.m
//  pinterest
//
//  Created by 勇 彭 on 12-8-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CJPYReuseFactory.h"

static NSMutableDictionary * reusedObjDictionary;

@implementation CJPYReuseFactory

+(void)initialize{
    reusedObjDictionary=[[NSMutableDictionary alloc] init];
}

+(void)reuse:(id)obj type:(NSString*)type{
    if (obj) {
        NSMutableArray * objs=[reusedObjDictionary objectForKey:type];
        if (!objs) {
            objs=[NSMutableArray array];
            [reusedObjDictionary setObject:objs forKey:type];
        }
        [objs addObject:obj];
    }
}

+(id)objForType:(NSString*)type{
    NSMutableArray * objs=[reusedObjDictionary objectForKey:type];
    NSInteger count=[objs count];
    if (count) {
        id obj= [objs lastObject];
        [objs removeLastObject];
        return obj;
    }
    return nil;
}

@end
