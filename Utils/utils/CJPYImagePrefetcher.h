//
//  CjPYImagePrefetcher.h
//  PhotosLikePinterest
//
//  Created by 彭 勇 on 12-12-19.
//  Copyright (c) 2012年 ‚àö√á≈í¬©‚Äö√¢‚Ä† ‚àö√á‚àö¬£‚àö¬∞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDWebImageManager.h"

@interface CJPYImagePrefetcher : NSObject
/**
 * Maximum number of URLs to prefetch at the same time. Defaults to 3.
 */
@property (nonatomic, assign) NSUInteger maxConcurrentDownloads;

/**
 * SDWebImageOptions for prefetcher. Defaults to SDWebImageLowPriority.
 */
@property (nonatomic, assign) SDWebImageOptions options;


/**
 * Return the global image prefetcher instance.
 */
+ (CJPYImagePrefetcher *)sharedImagePrefetcher;

/**
 * Assign list of URLs to let SDWebImagePrefetcher to queue the prefetching,
 * currently one image is downloaded at a time,
 * and skips images for failed downloads and proceed to the next image in the list
 *
 * @param urls list of URLs to prefetch
 */
- (void)prefetchURLs:(NSArray *)urls;


/**
 * Remove and cancel queued list
 */
- (void)cancelPrefetching;

@end
