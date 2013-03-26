//
//  CJPYAutoHeightTextSendView.m
//  InstaBoard
//
//  Created by 彭 勇 on 12-12-25.
//  Copyright (c) 2012年 ÂΩ≠Âãá. All rights reserved.
//

#import "CJPYAutoHeightTextSendView.h"
#import "HPGrowingTextView.h"

@interface CJPYAutoHeightTextSendView()
@property(nonatomic,strong)UIView * containerView;



@end


@implementation CJPYAutoHeightTextSendView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 40, 320, 40)];
        
        
        
        // textView.text = @"test\n\ntest";
        // textView.animateHeightChange = NO; //turns off animation
        
//        [self.view addSubview:containerView];
        
        UIImage *rawEntryBackground = [UIImage imageNamed:@"MessageEntryInputField.png"];
        UIImage *entryBackground = [rawEntryBackground stretchableImageWithLeftCapWidth:13 topCapHeight:22];
        UIImageView *entryImageView = [[UIImageView alloc] initWithImage:entryBackground];
        entryImageView.frame = CGRectMake(5, 0, self.bounds.size.width-72, self.bounds.size.height);
        entryImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        UIImage *rawBackground = [UIImage imageNamed:@"MessageEntryBackground.png"];
        UIImage *background = [rawBackground stretchableImageWithLeftCapWidth:13 topCapHeight:22];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:background];
        imageView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
        imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        
        
        // view hierachy
        [self addSubview:imageView];
        [self addSubview:self.textView];
        [self addSubview:entryImageView];
        
        UIImage *sendBtnBackground = [[UIImage imageNamed:@"MessageEntrySendButton.png"] stretchableImageWithLeftCapWidth:13 topCapHeight:0];
        UIImage *selectedSendBtnBackground = [[UIImage imageNamed:@"MessageEntrySendButton.png"] stretchableImageWithLeftCapWidth:13 topCapHeight:0];
        
        UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        doneBtn.frame = CGRectMake(self.bounds.size.width - 69, self.bounds.size.height-32, 63, 27);
        doneBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
        [doneBtn setTitle:@"Done" forState:UIControlStateNormal];
        
        [doneBtn setTitleShadowColor:[UIColor colorWithWhite:0 alpha:0.4] forState:UIControlStateNormal];
        doneBtn.titleLabel.shadowOffset = CGSizeMake (0.0, -1.0);
        doneBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
        
        [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [doneBtn addTarget:self action:@selector(resignTextView) forControlEvents:UIControlEventTouchUpInside];
        [doneBtn setBackgroundImage:sendBtnBackground forState:UIControlStateNormal];
        [doneBtn setBackgroundImage:selectedSendBtnBackground forState:UIControlStateSelected];
        _doneButton=doneBtn;
        [self addSubview:doneBtn];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    }
    return self;
}

- (void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height
{
    float diff = (growingTextView.frame.size.height - height);
    
	CGRect r = self.frame;
    r.size.height -= diff;
    r.origin.y += diff;
	self.frame = r;
}

-(HPGrowingTextView*)textView{
    if (!_textView) {
        _textView = [[HPGrowingTextView alloc] initWithFrame:CGRectMake(6, 3, self.bounds.size.width-80, self.bounds.size.height)];
        _textView.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
        _textView.internalTextView.keyboardType=UIKeyboardTypeTwitter;
        _textView.minNumberOfLines = 1;
        _textView.maxNumberOfLines = 6;
        _textView.returnKeyType = UIReturnKeyGo; //just as an example
        _textView.font = [UIFont systemFontOfSize:15.0f];
        _textView.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(5, 0, 5, 0);
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    }
    return _textView;
}

-(BOOL)becomeFirstResponder{
    [super becomeFirstResponder];
    return [self.textView becomeFirstResponder];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
