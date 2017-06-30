//
//  HJGoodsVC.m
//  HJYueShiJia
//
//  Created by huangjian on 17/4/27.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "HJGoodsVC.h"
#import "HJToolBarView.h"
#import "HJGoodsModel.h"
#import "HJGoodsCell.h"
#import "SDCycleScrollView.h"
#import "HJBuyView.h"
#import "HJGoodsDetilVC.h"
#import "FMDB.h"
#import "HJStoreHomeVC.h"
#import "HJBasketVC.h"
@interface HJGoodsVC ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,HJToolBarDelegate,HJBuyViewDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,copy)NSString *goodsDetailURL;
@property (nonatomic,strong)NSMutableArray *goodsModelArr;
@property (nonatomic,strong)NSMutableDictionary *goodsCellHeightDic;

@property (nonatomic,strong)NSArray *goodsImgArr;
@property (nonatomic,strong)NSArray *scrollImgArr;

@property (nonatomic,copy)NSString *goodsDesc;

@property (nonatomic,strong)NSArray *cellTextArr;

@property (nonatomic,strong)HJBuyView *buyView;

@property (nonatomic, strong) FMDatabase *db;

@property (nonatomic,weak)SDCycleScrollView *cycleView;

@property (nonatomic,assign)BOOL isNaviHidden;
@end

