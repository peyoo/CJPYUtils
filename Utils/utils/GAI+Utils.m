//
//  GAI+Utils.m
//  PinBoard
//
//  Created by 彭 勇 on 13-3-8.
//  Copyright (c) 2013年 ÂΩ≠Âãá. All rights reserved.
//

#import "GAI+Utils.h"

@implementation GAI (Utils)

+(void)trackError:(NSError*)error{
    NSLog(@"error:%@",error);
    [[[GAI sharedInstance] defaultTracker ] trackException:NO withNSError:error];
}

+(void)trackException:(NSException*)exception{
    NSLog(@"exception:%@",exception);
    [[[GAI sharedInstance] defaultTracker] trackException:NO withNSException:exception];
}

@end
