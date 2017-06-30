//
//  HJShopVC.m
//  HJYueShiJia
//
//  Created by huangjian on 17/4/25.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "HJShopVC.h"
#import "HJShopListCell.h"
#import "HJBasketVC.h"
@interface HJShopVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *cellArray;
@property (nonatomic, strong) NSMutableDictionary *cellHeightDict;

@property (nonatomic,copy)NSString *headImgUrl;
@property (nonatomic,copy)NSString *headText;
@property (nonatomic,assign)CGFloat height;

@property (nonatomic, strong) UIButton *backTopBtn;
@end

@implementation HJShopVC
-(NSMutableArray *)cellArray
{
    if (!_cellArray) {
        _cellArray=[NSMutableArray array];
    }
    return _cellArray;
}
-(NSMutableDictionary *)cellHeightDict
{
    if (!_cellHeightDict) {
        _cellHeightDict=[NSMutableDictionary dictionary];
    }
    return _cellHeightDict;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self setNavi];
    [self getData];
    [self setTableView];
    [self setBackTopBtn];
}
-(void)setBackTopBtn
{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:@"icon_back_top"] forState:UIControlStateNormal];
    btn.hidden=YES;
    [btn addTarget:self action:@selector(backTop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.sd_layout.rightSpaceToView(self.view,50).bottomSpaceToView(self.view,70).widthIs(44).heightIs(44);
    self.backTopBtn=btn;
}

#pragma mark - 回顶部
-(void)backTop
{
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y>Height) {
        self.backTopBtn.hidden=NO;
    }else
    {
        self.backTopBtn.hidden=YES;
    }
}
#pragma mark - 设置导航栏
-(void)setNavi
{
    UIBarButtonItem *basketBtn=[UIBarButtonItem barBtnItemWithImg:@"YS_car_sel"highImg:@"YS_car_nor" target:self action:@selector(basketClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *shareBtn=[UIBarButtonItem barBtnItemWithImg:@"YSShare" highImg:@"YSShare_end" target:self action:@selector(shareClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItems=@[shareBtn,basketBtn];
}
-(void)basketClick
{
    HJBasketVC *basket=[[HJBasketVC alloc]init];
    [self.navigationController pushViewController:basket animated:YES];
}
-(void)shareClick
{
    
}
#pragma mark - 设置tableView
-(void)setTableView
{
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, Width, Height) style:UITableViewStyleGrouped];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID=@"shopListCell";
    HJShopListCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[HJShopListCell hj_viewFromXib];
    }
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    cell.shopListModel=self.cellArray[indexPath.row];
    [self.cellHeightDict setObject:@([cell getCellHeight]) forKey:@(indexPath.row)];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.cellHeightDict[@(indexPath.row)] doubleValue];
    
}
#pragma mark - tableView头部
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Width, 200+self.height)];
    headView.backgroundColor=[UIColor whiteColor];
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Width, 180)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.headImgUrl]];
    [headView addSubview:imageView];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10, 190, Width-20, self.height)];
    label.text=self.headText;
    label.numberOfLines=0;
    label.font=[UIFont systemFontOfSize:13];
    label.textAlignment=NSTextAlignmentCenter;
    [headView addSubview:label];
    return headView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 200+self.height;
}
#pragma mark - 获取数据
-(void)getData
{
    NSString *path=[[NSBundle mainBundle] pathForResource:@"store_detailcell" ofType:@"json"];
    NSData *data=[NSData dataWithContentsOfFile:path];
    NSDictionary *json=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    self.title=json[@"datas"][@"special_title"];
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:RGB(230, 198, 168, 1)};
    self.headImgUrl=json[@"datas"][@"special_image"];
    self.headText=json[@"datas"][@"special_stitle"];
    self.height=[UILabel hj_getHeightByWidth:Width-20 title:self.headText font:[UIFont systemFontOfSize:13]];
    NSArray *dataArr=[NSArray array];
    dataArr=json[@"datas"][@"goods_list"];
    for (int i=0; i<dataArr.count; i++) {
        HJShopListModel *model=[HJShopListModel mj_objectWithKeyValues:dataArr[i]];
        [self.cellArray addObject:model];
    }
}
@end
