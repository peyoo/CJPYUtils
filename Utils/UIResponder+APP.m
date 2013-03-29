//
//  UIResponder+APP.m
//  Utils
//
//  Created by 彭 勇 on 13-3-28.
//  Copyright (c) 2013年 cjpystuido. All rights reserved.
//

#import "UIResponder+APP.h"
#import "GAI.h"
#import "iRate.h"
#import "iVersion.h"

void uncaughtExceptionHandler(NSException *exception) {
    NSLog(@"CRASH: %@", exception);
    NSLog(@"Stack Trace: %@", [exception callStackSymbols]);
}
@implementation UIResponder (APP)

-(void)debugCatchException{
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
}

-(void)configAnaytics:(NSString*)trackID{
    [GAI sharedInstance].dispatchInterval=20;
    [GAI sharedInstance].trackUncaughtExceptions=YES;
    [[GAI sharedInstance] trackerWithTrackingId:trackID];
}

-(void)configRate{
    [iRate sharedInstance];
    [iRate sharedInstance].eventsUntilPrompt=3;
    [iRate sharedInstance].daysUntilPrompt=1;
    [iRate sharedInstance].usesUntilPrompt=3;
}

-(void)configVersion{
    [iVersion sharedInstance];
}

@end
