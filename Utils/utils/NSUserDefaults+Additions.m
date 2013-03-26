//
//  NSUserDefaults+Additions.m
//  PhotosLikePinterest
//
//  Created by 彭 勇 on 12-12-11.
//  Copyright (c) 2012年 彭 勇. All rights reserved.
//

#import "NSUserDefaults+Additions.h"

@implementation NSUserDefaults (Additions)

+(void)synchronize:(id)obj forKey:(NSString*)key{
    [[NSUserDefaults standardUserDefaults] setObject:obj forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(id)objectFor:(NSString *)key{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}
@end
