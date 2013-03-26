//
//  CJPYReuseFactory.h
//  pinterest
//
//  Created by 勇 彭 on 12-8-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CJPYReuseFactory : NSObject
+(void)reuse:(id)obj type:(NSString*)type;
+(id)objForType:(NSString*)type;
@end
