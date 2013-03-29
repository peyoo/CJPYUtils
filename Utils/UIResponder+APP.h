//
//  UIResponder+APP.h
//  Utils
//
//  Created by 彭 勇 on 13-3-28.
//  Copyright (c) 2013年 cjpystuido. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIResponder (APP)
-(void)debugCatchException;

-(void)configAnaytics:(NSString*)trackID;

-(void)configRate;


-(void)configVersion;

@end
