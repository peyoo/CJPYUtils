//
//  NSMutableArray+Stack.m
//  PhotosLikePinterest
//
//  Created by 彭 勇 on 12-11-16.
//  Copyright (c) 2012年 彭 勇. All rights reserved.
//

#import "NSMutableArray+Stack.h"

@implementation NSMutableArray (Stack)
- (id)pop
{
    // nil if [self count] == 0
    id lastObject =[self lastObject];
    if (lastObject)
        [self removeLastObject];
    return lastObject;
}

- (void)push:(id)obj
{
    [self addObject: obj];
}

- (NSMutableArray *)reversedArray {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:[self count]];
    NSEnumerator *enumerator = [self reverseObjectEnumerator];
    for (id element in enumerator) {
        [array addObject:element];
    }
    return array;
}
@end
