//
//  NSIndexPath+Create.m
//  Utils
//
//  Created by 彭 勇 on 13-4-4.
//  Copyright (c) 2013年 cjpystuido. All rights reserved.
//

#import "NSIndexPath+Create.h"

@implementation NSIndexPath (Create)


+(NSArray*)indexPathsWithBegin:(NSInteger)begin count:(NSInteger)count section:(NSInteger)section{
    NSMutableArray * array=[NSMutableArray arrayWithCapacity:count];
    for (int i=0; i<count; i++) {
        [array addObject:[NSIndexPath indexPathForItem:begin+i inSection:section]];
    }
    return array;
}
+(NSArray*)indexPathsWithBegin:(NSInteger)begin count:(NSInteger)count{
    return [NSIndexPath indexPathsWithBegin:begin count:count section:0];

}
@end
