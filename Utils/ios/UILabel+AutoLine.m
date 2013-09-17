//
//  UILabel+AutoLine.m
//  pinterest
//
//  Created by 彭 勇 on 12-11-13.
//
//

#import "UILabel+AutoLine.h"

@implementation UILabel (AutoLine)

-(void)autoSize:(NSString*)text maxHeight:(float)maxHeight{
    if (!text||text.length==0) {
        self.frame=CGRectMake(self.frame.origin.x,self.frame.origin.y,self.frame.size.width,0);
        return;
    }
    //设置自动行数与字符换行
    [self setNumberOfLines:0];
    self.lineBreakMode = NSLineBreakByWordWrapping;

    //设置一个行高上限
    CGSize size = CGSizeMake(self.frame.size.width,maxHeight);
    //计算实际frame大小，并将label的frame变成实际大小
    CGSize labelsize = [text sizeWithFont:self.font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    self.frame=CGRectMake(self.frame.origin.x,self.frame.origin.y,self.frame.size.width,labelsize.height);
    self.text=text;
}



@end
