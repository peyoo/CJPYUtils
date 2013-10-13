//
//  NSString+Browser.m
//  Utils
//
//  Created by cjpystudio on 13-10-8.
//  Copyright (c) 2013年 cjpystuido. All rights reserved.
//

#import "NSString+Browser.h"

@implementation NSString (Browser)
NSString *const DefaultBrowserIdentifier = @"default";

+ (NSArray *)allBrowsers {
    return @[
             @[@"Default", DefaultBrowserIdentifier],
             @[@"Safari", @"com.apple.Safari"],
             @[@"Google Chrome", @"com.google.Chrome"],
             @[@"Firefox", @"org.mozilla.firefox"]
             ];
}

+ (BOOL)isDefaultBrowser:(NSString *)identifier {
    return [[self allBrowsers][0] containsObject:identifier];
}

+ (NSString *)getBrowserNameByIdentifier:(NSString *)identifier {
    for (NSArray *item in [self allBrowsers]) {
        if ([identifier isEqualToString:item[1]]) {
            return item[0];
        }
    }
    return nil;
}

+ (NSString *)getIdentifierByBrowserName:(NSString *)name {
    for (NSArray *item in [self allBrowsers]) {
        if ([name isEqualToString:item[0]]) {
            return item[1];
        }
    }
    return nil;
}
@end
