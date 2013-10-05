//
//  CJPYWaterFallCollectionLayout.m
//  PhotosLikePinterest
//
//  Created by 彭 勇 on 12-12-10.
//  Copyright (c) 2012年 彭 勇. All rights reserved.
//

#import "CJPYWaterFallCollectionLayout.h"




@interface CJPYWaterFallCollectionLayout ()

@property(nonatomic,strong)UICollectionViewLayoutAttributes * headerAttribute;
@property (nonatomic, assign) NSInteger itemCount;
@property (nonatomic, assign) CGFloat interitemSpacing;
@property (nonatomic, strong) NSMutableArray *columnHeights; // height for each column
@property (nonatomic, strong) NSMutableArray *itemAttributes; // attributes for each item



@end


@implementation NSIndexPath (Action)

+(NSArray*)indexPathsFrom:(NSInteger)startItem endItem:(NSInteger)endItem section:(NSInteger)section{
    NSMutableArray * array=[NSMutableArray arrayWithCapacity:(endItem-startItem)];
    for (int i=startItem; i<endItem; i++) {
        [array addObject:[NSIndexPath indexPathForItem:i inSection:section]];
    }
    return array;
}

@end

@implementation CJPYWaterFallCollectionLayout

-(id)init{
    self=[super init];
    if (self) {
        _columnCountDict=[@{PORTRAIT:@3,LANDSCAPE:@4} mutableCopy];
        _sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        _minItemSpace=10;
    }
    return self;

}

- (void)setColumnCountDict:(NSDictionary*)columnCountDict
{
    UIInterfaceOrientation currentOrientation=[UIApplication sharedApplication].statusBarOrientation;
    if(UIInterfaceOrientationIsPortrait(currentOrientation)){
        if ([columnCountDict[PORTRAIT] intValue]!=[self.columnCountDict[PORTRAIT] intValue]) {
            [self invalidateLayout];
        }
    }else{
        if ([columnCountDict[LANDSCAPE] intValue]!=[self.columnCountDict[LANDSCAPE] intValue]) {
            [self invalidateLayout];
        }
    }
    [self.columnCountDict setDictionary:columnCountDict];
}

- (void)setSectionInset:(UIEdgeInsets)sectionInset
{
    if (!UIEdgeInsetsEqualToEdgeInsets(_sectionInset, sectionInset)) {
        _sectionInset = sectionInset;
        [self invalidateLayout];
    }
}

-(int)currentColumnCount{
    UIInterfaceOrientation currentOrientation=[UIApplication sharedApplication].statusBarOrientation;
    if(UIInterfaceOrientationIsPortrait(currentOrientation)){
        return [self.columnCountDict[PORTRAIT] intValue];
    }else{
        return [self.columnCountDict[LANDSCAPE] intValue];
    }

}

#pragma mark - Life cycle
- (void)dealloc
{
    [_columnHeights removeAllObjects];
    _columnHeights = nil;
}

#pragma mark - Methods to Override
- (void)prepareLayout
{
    [super prepareLayout];
    
    _itemCount = [[self collectionView] numberOfItemsInSection:0];
    
    self.headerSize=[self.delegate headerSize];
    
    int _columnCount=[self currentColumnCount];
    
    NSAssert(_columnCount > 1, @"columnCount for UICollectionViewWaterfallLayout should be greater than 1.");
    CGFloat width = self.collectionView.frame.size.width - _sectionInset.left - _sectionInset.right;
    _interitemSpacing = self.minItemSpace;
    _itemWidth=(width+_interitemSpacing)/_columnCount-_interitemSpacing;
    
    _itemAttributes = [NSMutableArray arrayWithCapacity:_itemCount];
    _columnHeights = [NSMutableArray arrayWithCapacity:_columnCount];
    
    if (self.headerSize.height>0) {
        for (NSInteger idx = 0; idx < _columnCount; idx++) {
            [_columnHeights addObject:@(_sectionInset.top+self.headerSize.height+_interitemSpacing)];
        }
        [_itemAttributes addObject:self.headerAttribute];
        self.withHeader=YES;
    }else{
        for (NSInteger idx = 0; idx < _columnCount; idx++) {
            [_columnHeights addObject:@(_sectionInset.top)];
        }
        self.withHeader=NO;
    }
    
    // Item will be put into shortest column.
    for (NSInteger idx = 0; idx < _itemCount; idx++) {
        [self addItem:idx];
    }
    
}

