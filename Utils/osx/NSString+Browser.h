//
//  NSString+Browser.h
//  Utils
//
//  Created by cjpystudio on 13-10-8.
//  Copyright (c) 2013年 cjpystuido. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Browser)
+ (NSArray *)allBrowsers;
+ (BOOL)isDefaultBrowser:(NSString *)identifier;
+ (NSString *)getBrowserNameByIdentifier:(NSString *)identifier;
+ (NSString *)getIdentifierByBrowserName:(NSString *)name;
@end
