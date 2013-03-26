//
//  MBProgressHUD+Message.h
//  PhotosLikePinterest
//
//  Created by 彭 勇 on 12-11-14.
//  Copyright (c) 2012年 彭 勇. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Message)

+ (BOOL)hideHUDForView:(UIView *)view message:(NSString*)message delay:(NSTimeInterval)delay;
+ (BOOL)hideHUDForView:(UIView *)view message:(NSString*)message subMessage:(NSString*)detailMessage delay:(NSTimeInterval)delay;

@end
