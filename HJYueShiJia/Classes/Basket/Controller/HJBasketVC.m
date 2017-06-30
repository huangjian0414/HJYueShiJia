//
//  HJBasketVC.m
//  HJYueShiJia
//
//  Created by huangjian on 17/4/24.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "HJBasketVC.h"
#import "FMDB.h"
#import "HJBasketGoodsCell.h"
#import "HJBasketGoodsModel.h"
#import "MJRefresh.h"
@interface HJBasketVC ()<UITableViewDelegate,UITableViewDataSource,HJBasketGoodsDelegate>
@property (nonatomic, strong) FMDatabase *db;
@property (nonatomic, strong) NSMutableArray *cellModelArr;
@property (nonatomic, weak) UITableView *tableView ;
@property (nonatomic, strong) NSMutableDictionary *cellHeights;

@property (nonatomic,weak)UIButton *headAllselectedBtn;
@property (nonatomic,weak)UIButton *footAllselectedBtn;
@property (nonatomic,weak)UILabel *allPrice;
@property (nonatomic,assign)BOOL allSelected;

@end

@implementation HJBasketVC
-(NSMutableArray *)cellModelArr
{
    if (!_cellModelArr) {
        _cellModelArr=[NSMutableArray array];
    }
    return _cellModelArr;
}
-(NSMutableDictionary *)cellHeights
{
    if (!_cellHeights) {
        _cellHeights=[NSMutableDictionary dictionary];
    }
    return _cellHeights;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"购物篮";
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:RGB(230, 198, 168, 1)};
    self.navigationItem.rightBarButtonItem=[UIBarButtonItem barBtnItemWithText:@"编辑" textColor:[UIColor grayColor] target:self action:@selector(edit) forControlEvents:UIControlEventTouchUpInside];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshData:) name:@"updateData" object:nil];
    [self setUpTableView];
    [self setUpFootView];
    self.tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getData];
        [self update];
        [self.tableView reloadData];
    }];
    [self.tableView.mj_header beginRefreshing];
}
-(void)setUpTableView
{
    UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, Width, Height) style:UITableViewStyleGrouped];
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:tableView];
    self.tableView=tableView;
}
-(void)setUpFootView
{
    UIView *footView=[[UIView alloc]init];
    footView.backgroundColor=[UIColor whiteColor];
    footView.layer.borderColor=RGB(230, 198, 168, 1).CGColor;
    footView.layer.borderWidth=0.5;
    [self.view addSubview:footView];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"car_noSelect"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"car_Select"] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(clickAllSelectedBtn:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:btn];
    self.footAllselectedBtn=btn;
    
    UILabel *allSelect = [[UILabel alloc] init];
    allSelect.text = @"全选";
    [footView addSubview:allSelect];
    
    UILabel *allPrice = [[UILabel alloc] init];
    allPrice.text = @"合计:";
    allPrice.textAlignment = NSTextAlignmentRight;
    allPrice.font = [UIFont systemFontOfSize:13.0];
    [footView addSubview:allPrice];
    
    UILabel *totalPrice = [[UILabel alloc] init];
    totalPrice.text =@"￥0.00";
    totalPrice.textAlignment = NSTextAlignmentLeft;
    totalPrice.font = [UIFont systemFontOfSize:13.0];
    totalPrice.textColor = RGB(230, 198, 168, 1);
    self.allPrice = totalPrice;
    [footView addSubview:totalPrice];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setBackgroundColor:RGB(230, 198, 168, 1)];
    [btn1 setTitle:@"结算" forState:UIControlStateNormal];
    [btn1 setTintColor:[UIColor whiteColor]];
    [btn1.titleLabel setFont:[UIFont systemFontOfSize:16.0]];
    [btn1 addTarget:self action:@selector(buyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:btn1];
    
    footView.sd_layout.leftSpaceToView(self.view,0.5).rightSpaceToView(self.view,0.5).bottomSpaceToView(self.view,43.5).heightIs(44);
    btn.sd_layout.leftSpaceToView(footView,10).topSpaceToView(footView,11).widthIs(20).heightIs(20);
    allSelect.sd_layout.leftSpaceToView(btn,10).topEqualToView(btn).widthIs(40).heightIs(20);
    btn1.sd_layout.rightEqualToView(footView).topEqualToView(footView).bottomEqualToView(footView).widthIs(100);
    totalPrice.sd_layout.topEqualToView(btn).rightSpaceToView(btn1,20).heightIs(20);
    [totalPrice setSingleLineAutoResizeWithMaxWidth:100];
    allPrice.sd_layout.topEqualToView(totalPrice).rightSpaceToView(totalPrice,5).widthIs(40).heightIs(20);

}
-(void)buyBtnClick
{
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellModelArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID=@"basketgoodsCell";
    HJBasketGoodsCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[HJBasketGoodsCell hj_viewFromXib];
    }
    cell.model=self.cellModelArr[indexPath.row];
    cell.indexPath=indexPath;
    [self.cellHeights setObject:@([cell getCellHeight]) forKey:@(indexPath.row)];
    cell.delegate=self;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.cellHeights[@(indexPath.row)]doubleValue];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView=[[UIView alloc]init];
    headView.backgroundColor=[UIColor whiteColor];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"car_noSelect"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"car_Select"] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(clickAllSelectedBtn:) forControlEvents:UIControlEventTouchUpInside];
    btn.selected=self.allSelected;
    [headView addSubview:btn];
    self.headAllselectedBtn=btn;
    
    UIImageView *imgView=[[UIImageView alloc]init];
    imgView.image=[UIImage imageNamed:@"shopIcon"];
    [headView addSubview:imgView];
    
    UILabel *nameLabel=[[UILabel alloc]init];
    nameLabel.text = @"悦食家";
    nameLabel.textColor = RGB(230, 198, 168, 1);
    nameLabel.font = [UIFont systemFontOfSize:15.0];
    [headView addSubview:nameLabel];
    
    UIImageView *rightView=[[UIImageView alloc]init];
    rightView.image=[UIImage imageNamed:@"btn_in"];
    [headView addSubview:rightView];
    
    btn.sd_layout.topSpaceToView(headView,11).leftSpaceToView(headView,10).widthIs(20).heightIs(20);
    imgView.sd_layout.topEqualToView(btn).leftSpaceToView(btn,20).widthRatioToView(btn,1).heightRatioToView(btn,1);
    nameLabel.sd_layout.topEqualToView(btn).leftSpaceToView(imgView,20).heightIs(20);
    rightView.sd_layout.rightSpaceToView(headView,15).centerYEqualToView(headView).widthIs(6).heightIs(11);
    return headView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *delete=[UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        HJBasketGoodsModel *model=self.cellModelArr[indexPath.row];
        NSInteger index=[model.goods_id integerValue];
        [self.cellModelArr removeObjectAtIndex:indexPath.row];
        [self deleteGoods:index];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self update];
    }];
    return @[delete];
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(void)deleteGoods:(NSInteger)index
{
//    NSString *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
//    NSString *sqlPath=[path stringByAppendingPathComponent:@"goods.sqlite"];
//    self.db=[FMDatabase databaseWithPath:sqlPath];
    if ([self.db open]) {
        NSLog(@"-----打开成功");
        NSString *deleteSql=[NSString stringWithFormat:@"DELETE FROM t_goods WHERE id == %ld;",index];
        BOOL success=[self.db executeUpdate:deleteSql];
        if (success) {
            NSLog(@"----删除成功");
        }else
        {
            NSLog(@"----删除失败");
        }
    }else
    {
        NSLog(@"---打开失败");
    }
    [self.db close];
}

