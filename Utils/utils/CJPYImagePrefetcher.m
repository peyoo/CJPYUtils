//
//  CjPYImagePrefetcher.m
//  PhotosLikePinterest
//
//  Created by 彭 勇 on 12-12-19.
//  Copyright (c) 2012年 ‚àö√á≈í¬©‚Äö√¢‚Ä† ‚àö√á‚àö¬£‚àö¬∞. All rights reserved.
//

#import "CJPYImagePrefetcher.h"
#import "BlocksKit.h"

@interface CJPYImagePrefetcher ()

@property (strong, nonatomic) SDWebImageManager *manager;
@property (strong, nonatomic) NSMutableDictionary * urlOperations;
@property (strong) NSMutableArray * needPrefetchURLs;
//@property (assign, nonatomic) NSUInteger requestedCount;
//@property (assign, nonatomic) NSUInteger skippedCount;
//@property (assign, nonatomic) NSUInteger finishedCount;
//@property (assign, nonatomic) NSTimeInterval startedTime;

@end

@implementation CJPYImagePrefetcher

+ (CJPYImagePrefetcher *)sharedImagePrefetcher
{
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{instance = self.new;});
    return instance;
}

- (id)init
{
    if ((self = [super init]))
    {
        _manager = [SDWebImageManager sharedManager];
        _options = SDWebImageLowPriority;
        self.maxConcurrentDownloads = 3;
        self.needPrefetchURLs=[NSMutableArray array];
    }
    return self;
}

- (void)startPrefetching
{
//    self.manager.downloader.maxConcurrentDownloads
    while([self.urlOperations count]<self.maxConcurrentDownloads&&[self.needPrefetchURLs count]) {
        NSURL * url=[self.needPrefetchURLs objectAtIndex:0];
        [self.needPrefetchURLs removeObjectAtIndex:0];
        [self.manager downloadWithURL:url options:SDWebImageDownloaderLowPriority progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished) {
            if (finished) {
                NSLog(@"url:%@ prefetched.",url);
                [self startPrefetching];
            }
        }];
    }
   
}


- (void)prefetchURLs:(NSArray *)urls
{
    NSArray * keys=[self.urlOperations allKeys];
    NSArray * needPrefetch=[urls select:^BOOL(id obj) {
        return ![keys containsObject:obj];
    }];
    NSArray * needCancel=[keys select:^BOOL(id obj) {
        return ![urls containsObject:obj];
    }];
    [needCancel each:^(id key) {
       id<SDWebImageOperation> operation=self.urlOperations[key];
        [operation cancel];
        [self.urlOperations removeObjectForKey:key];
    }];
    [self.needPrefetchURLs addObjectsFromArray:needPrefetch];
    [self startPrefetching];
}

- (void)cancelPrefetching
{
    
}

@end