@implementation HJGoodsVC
-(NSMutableDictionary *)goodsCellHeightDic
{
    if (!_goodsCellHeightDic) {
        _goodsCellHeightDic=[NSMutableDictionary dictionary];
    }
    return _goodsCellHeightDic;
}
-(NSMutableArray *)goodsModelArr
{
    if (!_goodsModelArr) {
        _goodsModelArr=[NSMutableArray array];
    }
    return _goodsModelArr;
}
-(NSArray *)goodsImgArr
{
    if (!_goodsImgArr) {
        _goodsImgArr=[NSArray array];
    }
    return _goodsImgArr;
}
-(NSArray *)scrollImgArr
{
    if (!_scrollImgArr) {
        _scrollImgArr=[NSArray array];
    }
    return _scrollImgArr;
}
-(NSArray *)cellTextArr
{
    return @[@"产品详情",@"商品评价",@"物流信息"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.isNaviHidden=NO;
    [self getData];
    [self setNavi];
    [self settableView];
    [self setToolBar];
}
#pragma mark - 布局
-(void)setToolBar
{
    HJToolBarView *toolView=[[HJToolBarView alloc]initWithFrame:CGRectMake(0, Height-44, Width, 44)];
    toolView.delegate=self;
    [self.view addSubview:toolView];
}

-(void)settableView
{
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, -44, Width, Height) style:UITableViewStyleGrouped];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
    
}
-(void)setNavi
{
    self.title=@"商品详情";
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:RGB(230, 198, 168, 1)};
    self.navigationItem.rightBarButtonItem=[UIBarButtonItem barBtnItemWithImg:@"YSShare" highImg:@"YSShare_end" target:self action:@selector(goodshare) forControlEvents:UIControlEventTouchUpInside];
}
-(void)goodshare
{
    self.buyView.hidden=YES;
}
#pragma  mark - toolBarView代理
-(void)touchAddBasket
{
    if (!self.buyView) {
        self.buyView=[[HJBuyView alloc]initWithFrame:self.view.frame];
        [self.view addSubview:self.buyView];
    }
    self.buyView.delegate=self;
    self.buyView.hidden=NO;
    self.buyView.imageStr=self.goodsImgArr[0];
    self.buyView.goodsModel=self.goodsModelArr[0];
    
    
}
-(void)touchStore
{
    HJStoreHomeVC *vc=[[HJStoreHomeVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)touchBasket
{
    HJBasketVC *vc=[[HJBasketVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - buyView代理
-(void)touchDoneWith:(NSInteger)num ImageView:(UIImageView *)ImgView
{
    UIImageView *picImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, Height*0.6, 50, 50)];
    picImageView.image = ImgView.image;
    //self.picImageView = picImageView;
    [self.buyView addSubview:picImageView];
    
    CABasicAnimation *rotaAnim=[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotaAnim.toValue=[NSNumber numberWithFloat:M_PI*11.0];
    rotaAnim.duration=1;
    rotaAnim.cumulative=YES;
    rotaAnim.repeatCount=0;
    [picImageView.layer addAnimation:rotaAnim forKey:nil];
    [UIView animateWithDuration:1.0 animations:^{
        picImageView.frame=CGRectMake(10, Height-20, 0, 0);
    } completion:^(BOOL finished) {
        self.buyView.hidden=YES;
        HJGoodsModel *model=self.goodsModelArr[0];
        NSString *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
        NSString *sqlitePath=[path stringByAppendingPathComponent:@"goods.sqlite"];
        self.db=[FMDatabase databaseWithPath:sqlitePath];
        if ([self.db open]) {
            NSLog(@"打开成功");
            BOOL isCreatTable=[self.db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_goods (id INTEGER PRIMARY KEY AUTOINCREMENT, goods_name varchar NOT NULL, goods_desc varchar NOT NULL, goods_price varchar NOT NULL,goods_num varchar NOT NULL, goods_img varchar NOT NULL)"];
            if (isCreatTable) {
                NSLog(@"创建表成功");
                BOOL success=[self.db executeUpdate:@"INSERT INTO t_goods (goods_name, goods_desc,goods_price,goods_num,goods_img) VALUES (?,?,?,?,?);", model.goodsName,self.goodsDesc,model.goodsPrice,[NSString stringWithFormat:@"%ld",num],self.goodsImgArr[0]];
                if (success) {
                    NSLog(@"插入成功");
                    [SVProgressHUD showSuccessWithStatus:@"加入购物篮成功"];
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"updateData" object:nil];
                    
                }else
                {
                    NSLog(@"插入失败");
                }
            }else
            {
                NSLog(@"创建表失败");
            }
        }else
        {
            NSLog(@"打开失败");
        }
        
    }];
    
    [self.db close];
}
#pragma mark - tableView代理，数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID=@"goodsCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.row==0) {
        
        
        HJGoodsCell *goodsCell=[HJGoodsCell hj_viewFromXib];
        goodsCell.selectionStyle =UITableViewCellSelectionStyleNone;
        goodsCell.goodsModel=self.goodsModelArr[0];
        [self.goodsCellHeightDic setObject:@([goodsCell getCellHeight]) forKey:@(indexPath.row)];
        return goodsCell;
    }else if (indexPath.row==1)
    {
        cell.textLabel.text=self.goodsDesc;
        
        cell.accessoryType = UITableViewCellAccessoryNone;
    }else if (indexPath.row==2)
    {
        cell.textLabel.text = @"产品详情";
        
    }else if (indexPath.row==3)
    {
        cell.textLabel.text = @"商品评价";
    }else if (indexPath.row==4)
    {
        cell.textLabel.text = @"物流信息";
    }
    else if(indexPath.row==5)
    {
       UITableViewCell * cell1=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell1"];
        cell1.textLabel.text=@"联系客服(9:00-18:00)";
        cell1.detailTextLabel.text=@"4006-277-717";
        cell1.selectionStyle =UITableViewCellSelectionStyleNone;
        return cell1;
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==2) {
        HJGoodsDetilVC *vc=[[HJGoodsDetilVC alloc]init];
        vc.goodsDetailURL=self.goodsDetailURL;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    SDCycleScrollView *cycleView=[[SDCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, Width, Width*1.5)];
    cycleView.imageURLStringsGroup=self.scrollImgArr;
    cycleView.placeholderImage=[UIImage imageNamed:@"mine_backgroundImg"];
    cycleView.dotColor=RGB(211, 192, 162, 1.0f);
    cycleView.pageControlStyle=SDCycleScrollViewPageContolStyleClassic;
    
    self.cycleView=cycleView;
    return cycleView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return Width*1.5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0||indexPath.row==1) {
        return [self.goodsCellHeightDic[@(0)] doubleValue];
    }else
    {
        return 44;
    }
}
#pragma mark - scrollView代理
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if (velocity.y<0) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        self.isNaviHidden=NO;
    }else
    {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        self.isNaviHidden=YES;
    }
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    if (self.isNaviHidden) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
    
}
#pragma mark - 获取数据
-(void)getData
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Goods_detail" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSDictionary *datas=json[@"datas"];
    HJGoodsModel *model=[[HJGoodsModel alloc]init];
    model.goodsName=datas[@"goods_info"][@"goods_name"];
    model.goodsPrice=datas[@"goods_info"][@"goods_price"];
    model.goodsOrigPrice=datas[@"goods_info"][@"goods_marketprice"];
    model.goodsSaleNum=datas[@"goods_info"][@"goods_salenum"];
    [self.goodsModelArr addObject:model];
    self.goodsDesc=datas[@"goods_info"][@"goods_jingle"];
    self.goodsImgArr=datas[@"spec_image"];
    self.goodsDetailURL=datas[@"goods_detaileds"];
    self.scrollImgArr=[datas[@"goods_image"] componentsSeparatedByString:@","];
    
}

@end
