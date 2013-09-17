//
//  UIImage+Scale.h
//  pinterest
//
//  Created by 彭 勇 on 12-11-9.
//
//

#import <Foundation/Foundation.h>

@interface UIImage(UIImage_Scale)
-(UIImage*)scaleToSize:(CGSize)size;

-(UIImage*)scaleToWidth:(float)width;
@end