-(void)clickAllSelectedBtn:(UIButton *)btn
{
    btn.selected=!btn.selected;
    self.allSelected=btn.selected;
    self.footAllselectedBtn.selected=btn.selected;
    for (HJBasketGoodsModel *model in self.cellModelArr) {
        model.isSelected=btn.selected;
    }
    [self update];
    
}
-(void)selectedGoods:(NSIndexPath *)indexPath selectedBtn:(UIButton *)btn
{
    
    HJBasketGoodsModel *model=self.cellModelArr[indexPath.row];
    model.isSelected=btn.selected;
    [self update];
}
-(void)update
{
    CGFloat money=0;
    NSInteger count=0;
    for (HJBasketGoodsModel *model in self.cellModelArr) {
        if (model.isSelected==YES) {
            money=money+[model.goods_price floatValue]*[model.goods_num floatValue];
            count=count+1;
        }
    }
    if (count==self.cellModelArr.count&&count!=0) {
        //全选
        self.allSelected=YES;
        self.footAllselectedBtn.selected=YES;
    }else
    {
        self.allSelected=NO;
        self.footAllselectedBtn.selected=NO;
    }
    self.allPrice.text=[NSString stringWithFormat:@"¥:%.2lf",money];
    [self.tableView reloadData];
    
}
-(void)edit
{
    
}
-(void)refreshData:(NSNotification *)info
{
    [self.tableView.mj_header beginRefreshing];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)getData
{
    NSString *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *sqlPath=[path stringByAppendingPathComponent:@"goods.sqlite"];
    
    self.db=[FMDatabase databaseWithPath:sqlPath];
    if ([self.db open]) {
        NSLog(@"--打开成功！");
        FMResultSet *result=[self.db executeQuery:@"SELECT id, goods_name, goods_desc, goods_price, goods_num, goods_img FROM t_goods ;"];
        NSMutableArray *array=[NSMutableArray array];
        while ([result next]) {
            NSInteger ID = [result intForColumnIndex:0];
            NSString *goods_id = [NSString stringWithFormat:@"%ld",ID];
            NSString *goods_name = [result stringForColumn:@"goods_name"];
            NSString *goods_desc = [result stringForColumn:@"goods_desc"];
            NSString *goods_price = [result stringForColumn:@"goods_price"];
            NSString *goods_img = [result stringForColumn:@"goods_img"];
            NSString *goods_num = [result stringForColumn:@"goods_num"];
            
            NSDictionary *dict = [NSDictionary dictionary];
            dict = @{@"goods_id":goods_id,@"goods_name":goods_name,@"goods_desc":goods_desc,@"goods_price":goods_price,@"goods_img":goods_img,@"goods_num":goods_num};
            [array addObject:dict];
        }
        [self.cellModelArr removeAllObjects];
        for (NSDictionary *dict in array) {
            HJBasketGoodsModel *model=[HJBasketGoodsModel mj_objectWithKeyValues:dict];
            model.isSelected=NO;
            [self.cellModelArr addObject:model];
        }
        [self.tableView.mj_header endRefreshing];
    }else
    {
        NSLog(@"---打开失败！");
        [self.tableView.mj_header endRefreshing];
    }
    [self.db close];
   
}
@end
