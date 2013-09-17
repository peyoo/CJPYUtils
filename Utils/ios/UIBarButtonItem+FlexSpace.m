//
//  UIBarButtonItem+FlexSpace.m
//  PhotosLikePinterest
//
//  Created by 彭 勇 on 12-12-20.
//  Copyright (c) 2012年 ‚àö√á≈í¬©‚Äö√¢‚Ä† ‚àö√á‚àö¬£‚àö¬∞. All rights reserved.
//

#import "UIBarButtonItem+FlexSpace.h"

@implementation UIBarButtonItem (FlexSpace)

+(UIBarButtonItem*)flexSpace{
    return [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
}

@end
