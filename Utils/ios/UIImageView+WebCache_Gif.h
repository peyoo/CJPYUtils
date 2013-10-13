//
//  UIImageView+WebCache_Gif.h
//  PhotosLikePinterest
//
//  Created by 彭 勇 on 12-12-18.
//  Copyright (c) 2012年 ‚àö√á≈í¬©‚Äö√¢‚Ä† ‚àö√á‚àö¬£‚àö¬∞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDImageCache.h"
#import "UIImageView+WebCache.h"

@interface SDImageCache(NSData)
- (NSString *)cachedFileNameForKey:(NSString *)key;

- (void)queryDiskGifForKey:(NSString *)key done:(void (^)(UIImage *gifImage))doneBlock;
@end

@interface UIImageView (WebCache_Gif)

-(void)setMayGifProgressImageWithURL:(NSURL*)url;

-(void)setMayGifProgressImageWithURL:(NSURL *)url imagePlaceHolderURL:(NSString*)holderURL;

-(void)setProgressImageWithURL:(NSURL*)url;



@end
