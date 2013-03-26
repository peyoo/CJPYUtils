//
//  NSNumber+format.m
//  PhotosLikePinterest
//
//  Created by 彭 勇 on 13-1-14.
//  Copyright (c) 2013年 ‚àö√á≈í¬©‚Äö√¢‚Ä† ‚àö√á‚àö¬£‚àö¬∞. All rights reserved.
//

#import "NSNumber+format.h"

@implementation NSNumber (format)


-(NSString*)decimalStyle{
   return [NSNumberFormatter localizedStringFromNumber:self numberStyle:NSNumberFormatterDecimalStyle];
}
@end
