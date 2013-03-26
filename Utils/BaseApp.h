//
//  BaseApp.h
//  PhotosLikePinterest
//
//  Created by 彭 勇 on 12-12-21.
//  Copyright (c) 2012年 ‚àö√á≈í¬©‚Äö√¢‚Ä† ‚àö√á‚àö¬£‚àö¬∞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseApp : UIResponder<UIApplicationDelegate>

-(void)debugCatchException;

-(void)configAnaytics:(NSString*)trackID;

-(void)configRate;


-(void)configVersion;

@end
