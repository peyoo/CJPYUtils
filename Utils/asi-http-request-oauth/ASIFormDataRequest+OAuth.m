//
//  ASIFormDataRequest+OAuth.m
//
//  Created by Scott James Remnant on 6/3/11.
//  Copyright 2011 Scott James Remnant <scott@netsplit.com>. All rights reserved.
//

#import "ASIFormDataRequest+OAuth.h"
#import "NSData+URLEncode.h"

@implementation ASIFormDataRequest (ASIFormDataRequest_OAuth)
- (NSString*)encodeURL:(id)obj
{
    if ([obj isKindOfClass:[NSData class]]) {
        NSData * data=obj;
        return [data stringWithoutURLEncoding];
    }else {
        NSString * string=[obj description];
        NSString *newString = (__bridge_transfer NSString *)(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)string, NULL, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), CFStringConvertNSStringEncodingToEncoding([self stringEncoding])));
        if (newString) {
            return newString;
        }
    }
	return @"";
}

-(NSMutableDictionary*)createKeyValuePair:(id <NSObject>)value forKey:(NSString *)key{
    NSMutableDictionary *keyValuePair = [NSMutableDictionary dictionaryWithCapacity:2];
	[keyValuePair setValue:key forKey:@"key"];
    if ([value isKindOfClass:[NSData class]]) {
        [keyValuePair setValue:value forKey:@"value"];
    }else{
        [keyValuePair setValue:[value description] forKey:@"value"];
    }
	
    return keyValuePair;
}

- (NSArray *)oauthPostBodyParameters
{
	if ([fileData count] > 0)
        return nil;
    
    return postData;
}

//- (void)addPostValue:(id <NSObject>)value forKey:(NSString *)key
//{
//	if (!key) {
//		return;
//	}
//	if (![self postData]) {
//		[self setPostData:[NSMutableArray array]];
//	}
//	NSMutableDictionary *keyValuePair = [self createKeyValuePair:value forKey:key];
//	[[self postData] addObject:keyValuePair];
//}
//
//-(NSMutableDictionary*)createKeyValuePair:(id <NSObject>)value forKey:(NSString *)key{
//    NSMutableDictionary *keyValuePair = [NSMutableDictionary dictionaryWithCapacity:2];
//	[keyValuePair setValue:key forKey:@"key"];
//	[keyValuePair setValue:[value description] forKey:@"value"];
//    return keyValuePair;
//}

@end
