//
//  NSIndexPath+Create.h
//  Utils
//
//  Created by 彭 勇 on 13-4-4.
//  Copyright (c) 2013年 cjpystuido. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSIndexPath (Create)

+(NSArray*)indexPathsWithBegin:(NSInteger)begin count:(NSInteger)count section:(NSInteger)section;
+(NSArray*)indexPathsWithBegin:(NSInteger)begin count:(NSInteger)count;

@end
