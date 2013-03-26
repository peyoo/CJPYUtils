//
//  NSString+HTML.m
//  PhotosLikePinterest
//
//  Created by 彭 勇 on 12-11-13.
//  Copyright (c) 2012年 彭 勇. All rights reserved.
//

#import "NSString+HTML.h"

@implementation NSString (HTML)
-(NSString *) stringByStrippingHTML {
    NSRange r;
    NSString *s = [self copy];
    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    return s;
}

-(NSString*)stringByStrippingHTMLButLink{
    NSRange r;
    NSString *s = [self copy];
    NSMutableString * pre=[NSMutableString stringWithCapacity:0];
    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound){
        NSString * str=[s substringWithRange:r];
        if ([str hasPrefix:@"<a"]||[str hasSuffix:@"/a>"]) {
            [pre appendString:[s substringWithRange:NSMakeRange(0, r.location+r.length)]];
            s=[s substringFromIndex:(r.location+r.length)];
        }else{
            s = [s stringByReplacingCharactersInRange:r withString:@""];
        }
        
    }
    [pre appendString:s];
    return pre;
}

-(NSString *)stringByDecodingXMLEntities{
    NSString* str=[self copy];
    NSUInteger myLength = [str length];
    NSUInteger ampIndex = [str rangeOfString:@"&" options:NSLiteralSearch].location;
    
    // Short-circuit if there are no ampersands.
    if (ampIndex == NSNotFound) {
        return str;
    }
    // Make result string with some extra capacity.
    NSMutableString *result = [NSMutableString stringWithCapacity:(myLength * 1.25)];
    
    // First iteration doesn't need to scan to & since we did that already, but for code simplicity's sake we'll do it again with the scanner.
    NSScanner *scanner = [NSScanner scannerWithString:str];
    
    [scanner setCharactersToBeSkipped:nil];
    
    NSCharacterSet *boundaryCharacterSet = [NSCharacterSet characterSetWithCharactersInString:@" \t\n\r;"];
    
    do {
        // Scan up to the next entity or the end of the string.
        NSString *nonEntityString;
        if ([scanner scanUpToString:@"&" intoString:&nonEntityString]) {
            [result appendString:nonEntityString];
        }
        if ([scanner isAtEnd]) {
            goto finish;
        }
        // Scan either a HTML or numeric character entity reference.
        if ([scanner scanString:@"&amp;" intoString:NULL])
            [result appendString:@"&"];
        else if ([scanner scanString:@"&apos;" intoString:NULL])
            [result appendString:@"'"];
        else if ([scanner scanString:@"&quot;" intoString:NULL])
            [result appendString:@"\""];
        else if ([scanner scanString:@"&lt;" intoString:NULL])
            [result appendString:@"<"];
        else if ([scanner scanString:@"&gt;" intoString:NULL])
            [result appendString:@">"];
        else if ([scanner scanString:@"&#" intoString:NULL]) {
            BOOL gotNumber;
            unsigned charCode;
            NSString *xForHex = @"";
            
            // Is it hex or decimal?
            if ([scanner scanString:@"x" intoString:&xForHex]) {
                gotNumber = [scanner scanHexInt:&charCode];
            }
            else {
                gotNumber = [scanner scanInt:(int*)&charCode];
            }
            
            if (gotNumber) {
                [result appendFormat:@"%C", charCode];
                
                [scanner scanString:@";" intoString:NULL];
            }
            else {
                NSString *unknownEntity = @"";
                
                [scanner scanUpToCharactersFromSet:boundaryCharacterSet intoString:&unknownEntity];
                
                
                [result appendFormat:@"&#%@%@", xForHex, unknownEntity];
                
                //[scanner scanUpToString:@";" intoString:&unknownEntity];
                //[result appendFormat:@"&#%@%@;", xForHex, unknownEntity];
                NSLog(@"Expected numeric character entity but got &#%@%@;", xForHex, unknownEntity);
                
            }
            
        }
        else {
            NSString *amp;
            
            [scanner scanString:@"&" intoString:&amp];      //an isolated & symbol
            [result appendString:amp];
            
            /*
             NSString *unknownEntity = @"";
             [scanner scanUpToString:@";" intoString:&unknownEntity];
             NSString *semicolon = @"";
             [scanner scanString:@";" intoString:&semicolon];
             [result appendFormat:@"%@%@", unknownEntity, semicolon];
             NSLog(@"Unsupported XML character entity %@%@", unknownEntity, semicolon);
             */
        }
        
    }
    while (![scanner isAtEnd]);
    
finish:
    return result;
}


+ (NSString *) join:(id) first,...
{
    NSString * result = @"";
    id eachArg;
    va_list alist;
    if(first)
    {
        if ([NSString notEmpty:first]) {
            result = [result stringByAppendingString:[first description] ];
        }
    	va_start(alist, first);
        while ( ( eachArg = va_arg( alist, id) ) != nil ) {
            if ([NSString notEmpty:eachArg]) {
                result = [result stringByAppendingString:[eachArg description]];
            }
        }
    	va_end(alist);
    }
    return result;
}

+(BOOL)empty:(NSString*)str{
    return str==(id)[NSNull null]||str.length==0;
}

+(BOOL)notEmpty:(NSString*)str{
    return str!=(id)[NSNull null]&&str.length!=0;
}
-(BOOL)contain:(NSString*)str{
    if (!str) {
        return NO;
    }
    return [self rangeOfString:str].location!=NSNotFound;
}

@end
