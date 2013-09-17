//
//  MBProgressHUD+Message.m
//  PhotosLikePinterest
//
//  Created by 彭 勇 on 12-11-14.
//  Copyright (c) 2012年 彭 勇. All rights reserved.
//

#import "MBProgressHUD+Message.h"

@implementation MBProgressHUD (Message)
+ (BOOL)hideHUDForView:(UIView *)view message:(NSString*)message delay:(NSTimeInterval)delay{
    
    MBProgressHUD *hud = [MBProgressHUD HUDForView:view];
	if (hud != nil) {
        hud.mode=MBProgressHUDModeCustomView;
		hud.removeFromSuperViewOnHide = YES;
        hud.labelText=message;
		[hud hide:YES afterDelay:delay];
		return YES;
	}
	return NO;
}

+ (BOOL)hideHUDForView:(UIView *)view message:(NSString*)message subMessage:(NSString*)detailMessage delay:(NSTimeInterval)delay{
    
    MBProgressHUD *hud = [MBProgressHUD HUDForView:view];
	if (hud != nil) {
        hud.mode=MBProgressHUDModeCustomView;
		hud.removeFromSuperViewOnHide = YES;
        hud.labelText=message;
        hud.detailsLabelText=detailMessage;
		[hud hide:YES afterDelay:delay];
		return YES;
	}
	return NO;
}

+(void)showWithView:(UIView*)view  title:(NSString*)title message:(NSString*)message delay:(NSTimeInterval)delay{
    [MBProgressHUD showHUDAddedTo:view animated:NO];
    [MBProgressHUD hideHUDForView:view message:title subMessage:message delay:delay];
}
@end
