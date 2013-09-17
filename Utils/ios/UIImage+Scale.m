//
//  UIImage+Scale.m
//  pinterest
//
//  Created by 彭 勇 on 12-11-9.
//
//

#import "UIImage+Scale.h"

@implementation UIImage(UIImage_Scale)

-(UIImage*)scaleToSize:(CGSize)size
{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

-(UIImage*)scaleToWidth:(float)width{
    if (self.size.width<width) {
        return self;
    }
    float height=width*self.size.height/self.size.width;
    CGSize size=CGSizeMake(width, height);
    return [self scaleToSize:size];
}

-(void)screenShot{
//    UIWindow *screenWindow = [[UIApplicationsharedApplication] keyWindow];
//    UIGraphicsBeginImageContext(screenWindow.frame.size);
//    [screenWindow.layerrenderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *screenImg = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    CGImageRef noTitleScreenImgRef  = CGImageCreateWithImageInRect([screenImg CGImage], CGRectMake(0, 64, 320, 416));
//    UIImage *noTitleScreeImg = [UIImageimageWithCGImage:noTitleScreenImgRef scale:11.1orientation:UIImageOrientationUp];
}

@end