-(void)addItem:(NSInteger)idx{
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:idx inSection:0];
    CGFloat itemHeight = [self.delegate collectionView:self.collectionView
                                                layout:self
                              heightForItemAtIndexPath:indexPath];
    NSUInteger columnIndex = [self shortestColumnIndex];
    CGFloat xOffset = _sectionInset.left + (_itemWidth + _interitemSpacing) * columnIndex;
    CGFloat yOffset = [(_columnHeights[columnIndex]) floatValue];
    CGPoint itemCenter = CGPointMake(floorf(xOffset + _itemWidth/2), floorf((yOffset + itemHeight/2)));
    
    UICollectionViewLayoutAttributes *attributes =
    [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.size = CGSizeMake(self.itemWidth, itemHeight);
    attributes.center = itemCenter;
    [_itemAttributes addObject:attributes];
    _columnHeights[columnIndex] = @(yOffset + itemHeight + _minItemSpace);
}

-(void)prepareMore{
    _itemCount = [[self collectionView] numberOfItemsInSection:0];
    NSInteger attrsCount=[_itemAttributes count];
    if (_itemCount>attrsCount) {
        for (int idx=attrsCount; idx<_itemCount; idx++) {
           [self addItem:idx]; 
        }
    }
}

- (void)prepareForAnimatedBoundsChange:(CGRect)oldBound{
    _itemCount = [[self collectionView] numberOfItemsInSection:0];
    NSInteger attrsCount=[_itemAttributes count];
    if (_itemCount>attrsCount) {
        for (int idx=attrsCount; idx<_itemCount; idx++) {
            [self addItem:idx];
        }
    }
}

- (CGSize)collectionViewContentSize
{
    if (self.itemCount == 0) {
        return self.collectionView.frame.size;
    }
    CGSize contentSize = self.collectionView.frame.size;
    NSUInteger columnIndex = [self longestColumnIndex];
    CGFloat height = [self.columnHeights[columnIndex] floatValue];
    contentSize.height = height - self.interitemSpacing + self.sectionInset.bottom;
    return contentSize;
    
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)path
{
    NSInteger pos=self.withHeader?(path.item+1):path.item;
    if (pos<[self.itemAttributes count]) {
        return self.itemAttributes[pos];
    }
    return nil;
}

-(UICollectionViewLayoutAttributes*)layoutAttributesForSupplementaryViewOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    return self.headerAttribute;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray * attrs= [self.itemAttributes filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        CGRect frame=[evaluatedObject frame];
            return CGRectIntersectsRect(rect, frame);
    }]];
    return attrs;
}
-(UICollectionViewLayoutAttributes*)headerAttribute{
    _headerAttribute=[UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    _headerAttribute.frame=CGRectMake((self.collectionView.frame.size.width-self.headerSize.width)/2, 10, self.headerSize.width, self.headerSize.height);
    return _headerAttribute;
}



- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
   return NO;
}

#pragma mark - Private Methods
// Find out shortest column.
- (NSUInteger)shortestColumnIndex
{
    __block NSUInteger index = 0;
    __block CGFloat shortestHeight = MAXFLOAT;

    [self.columnHeights enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CGFloat height = [obj floatValue];
        if (height < shortestHeight) {
            shortestHeight = height;
            index = idx;
        }
    }];
    return index;
}

// Find out longest column.
- (NSUInteger)longestColumnIndex
{
    __block NSUInteger index = 0;
    __block CGFloat longestHeight = 0;
    
    [self.columnHeights enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CGFloat height = [obj floatValue];
        if (height > longestHeight) {
            longestHeight = height;
            index = idx;
        }
    }];
    return index;
}


@end
