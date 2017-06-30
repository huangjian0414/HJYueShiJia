//
//  HJActivityVC.m
//  HJYueShiJia
//
//  Created by huangjian on 17/5/4.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "HJActivityVC.h"
#import "HJActivityModel.h"
#import "HJActivityCell.h"
@interface HJActivityVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *cellModelArr;
@end

@implementation HJActivityVC
-(NSMutableArray *)cellModelArr
{
    if (!_cellModelArr) {
        _cellModelArr=[NSMutableArray array];
    }
    return _cellModelArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData];
    [self setUpTableView];
}
-(void)setUpTableView
{
    UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64+44, Width, Height-64-44-44) style:UITableViewStyleGrouped];
    tableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0.001)];
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    self.tableView=tableView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellModelArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID=@"activityCell";
    HJActivityCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[HJActivityCell hj_viewFromXib];
    }
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    cell.model=self.cellModelArr[indexPath.row];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180;
}

-(void)getData
{
    NSString *path=[[NSBundle mainBundle]pathForResource:@"activity" ofType:@"json"];
    NSData *data=[NSData dataWithContentsOfFile:path];
    NSDictionary *json=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    NSArray *map=json[@"datas"][@"virtual"];
    for (NSDictionary *dict in map) {
        HJActivityModel *model=[HJActivityModel mj_objectWithKeyValues:dict];
        [self.cellModelArr addObject:model];
    }
    
}



@end
