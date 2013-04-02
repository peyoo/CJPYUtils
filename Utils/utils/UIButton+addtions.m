//
//  UIButton+addtions.m
//  PhotosLikePinterest
//
//  Created by 彭 勇 on 12-11-19.
//  Copyright (c) 2012年 彭 勇. All rights reserved.
//

#import "UIButton+addtions.h"

@implementation UIButton (addtions)

- (void)addTarget:(id)target action:(SEL)action{
    [self addTarget:target action:action forControlEvents:UIControlEventTouchDown];
}

-(void)set:(NSInteger)title sub:(NSString*)sub{
    NSString * str=[NSString stringWithFormat:@"%d\n%@",title,sub];
    self.titleLabel.textAlignment=NSTextAlignmentCenter;
    self.titleLabel.lineBreakMode=NSLineBreakByWordWrapping;
    [self setTitle:str forState:UIControlStateNormal];
}

-(void)setTitle:(NSString *)title sub:(NSString*)sub{
    NSString * str=[NSString stringWithFormat:@"%@\n%@",title,sub];
    self.titleLabel.textAlignment=NSTextAlignmentCenter;
    self.titleLabel.lineBreakMode=NSLineBreakByWordWrapping;
    [self setTitle:str forState:UIControlStateNormal];
}

- (void) flipImage:(UIImage*) image
{
    [UIView beginAnimations:@"flipbutton" context:NULL];
    [UIView setAnimationDuration:0.4];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self cache:YES];
    
    [self setImage:image forState:UIControlStateNormal];
    
    [UIView commitAnimations];
}


@end
