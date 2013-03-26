//
//  BaseApp.m
//  PhotosLikePinterest
//
//  Created by 彭 勇 on 12-12-21.
//  Copyright (c) 2012年 ‚àö√á≈í¬©‚Äö√¢‚Ä† ‚àö√á‚àö¬£‚àö¬∞. All rights reserved.
//

#import "BaseApp.h"
#import "GAI.h"
#import "iRate.h"
#import "iVersion.h"

@interface BaseApp()


@end

void uncaughtExceptionHandler(NSException *exception) {
    NSLog(@"CRASH: %@", exception);
    NSLog(@"Stack Trace: %@", [exception callStackSymbols]);
}

@implementation BaseApp

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
