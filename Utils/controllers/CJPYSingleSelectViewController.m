//
//  CJPYSingleSelectViewController.m
//  pinterest
//
//  Created by 彭 勇 on 12-11-12.
//
//

#import "CJPYSingleSelectViewController.h"
#import "UITableViewController+AutoHeight.h"
#import "UIImageView+WebCache.h"

@interface CJPYSingleSelectViewController ()
@property(nonatomic,copy)CJPYSelectBlock block;
@property(nonatomic,strong)NSMutableDictionary * dict;

@end

@implementation CJPYSingleSelectViewController
@synthesize dict=_dict;
@synthesize block=_block;
@synthesize selectIndexPath=_selectIndexPath;

- (id)init:(CJPYSelectBlock)block
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        self.block=block;
//        self.selectIndexPath=[NSIndexPath indexPathForItem:0 inSection:0];
    }
    return self;
}
- (id)init:(NSArray*)array keys:(NSArray*)keys select:(CJPYSelectBlock)block{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        self.block=block;
//        self.selectIndexPath=[NSIndexPath indexPathForItem:0 inSection:0];
        [self add:nil titles:array objs:keys];
    }
    return self;
}

- (id)init:(NSArray*)array keys:(NSArray*)keys initSelect:(NSIndexPath*)index select:(CJPYSelectBlock)block{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        self.block=block;
        self.selectIndexPath=index;
        [self add:nil titles:array objs:keys];
    }
    return self;
}

- (id)init:(NSArray*)array keys:(NSArray*)keys initSelectKey:(id)key select:(CJPYSelectBlock)block{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        self.block=block;
        [self add:nil titles:array objs:keys];
        NSInteger rowIndex=[keys indexOfObject:key];
        self.selectIndexPath=[NSIndexPath indexPathForRow:rowIndex inSection:0];
    }
    return self;
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self forcePopoverSize];

}
-(void)viewWillAppear:(BOOL)animated{
    [self reloadViewHeight:300 min:100 max:1000];
    [super viewWillAppear:animated];
}

-(NSMutableDictionary*)dict{
    if (!_dict) {
        _dict =[NSMutableDictionary dictionary];
    }
    return _dict;
}

-(void)add:(NSString*)section titles:(NSArray*)titles objs:(NSArray*)objs{
    NSNumber * key=[NSNumber numberWithInteger:[self.dict count]];
    NSMutableDictionary * dict=[NSMutableDictionary dictionaryWithDictionary:@{@"titles":titles,@"numberOfRowsInSection":[NSNumber numberWithInteger:[titles count]]}];
    if (section) {
        [dict setObject:section forKey:@"sectionTitle"];
    }
    if (objs) {
        [dict setObject:objs forKey:@"objs"];
    }
    [self.dict setObject:dict forKey:key];
}

-(void)addWithSection:(NSInteger)section titles:(NSArray*)titlles objs:(NSArray*)objs{
    NSNumber * key=[NSNumber numberWithInteger:section];
    NSMutableDictionary * dict=[self.dict objectForKey:key];
    NSMutableArray * allTitles=[NSMutableArray arrayWithArray:[dict objectForKey:@"titles"]];
    [allTitles addObjectsFromArray:titlles];
    [dict setObject:allTitles forKey:@"titles"];
    
    
    NSMutableArray * allObjs=[NSMutableArray arrayWithArray:[dict objectForKey:@"objs"]];
    [allObjs addObjectsFromArray:objs];
    [dict setObject:allObjs forKey:@"objs"];
    
    [dict setObject:@([allTitles count]) forKey:@"numberOfRowsInSection"];
    
    [self.dict setObject:dict forKey:key];
}

-(void)addWithSection:(NSInteger)section images:(NSArray *)images{
    NSNumber * key=[NSNumber numberWithInteger:section];
    NSMutableDictionary * dict=[self.dict objectForKey:key];
    NSMutableArray * allImages=[NSMutableArray arrayWithArray:[dict objectForKey:@"images"]];
    [allImages addObjectsFromArray:images];
    [dict setObject:allImages forKey:@"images"];
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dict count];;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSDictionary * sectionDict=[self.dict objectForKey:[NSNumber numberWithInteger:section]];
    NSNumber * number=[sectionDict objectForKey:@"numberOfRowsInSection"];
    return number.intValue?[sectionDict objectForKey:@"sectionTitle"]:nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary * sectionDict=[self.dict objectForKey:[NSNumber numberWithInteger:section]];
    NSNumber * number=[sectionDict objectForKey:@"numberOfRowsInSection"];
    return [number intValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.textLabel.textAlignment=NSTextAlignmentLeft;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    NSDictionary * sectionDict=[self.dict objectForKey:[NSNumber numberWithInteger:indexPath.section]];
    NSArray * array=[sectionDict objectForKey:@"titles"];
    NSArray * images=[sectionDict objectForKey:@"images"];
   
    NSString * str=[[array objectAtIndex:indexPath.row] description];
    cell.textLabel.text=str;
    if(images&&[images count]){
        id  obj=[images objectAtIndex:indexPath.row];
        if ([obj isKindOfClass:[UIImage class]]) {
            [cell.imageView setImage:obj];
        }else if ([obj isKindOfClass:[NSURL class]]){
            [cell.imageView setImageWithURL:obj];
        }else if ([obj isKindOfClass:[NSString class]]){
            [cell.imageView setImageWithURL:obj];
        }
        
    }
    if ([indexPath isEqual:self.selectIndexPath]) {
        cell.accessoryType=UITableViewCellAccessoryCheckmark;
    }
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * sectionDict=[self.dict objectForKey:[NSNumber numberWithInteger:indexPath.section]];
    NSArray * titles=[sectionDict objectForKey:@"titles"];

    NSArray * objs=[sectionDict objectForKey:@"objs"];

    
    id key=[objs objectAtIndex:indexPath.row];
    id text=[titles objectAtIndex:indexPath.row];
    UITableViewCell * cell=[tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType=UITableViewCellAccessoryCheckmark;
    
    if (![self.selectIndexPath isEqual:indexPath]) {
        UITableViewCell * preSelectCell=[tableView cellForRowAtIndexPath:self.selectIndexPath];
        preSelectCell.accessoryType=UITableViewCellAccessoryNone;
        self.selectIndexPath=indexPath;
    }
    if (self.block) {
      self.block(key,text);  
    }
}

@end
