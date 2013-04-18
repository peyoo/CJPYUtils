//
//  CJPYUtilsGlobals.h
//  PhotosLikePinterest
//
//  Created by 彭 勇 on 12-12-19.
//  Copyright (c) 2012年. All rights reserved.
//



typedef void(^CJPYVoidBlock)(void);
typedef void(^CJPYObjectBlock)(id obj);
typedef void(^CJPYArrayBlock)(NSArray* array);
typedef void(^CJPYErrorBlock)(NSError* error);


#define isPad UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad

//G－C－D
#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)


/// For when you need a weak reference of an object, example: `BlockWeakObject(obj) wobj = obj;`
#define BlockWeakObject(o) __typeof__(o) __weak
/// For when you need a weak reference to self, example: `BlockWeakSelf wself = self;`
#define BlockWeakSelf BBlockWeakObject(self)