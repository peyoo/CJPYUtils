//
//  PinterestService.h
//  pin it++
//
//  Created by 勇 彭 on 12-4-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CJPYUtilsGlobals.h"
#import "ASIHTTPRequest.h"
#import "ASIHTTPRequest+OAuth.h"
#import "ASIFormDataRequest+OAuth.h"


@class CJPYRequest;

@class ASINetworkQueue;
@protocol CJPYService <NSObject>

-(void)query:(CJPYRequest*)request success:(CJPYArrayBlock)successBlock fail:(CJPYErrorBlock)errorblock;

@end

@interface ASIHTTPRequest (CJPY)




+(ASIHTTPRequest*)queue:(ASINetworkQueue*)queue request:(NSString*)url paras:(NSDictionary*)dict headers:(NSDictionary*)dict before:(CJPYObjectBlock)before success:(CJPYObjectBlock)success fail:(CJPYErrorBlock)fail;
+(ASIHTTPRequest*)request:(NSString*)url paras:(NSDictionary*)dict headers:(NSDictionary*)headers before:(CJPYObjectBlock)before success:(CJPYObjectBlock)success fail:(CJPYErrorBlock)fail;
+(ASIHTTPRequest*)request:(NSString*)url paras:(NSDictionary*)paras success:(CJPYObjectBlock)success fail:(CJPYErrorBlock)fail;




+(ASIFormDataRequest*)queue:(ASINetworkQueue*)queue  form:(NSString*)url paras:(NSDictionary*)paras formParas:(NSDictionary*)formParas before:(CJPYObjectBlock)before  success:(CJPYObjectBlock)success fail:(CJPYErrorBlock)fail;
+(ASIFormDataRequest*)form:(NSString*)url paras:(NSDictionary*)paras formParas:(NSDictionary*)formParas before:(CJPYObjectBlock)before  success:(CJPYObjectBlock)success fail:(CJPYErrorBlock)fail;

+(ASIFormDataRequest*)form:(NSString*)url paras:(NSDictionary*)paras formParas:(NSDictionary*)formParas success:(CJPYObjectBlock)success fail:(CJPYErrorBlock)fail;

@end

@interface ASIFormDataRequest (CJPY)
-(void)addPostValues:(NSDictionary*)dict;

@end







@interface ServiceFactory : NSObject

+(id<CJPYService>)service;
+(void)setService:(id)service;
@end
