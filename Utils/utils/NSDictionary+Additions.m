//
//  NSDictionary+Additions.m
//  PhotosLikePinterest
//
//  Created by 彭 勇 on 12-12-7.
//  Copyright (c) 2012年 彭 勇. All rights reserved.
//

#import "NSDictionary+Additions.h"

@implementation NSDictionary (Additions)

-(void)set:(id)obj forKey:(NSString*)key{
    if (obj) {
        [self setValue:obj forKey:key];
    }

}

@end
