//
//  CJPYCollectionViewController.m
//  Utils
//
//  Created by 彭 勇 on 13-3-29.
//  Copyright (c) 2013年 cjpystuido. All rights reserved.
//

#import "CJPYCollectionViewController.h"
#import <CoreData/CoreData.h>

@interface CJPYCollectionViewController ()<NSFetchedResultsControllerDelegate>
@property(nonatomic, strong) NSMutableArray					*objectChanges;
@property(nonatomic, strong) NSMutableArray					*sectionChanges;
@end

@implementation CJPYCollectionViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
    
	_objectChanges	= [NSMutableArray array];
	_sectionChanges = [NSMutableArray array];
}


- (void)controller	:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
          atIndex		:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
	NSMutableDictionary *change = [NSMutableDictionary new];
    
	switch (type) {
		case NSFetchedResultsChangeInsert:
			change[@(type)] = @(sectionIndex);
			break;
            
		case NSFetchedResultsChangeDelete:
			change[@(type)] = @(sectionIndex);
			break;
	}
    
	[_sectionChanges addObject:change];
}

- (void)controller	:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath :(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
       newIndexPath:(NSIndexPath *)newIndexPath
{
	NSMutableDictionary *change = [NSMutableDictionary new];
    
	switch (type) {
		case NSFetchedResultsChangeInsert:
			change[@(type)] = newIndexPath;
			break;
            
		case NSFetchedResultsChangeDelete:
			change[@(type)] = indexPath;
			break;
            
		case NSFetchedResultsChangeUpdate:
			change[@(type)] = indexPath;
			break;
            
		case NSFetchedResultsChangeMove:
			change[@(type)] = @[indexPath, newIndexPath];
			break;
	}
	[_objectChanges addObject:change];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
	if ([_sectionChanges count] > 0) {
		[self.collectionView performBatchUpdates:^{
			for (NSDictionary * change in _sectionChanges) {
				[change enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, id obj, BOOL *stop) {
					NSFetchedResultsChangeType type = [key unsignedIntegerValue];
					switch (type) {
						case NSFetchedResultsChangeInsert:
							[self.collectionView insertSections:[NSIndexSet indexSetWithIndex:[obj unsignedIntegerValue]]];
							break;
                            
						case NSFetchedResultsChangeDelete:
							[self.collectionView deleteSections:[NSIndexSet indexSetWithIndex:[obj unsignedIntegerValue]]];
							break;
                            
						case NSFetchedResultsChangeUpdate:
							[self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:[obj unsignedIntegerValue]]];
							break;
					}
				}];
			}
		} completion:nil];
	}
    
	if (([_objectChanges count] > 0) && ([_sectionChanges count] == 0)) {
		if ([self shouldReloadCollectionViewToPreventKnownIssue]) {
			// This is to prevent a bug in UICollectionView from occurring.
			// The bug presents itself when inserting the first object or deleting the last object in a collection view.
			// http://stackoverflow.com/questions/12611292/uicollectionview-assertion-failure
			// This code should be removed once the bug has been fixed, it is tracked in OpenRadar
			// http://openradar.appspot.com/12954582
			[self.collectionView reloadData];
		} else {
			[self.collectionView performBatchUpdates:^{
				for (NSDictionary * change in _objectChanges) {
					[change enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, id obj, BOOL *stop) {
						NSFetchedResultsChangeType type = [key unsignedIntegerValue];
						switch (type) {
							case NSFetchedResultsChangeInsert:
								[self.collectionView insertItemsAtIndexPaths:@[obj]];
								break;
                                
							case NSFetchedResultsChangeDelete:
								[self.collectionView deleteItemsAtIndexPaths:@[obj]];
								break;
                                
							case NSFetchedResultsChangeUpdate:
								[self.collectionView reloadItemsAtIndexPaths:@[obj]];
								break;
                                
							case NSFetchedResultsChangeMove:
								[self.collectionView moveItemAtIndexPath:obj[0] toIndexPath:obj[1]];
								break;
						}
					}];
				}
			} completion:nil];
		}
        
		[_sectionChanges removeAllObjects];
		[_objectChanges removeAllObjects];
	}
}

- (BOOL)shouldReloadCollectionViewToPreventKnownIssue
{
	__block BOOL shouldReload = NO;
    
	for (NSDictionary *change in _objectChanges) {
		[change enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
			NSFetchedResultsChangeType type = [key unsignedIntegerValue];
			NSIndexPath *indexPath = obj;
			switch (type) {
				case NSFetchedResultsChangeInsert:
                    
					if ([self.collectionView numberOfItemsInSection:indexPath.section] == 0) {
						shouldReload = YES;
					} else {
						shouldReload = NO;
					}
                    
					break;
                    
				case NSFetchedResultsChangeDelete:
                    
					if ([self.collectionView numberOfItemsInSection:indexPath.section] == 1) {
						shouldReload = YES;
					} else {
						shouldReload = NO;
					}
                    
					break;
                    
				case NSFetchedResultsChangeUpdate:
					shouldReload = NO;
					break;
                    
				case NSFetchedResultsChangeMove:
					shouldReload = NO;
					break;
			}
		}];
	}
    
	return shouldReload;
}

@end
