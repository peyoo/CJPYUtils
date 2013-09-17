//
//  CJPYAutoHeightTextSendView.h
//  InstaBoard
//
//  Created by 彭 勇 on 12-12-25.
//  Copyright (c) 2012年 ÂΩ≠Âãá. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HPGrowingTextView;
@interface CJPYAutoHeightTextSendView : UIView
@property(nonatomic,strong)HPGrowingTextView * textView;
@property(nonatomic,strong)UIButton * doneButton;

- (void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)heigh;
@end
