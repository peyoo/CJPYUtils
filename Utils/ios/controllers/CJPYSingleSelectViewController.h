//
//  CJPYSingleSelectViewController.h
//  pinterest
//
//  Created by 彭 勇 on 12-11-12.
//
//

#import <UIKit/UIKit.h>
//typedef void(^BaseBlock)(void);
typedef void(^CJPYSelectBlock)(id key,id text);


@interface CJPYSingleSelectViewController : UITableViewController
@property(nonatomic,strong)NSIndexPath * selectIndexPath;
- (id)init:(CJPYSelectBlock)block;
- (id)init:(NSArray*)array keys:(NSArray*)keys select:(CJPYSelectBlock)block;

- (id)init:(NSArray*)array keys:(NSArray*)keys initSelectKey:(id)key select:(CJPYSelectBlock)block;

-(void)add:(NSString*)section titles:(NSArray*)titles objs:(NSArray*)objs;

-(void)addWithSection:(NSInteger)section titles:(NSArray*)titlles objs:(NSArray*)objs;

-(void)addWithSection:(NSInteger)section images:(NSArray *)images;
@end
