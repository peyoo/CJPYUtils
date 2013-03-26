//
//  NSUserDefaults+Additions.h
//  PhotosLikePinterest
//
//  Created by 彭 勇 on 12-12-11.
//  Copyright (c) 2012年 彭 勇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (Additions)
+(void)synchronize:(id)obj forKey:(NSString*)key;

+(id)objectFor:(NSString*)key;

@end
