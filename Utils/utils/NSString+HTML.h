//
//  NSString+HTML.h
//  PhotosLikePinterest
//
//  Created by 彭 勇 on 12-11-13.
//  Copyright (c) 2012年 彭 勇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HTML)
-(NSString *) stringByStrippingHTML;
-(NSString *)stringByDecodingXMLEntities;
-(NSString*)stringByStrippingHTMLButLink;
+ (NSString *) join:(id) first,...NS_REQUIRES_NIL_TERMINATION;
+(BOOL)empty:(NSString*)str;
+(BOOL)notEmpty:(NSString*)str;

-(BOOL)contain:(NSString*)str;
+ (NSString *)generateUUID;

@end
