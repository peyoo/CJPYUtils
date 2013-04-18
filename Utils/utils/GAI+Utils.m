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
    
    if (error) {
        NSLog(@"error:%@",error);
        [[[GAI sharedInstance] defaultTracker ] trackException:NO withNSError:error];
    }

}

+(void)trackException:(NSException*)exception{
    if (exception) {
        NSLog(@"exception:%@",exception);
    [[[GAI sharedInstance] defaultTracker] trackException:NO withNSException:exception];
    }
    
}

+(void)trackView:(NSString*)view{
    [[[GAI sharedInstance] defaultTracker] trackView:view];
}

@end
