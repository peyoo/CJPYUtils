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


@protocol CJPYService <NSObject>

-(void)query:(CJPYRequest*)request success:(CJPYArrayBlock)successBlock fail:(CJPYErrorBlock)errorblock;

@end

@interface ASIHTTPRequest (CJPY)

+(ASIHTTPRequest*)request:(NSString*)url headers:(NSDictionary*)dict;
+(ASIFormDataRequest*)formRequest:(NSString*)url headers:(NSDictionary*)dict;
+(ASIHTTPRequest*)request:(NSString*)url para:(NSDictionary*)dict headers:(NSDictionary*)dict;
+(ASIFormDataRequest*)formRequest:(NSString*)url para:(NSDictionary*)dict headers:(NSDictionary*)dict;


@end

@interface ASIFormDataRequest (CJPY)
-(void)addPostValues:(NSDictionary*)dict;

@end







@interface ServiceFactory : NSObject

+(id<CJPYService>)service;
+(void)setService:(id)service;
@end
