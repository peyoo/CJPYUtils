//
//  UIActionSheet+Blocks.h
//  PhotosLikePinterest
//
//  Created by 彭 勇 on 12-12-1.
//  Copyright (c) 2012年 彭 勇. All rights reserved.
//


#if __has_feature(objc_arc)
#define ARC_RELEASE(obj)
#define ARC_RETAIN(obj)
#else
#define ARC_RELEASE(obj) [obj release]
#define ARC_RETAIN(obj) [obj retain]
#endif


typedef void (^UIActionSheetCancelBlock) (UIActionSheet *actionSheet);
typedef void (^UIActionSheetClickBlock) (UIActionSheet *actionSheet, NSUInteger idx);
typedef void (^UIActionSheetWillDismissBlock) (UIActionSheet *actionSheet, NSUInteger idx);
typedef void (^UIActionSheetDidDismissBlock) (UIActionSheet *actionSheet, NSUInteger idx);
@interface UIActionSheet (Blocks) <UIActionSheetDelegate>

+(void)dismissAll:(BOOL)animated;
+(UIActionSheet*)show:(NSString*)title cancel:(NSString*)cancelTitle destructive:(NSString*)destructiveTitle others:(NSArray*)otherButtonTitles onCancel:(UIActionSheetCancelBlock)onCancel onClick:(UIActionSheetClickBlock)onClick from:(id)sender;
@end


@interface CJPYActionSheet : UIActionSheet<UIActionSheetDelegate>
@property(nonatomic,strong)UIActionSheetCancelBlock cancelBlock;
@property(nonatomic,strong)UIActionSheetClickBlock clickBlock;
@property(nonatomic,strong)UIActionSheetWillDismissBlock willDismissBlock;
@property(nonatomic,strong)UIActionSheetDidDismissBlock didDismissBlock;

@end
