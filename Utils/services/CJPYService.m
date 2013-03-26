
#import "CJPYService.h"
#import "BlocksKit.h"

static id PinBoardService;

@implementation ServiceFactory

+(id<CJPYService>)service{
    return PinBoardService;
}

+(void)setService:(id)service{
    PinBoardService=service;
}
@end

@implementation ASIHTTPRequest (CJPY)

+(ASIHTTPRequest*)request:(NSString*)url headers:(NSDictionary*)dict{
    return [self request:url para:nil headers:dict];
}
+(ASIFormDataRequest*)formRequest:(NSString*)url headers:(NSDictionary*)headers{
    return [self formRequest:url para:nil headers:headers];
}
+(ASIHTTPRequest*)request:(NSString*)urlStr para:(NSDictionary*)paras headers:(NSDictionary*)headers{
    NSMutableString * requestURL=[[NSMutableString alloc] initWithString:urlStr];
    if (![urlStr rangeOfString:@"?"].location!=NSNotFound) {
        [requestURL appendString:@"?"];
    }
    [paras each:^(NSString * key, id obj) {
        [requestURL appendFormat:@"&%@=%@",key,obj];
    }];
    __block ASIHTTPRequest * httpRequest=[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:requestURL]];
    [headers each:^(NSString * key, NSString * obj) {
        [httpRequest addRequestHeader:key value:obj];
    }];
    return httpRequest;
}

+(ASIFormDataRequest*)formRequest:(NSString*)urlStr para:(NSDictionary*)paras headers:(NSDictionary*)headers{
    NSMutableString * requestURL=[[NSMutableString alloc] initWithString:urlStr];
    if (![urlStr rangeOfString:@"?"].location!=NSNotFound) {
        [requestURL appendString:@"?"];
    }
    [paras each:^(NSString * key, id obj) {
        [requestURL appendFormat:@"&%@=%@",key,obj];
    }];
    ASIFormDataRequest * formRequest=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:requestURL]];
    [headers each:^(NSString * key, NSString * obj) {
        [formRequest addRequestHeader:key value:obj];
    }];
    return formRequest;
}

@end

@implementation ASIFormDataRequest (CJPY)

-(void)addPostValues:(NSDictionary*)dict{
    [dict each:^(NSString* key, id obj) {
        [self addPostValue:obj forKey:key];
    }];
}

@end