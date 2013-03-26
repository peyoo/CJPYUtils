//
//  NSMutableArray+Stack.h
//  PhotosLikePinterest
//
//  Created by 彭 勇 on 12-11-16.
//  Copyright (c) 2012年 彭 勇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Stack)
- (NSMutableArray *)reversedArray;
- (id)pop;
- (void)push:(id)obj;
@end
