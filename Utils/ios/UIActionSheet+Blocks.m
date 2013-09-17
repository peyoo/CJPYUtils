//
//  UIActionSheet+Blocks.m
//  PhotosLikePinterest
//
//  Created by 彭 勇 on 12-12-1.
//  Copyright (c) 2012年 彭 勇. All rights reserved.
//


#import "UIActionSheet+Blocks.h"

static NSMutableArray * cjpyActionSheets;

@implementation CJPYActionSheet

+(void)initialize{
    cjpyActionSheets=[NSMutableArray array];
}
@synthesize cancelBlock,clickBlock,willDismissBlock,didDismissBlock;

// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (self.clickBlock) {
        self.clickBlock(actionSheet,buttonIndex);
    }
}

- (void) actionSheetCancel:(UIActionSheet *)actionSheet {
    if (self.cancelBlock) {
        self.cancelBlock(actionSheet);
    }
}

- (void) actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    if (self.didDismissBlock) {
        self.didDismissBlock(actionSheet, buttonIndex);
    }
}

- (void) actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (self.willDismissBlock) {
        self.willDismissBlock(actionSheet, buttonIndex);
    }
}

@end

@implementation UIActionSheet (Blocks)

+(UIActionSheet*)show:(NSString*)title cancel:(NSString*)cancelTitle destructive:(NSString*)destructiveTitle others:(NSArray*)otherButtonTitles onCancel:(UIActionSheetCancelBlock)onCancel onClick:(UIActionSheetClickBlock)onClick from:(id)sender{
    CJPYActionSheet * actions=[[CJPYActionSheet alloc] initWithTitle:title delegate:nil cancelButtonTitle:cancelTitle destructiveButtonTitle:destructiveTitle otherButtonTitles:nil];
    for (NSString * btnTitle in otherButtonTitles) {
        [actions addButtonWithTitle:btnTitle];
    }
    actions.cancelBlock=onCancel;
    actions.clickBlock=onClick;
    actions.delegate=actions;
    if ([sender isKindOfClass:[UIBarButtonItem class]]) {
        UIBarButtonItem * item=sender;
        [actions showFromBarButtonItem:item animated:YES];
    }else if ([sender isKindOfClass:[UIView class]]) {
        UIView * view=sender;
        [actions showFromRect:view.frame inView:view.superview animated:YES];
    }
    [cjpyActionSheets addObject:actions];
    return actions;
}

+(void)dismissAll:(BOOL)animated{
    for (CJPYActionSheet * actionsheet in cjpyActionSheets) {
        [actionsheet dismissWithClickedButtonIndex:-2 animated:animated];
    }
    [cjpyActionSheets removeAllObjects];
}

@end