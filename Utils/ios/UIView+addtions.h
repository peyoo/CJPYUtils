//
//  UIView+addtions.h
//  PhotosLikePinterest
//
//  Created by 彭 勇 on 12-11-22.
//  Copyright (c) 2012年 彭 勇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (addtions)

-(void)setOrigin:(CGPoint)point;
-(void)setSize:(CGSize)size;
-(void)setHeight:(float)height;
-(void)setWidth:(float)width;
-(void)setOriginX:(float)x;
-(void)setOriginY:(float)y;
-(void)setX:(float)x Y:(float)y;

-(void)corner:(float)radius;

-(UIImage *)convertToImage;

+(UIView*)transitionBackgroudViewToWindow:(UIColor*)color;

+(CATransform3D)transformForCurrentOrientation;

@end
