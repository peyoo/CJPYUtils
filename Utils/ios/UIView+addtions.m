//
//  UIView+addtions.m
//  PhotosLikePinterest
//
//  Created by 彭 勇 on 12-11-22.
//  Copyright (c) 2012年 彭 勇. All rights reserved.
//

#import "UIView+addtions.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (addtions)



-(void)setOrigin:(CGPoint)point{
    CGRect frame=self.frame;
    frame.origin=point;
    self.frame=frame;
}

-(void)setSize:(CGSize)size{
    CGRect frame=self.frame;
    frame.size=size;
    self.frame=frame;
}

-(void)setHeight:(float)height{
    CGRect frame=self.frame;
    frame.size.height=height;
    self.frame=frame;
}
-(void)setWidth:(float)width{
    CGRect frame=self.frame;
    frame.size.width=width;
    self.frame=frame;
}

-(void)setOriginX:(float)x{
    CGRect frame=self.frame;
    frame.origin.x=x;
    self.frame=frame;
}
-(void)setOriginY:(float)y{
    CGRect frame=self.frame;
    frame.origin.y=y;
    self.frame=frame;
}
-(void)setX:(float)x Y:(float)y{
    CGRect frame=self.frame;
    frame.origin.y=y;
    frame.origin.x=x;
    self.frame=frame;

}

-(void)corner:(float)radius{
    self.layer.cornerRadius=radius;
    self.layer.masksToBounds=YES;
}

- (UIImage *)convertToImage
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


+(UIView*)transitionBackgroudViewToWindow:(UIColor*)color{
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    UIView * transferView=[[UIView alloc] initWithFrame:CGRectZero];
    transferView.layer.transform = [UIView transformForCurrentOrientation];
    transferView.backgroundColor=color?color:[UIColor clearColor];
    [keyWindow addSubview:transferView];
    transferView.frame=keyWindow.bounds;
    return transferView;
}

+(CATransform3D)transformForCurrentOrientation{
	UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    //	CGAffineTransformMakeRotation
	switch (orientation) {
		case UIInterfaceOrientationPortraitUpsideDown:
			return CATransform3DMakeRotation((M_PI/180)*180, 0.0f, 0.0f, 1.0f);
			break;
		case UIInterfaceOrientationLandscapeRight:
			return CATransform3DMakeRotation((M_PI/180)*90, 0.0f, 0.0f, 1.0f);
			break;
		case UIInterfaceOrientationLandscapeLeft:
			return CATransform3DMakeRotation((M_PI/180)*-90, 0.0f, 0.0f, 1.0f);
			break;
		default:
			return CATransform3DIdentity;
			break;
	}
    return CATransform3DIdentity;
}

@end
