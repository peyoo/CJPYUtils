//
//  UIImageView+WebCache_Gif.m
//  PhotosLikePinterest
//
//  Created by 彭 勇 on 12-12-18.
//  Copyright (c) 2012年 ‚àö√á≈í¬©‚Äö√¢‚Ä† ‚àö√á‚àö¬£‚àö¬∞. All rights reserved.
//

#import "UIImageView+WebCache_Gif.h"
#import "UIImageView+WebCache.h"
#import "UIImage+GIF.h"
#import "SDWebImageManager.h"

#define kSDWebImageProgressView 10000

@implementation SDImageCache (NSData)

- (void)queryDiskGifForKey:(NSString *)key done:(void (^)(UIImage *gifImage))doneBlock{
    if (!doneBlock) return;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        UIImage * image=[UIImage animatedGIFWithFilepath:[self cachePathForKey:key]];
        dispatch_async(dispatch_get_main_queue(), ^{
            doneBlock(image);
        });
    });
}

@end

@implementation UIImageView (WebCache_Gif)

-(void)setMayGifProgressImageWithURL:(NSURL *)url imagePlaceHolderURL:(NSString*)holderURL{
    __weak UIImageView *wself = self;
    [SDWebImageManager.sharedManager downloadWithURL:[NSURL URLWithString:holderURL] options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished)
    {
        __strong UIImageView *sself = wself;
        if (!sself) return;
        if (image&&!sself.image){
            sself.image = image;
            [sself setNeedsLayout];
        }
    }];
    [self setMayGifProgressImageWithURL:url];
}

-(void)setProgressImageWithURL:(NSURL*)url{
    [self setImageWithURL:url placeholderImage:self.image options:0 progress:^(NSUInteger receivedSize, long long expectedSize) {
        float progress=receivedSize/(expectedSize*1.0);
        if (progress > 0) {
            UIProgressView *prg = nil;
            if ([self viewWithTag:kSDWebImageProgressView] == nil) {
                CGRect r = CGRectMake(0, (self.frame.size.height / 2), self.frame.size.width, 30);
                prg = [[UIProgressView alloc] initWithFrame:r];
                prg.autoresizingMask=UIViewAutoresizingFlexibleWidth;
                prg.tag = kSDWebImageProgressView;
                prg.progressViewStyle = UIProgressViewStyleDefault;
                [self addSubview:prg];
            } else {
                prg = (UIProgressView *)[self viewWithTag:kSDWebImageProgressView];
            }
            [prg setHidden:NO];
            [prg setProgress:progress];
        }
    }completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        [(UIProgressView *)[self viewWithTag:kSDWebImageProgressView] setHidden:YES];
    }];
}

-(void)setMayGifProgressImageWithURL:(NSURL*)url{
    [self setImageWithURL:url placeholderImage:self.image options:0 progress:^(NSUInteger receivedSize, long long expectedSize) {
        float progress=receivedSize/(expectedSize*1.0);
        if (progress > 0) {
            UIProgressView *prg = nil;
            if ( [ self viewWithTag: kSDWebImageProgressView ] == nil) {
                CGRect r = CGRectMake(0, (self.frame.size.height / 2), self.frame.size.width, 30);
                prg = [[UIProgressView alloc] initWithFrame:r];
                prg.autoresizingMask=UIViewAutoresizingFlexibleWidth;
                prg.tag = kSDWebImageProgressView;
                prg.progressViewStyle = UIProgressViewStyleDefault;
                [self addSubview:prg];
            } else {
                prg = (UIProgressView *)[self viewWithTag:kSDWebImageProgressView];
            }
            [prg setHidden:NO];
            [prg setProgress:progress];
        }
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        [(UIProgressView *)[self viewWithTag:kSDWebImageProgressView] setHidden:YES];
        if (image&&[url.absoluteString.lowercaseString hasSuffix:@".gif"]) {
            [[SDImageCache sharedImageCache] queryDiskGifForKey:url.absoluteString done:^(UIImage *gifImage) {
                if (gifImage) {
                    [self setImage:gifImage];
                }
            }];
        }
    }];
}

@end
