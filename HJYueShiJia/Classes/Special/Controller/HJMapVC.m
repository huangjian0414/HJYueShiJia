//
//  HJMapVC.m
//  HJYueShiJia
//
//  Created by huangjian on 17/5/4.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "HJMapVC.h"
#import "HJMapCell.h"
#import "HJMapModel.h"
#import "HJGoodsDetilVC.h"

@interface HJMapVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, weak) UITableView *tableView;


@property (nonatomic, strong) NSMutableDictionary *cellHeights;

@property (nonatomic, strong) NSMutableArray *cellModelArr;
@end

@implementation HJMapVC
-(NSMutableDictionary *)cellHeights
{
    if (!_cellHeights) {
        _cellHeights=[NSMutableDictionary dictionary];
    }
    return _cellHeights;
}
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
    static NSString *ID=@"mapCell";
    HJMapCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[HJMapCell hj_viewFromXib];
    }
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    cell.model=self.cellModelArr[indexPath.row];
    [self.cellHeights setObject:@([cell getCellHeight]) forKey:@(indexPath.row)];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.cellHeights[@(indexPath.row)]doubleValue];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HJGoodsDetilVC *vc=[[HJGoodsDetilVC alloc]init];
    vc.goodsDetailURL=@"http://interface.yueshichina.com//?act=cms_index&op=article_content&type_id=3&article_id=1064";
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)getData
{
    NSString *path=[[NSBundle mainBundle]pathForResource:@"map" ofType:@"json"];
    NSData *data=[NSData dataWithContentsOfFile:path];
    NSDictionary *json=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    NSArray *map=json[@"datas"][@"article_list"];
    for (NSDictionary *dict in map) {
        HJMapModel *model=[HJMapModel mj_objectWithKeyValues:dict];
        [self.cellModelArr addObject:model];
    }
    
}


@end
