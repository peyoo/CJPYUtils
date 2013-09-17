
#import "CJPYService.h"
#import "BlocksKit.h"
#import <RegexKitLite.h>
#import "ASINetworkQueue.h"
//#import "NSString+URLEncode.h"


static id PinBoardService;

@implementation ServiceFactory

+(id<CJPYService>)service{
    return PinBoardService;
}

+(void)setService:(id)service{
    PinBoardService=service;
}
@end

@implementation NSString (URLEncode)

- (NSString *)encodeForURL
{
    // See http://en.wikipedia.org/wiki/Percent-encoding and RFC3986
    // Hyphen, Period, Understore & Tilde are expressly legal
    const CFStringRef legalURLCharactersToBeEscaped = CFSTR("!*'();:@&=+$,/?#[]<>\"{}|\\`^% ");
    
    return (__bridge_transfer NSString *)(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, NULL, legalURLCharactersToBeEscaped, kCFStringEncodingUTF8));
}
@end
@implementation ASIHTTPRequest (CJPY)


+(ASIHTTPRequest*)queue:(ASINetworkQueue*)queue request:(NSString*)url paras:(NSDictionary*)paras headers:(NSDictionary*)headers before:(CJPYObjectBlock)before success:(RequestSuccess)success fail:(CJPYErrorBlock)fail{
    NSMutableString * requestURL=[[NSMutableString alloc] initWithString:url];
    if (paras) {
        [paras each:^(NSString * key, NSString * value) {
            [requestURL replaceOccurrencesOfRegex:key withString:[value encodeForURL]];
        }];
    }
    ASIHTTPRequest * request=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:requestURL]];
    
    if (headers) {
        [headers each:^(NSString * key, NSString * value) {
            [request addRequestHeader:key value:value];
        }];
    }
    
    if (before) {
        before(request);
    }
    __weak ASIHTTPRequest * weakRequest=request;
    
    request.completionBlock=^{
        NSString * page=weakRequest.responseString;
        if (success) {
            success(weakRequest,page);
        }
        
    };
    [request setFailedBlock:^{
        if (fail) {
            fail(weakRequest.error);
        }
    }];
    if (queue) {
        [queue addOperation:request];
    }else{
        [request startAsynchronous];
    }
    return request;
}
+(ASIHTTPRequest*)request:(NSString*)url paras:(NSDictionary*)paras headers:(NSDictionary*)headers before:(CJPYObjectBlock)before success:(RequestSuccess)success fail:(CJPYErrorBlock)fail{
    return [ASIHTTPRequest queue:nil request:url paras:paras headers:headers before:before success:success fail:fail];
}
+(ASIHTTPRequest*)request:(NSString*)url paras:(NSDictionary*)paras success:(RequestSuccess)success fail:(CJPYErrorBlock)fail{
    return [ASIHTTPRequest request:url paras:paras headers:nil before:nil success:success fail:fail];
}


+(ASIFormDataRequest*)queue:(ASINetworkQueue*)queue form:(NSString*)url paras:(NSDictionary*)paras headers:(NSDictionary*)headers formParas:(NSDictionary*)formParas before:(CJPYObjectBlock)before success:(RequestSuccess)success fail:(CJPYErrorBlock)fail{
    NSMutableString * requestURL=[[NSMutableString alloc] initWithString:url];
    if (paras) {
        [paras each:^(NSString * key, NSString * value) {
            [requestURL replaceOccurrencesOfRegex:key withString:value];
        }];
    }
    ASIFormDataRequest * request=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:requestURL]];
    
    if (headers) {
        [headers each:^(NSString * key, NSString * value) {
            [request addRequestHeader:key value:value];
        }];
    }
    
    if (formParas) {
        [formParas each:^(NSString * key, id  value) {
            [request addPostValue:value forKey:key];
        }];
    }
    
    if (before) {
        before(request);
    }
    __weak ASIHTTPRequest * weakRequest=request;
    
    request.completionBlock=^{
        NSString * page=weakRequest.responseString;
        if (success) {
            success(weakRequest,page);
        }
    };
    [request setFailedBlock:^{
        if (fail) {
            fail(weakRequest.error);
        }
    }];
    if (queue) {
        [queue addOperation:request];
    }else{
        [request startAsynchronous];
    }
    return request;
}
+(ASIFormDataRequest*)form:(NSString*)url paras:(NSDictionary*)paras headers:(NSDictionary*)headers formParas:(NSDictionary*)formParas before:(CJPYObjectBlock)before success:(RequestSuccess)success fail:(CJPYErrorBlock)fail{
    return [ASIHTTPRequest queue:nil form:url paras:paras headers:headers formParas:formParas before:before success:success fail:fail];

}

+(ASIFormDataRequest*)form:(NSString*)url paras:(NSDictionary*)paras formParas:(NSDictionary*)formParas before:(CJPYObjectBlock)before  success:(RequestSuccess)success fail:(CJPYErrorBlock)fail{
    return [ASIHTTPRequest queue:nil form:url paras:paras headers:nil formParas:formParas before:before  success:success fail:fail];
}

+(ASIFormDataRequest*)form:(NSString*)url paras:(NSDictionary*)paras headers:(NSDictionary*)headers formParas:(NSDictionary*)formParas success:(RequestSuccess)success fail:(CJPYErrorBlock)fail{
    return [ASIHTTPRequest queue:nil form:url paras:paras headers:headers formParas:formParas before:nil success:success fail:fail];
}

+(ASIFormDataRequest*)form:(NSString*)url paras:(NSDictionary*)paras formParas:(NSDictionary*)formParas success:(RequestSuccess)success fail:(CJPYErrorBlock)fail{
    return [ASIHTTPRequest queue:nil form:url paras:paras headers:nil formParas:formParas before:nil  success:success fail:fail];
}

@end

@implementation ASIFormDataRequest (CJPY)

-(void)addPostValues:(NSDictionary*)dict{
    [dict each:^(NSString* key, id obj) {
        [self addPostValue:obj forKey:key];
    }];
}

@end