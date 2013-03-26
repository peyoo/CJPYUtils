//
//  UIButton+addtions.h
//  PhotosLikePinterest
//
//  Created by 彭 勇 on 12-11-19.
//  Copyright (c) 2012年 彭 勇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (addtions)
- (void)addTarget:(id)target action:(SEL)action;
-(void)set:(NSInteger)title sub:(NSString*)sub;
-(void)setTitle:(NSString *)title sub:(NSString*)sub;

- (void) flipImage:(UIImage*) image;


@end
