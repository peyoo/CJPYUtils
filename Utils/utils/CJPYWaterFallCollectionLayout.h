//
//  CJPYWaterFallCollectionLayout.h
//  PhotosLikePinterest
//
//  Created by 彭 勇 on 12-12-10.
//  Copyright (c) 2012年 彭 勇. All rights reserved.
//

#import <UIKit/UIKit.h>

#define PORTRAIT @"Portrait"
#define LANDSCAPE @"Landscape"





@class UICollectionViewWaterfallLayout;
@protocol UICollectionViewDelegateWaterfallLayout <UICollectionViewDelegate>
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewWaterfallLayout *)collectionViewLayout
 heightForItemAtIndexPath:(NSIndexPath *)indexPath;

- (CGSize)headerSize;

@end

@interface CJPYWaterFallCollectionLayout : UICollectionViewLayout

@property (nonatomic, weak) id<UICollectionViewDelegateWaterfallLayout> delegate;

@property(nonatomic)  CGSize headerSize;
@property (nonatomic, readonly) CGFloat itemWidth; // Width for every column
@property (nonatomic) UIEdgeInsets sectionInset; // The margins used to lay out content in a section
@property (nonatomic) CGFloat minItemSpace;
@property (nonatomic, strong) NSMutableDictionary * columnCountDict;

@property (nonatomic)BOOL withHeader;

-(void)prepareMore;



@end

@interface NSIndexPath (Action)
+(NSArray*)indexPathsFrom:(NSInteger)startItem endItem:(NSInteger)endItem section:(NSInteger)section;
@end
