//
//  HJHomeVC.m
//  HJYueShiJia
//
//  Created by huangjian on 17/4/24.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "HJHomeVC.h"
#import "HJHomeCellModel.h"
#import "HJHomeCell.h"
#import "SDCycleScrollView.h"
#import "UIImageView+WebCache.h"
#import "HJShopCell.h"
#import "HJShopVC.h"
#import "HJGoodsVC.h"
@interface HJHomeVC ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,SDCycleScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *backTopBtn;
//轮播图片数组
@property (nonatomic, strong) NSMutableArray *imageArr;
@property (nonatomic, strong) NSMutableArray *homeCellArray;
@property (nonatomic, strong) NSMutableDictionary *cellHeightDict;

@property (nonatomic, strong) NSString *headImage;
@property (nonatomic, strong) NSString *headText;

@property (nonatomic,strong) NSMutableArray *shopCellArray;
@end

@implementation HJHomeVC
-(NSMutableArray *)shopCellArray
{
    if (!_shopCellArray) {
        _shopCellArray=[NSMutableArray array];
    }
    return _shopCellArray;
}
-(NSMutableDictionary *)cellHeightDict
{
    if (!_cellHeightDict) {
        _cellHeightDict=[NSMutableDictionary dictionary];
    }
    return _cellHeightDict;
}
-(NSMutableArray *)imageArr
{
    if (!_imageArr) {
        _imageArr=[NSMutableArray array];
    }
    return _imageArr;
}
-(NSMutableArray *)homeCellArray
{
    if (!_homeCellArray) {
        _homeCellArray=[NSMutableArray array];
    }
    return _homeCellArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavi];
    [self setTabbleView];
    [self setBackTopBtn];
}
-(void)setTabbleView
{
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, Width, Height) style:UITableViewStyleGrouped];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
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
    UIImageView *titleView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 60, 20)];
    titleView.image=[UIImage imageNamed:@"YS_food+"];
    self.navigationItem.titleView=titleView;
    self.navigationItem.rightBarButtonItem=[UIBarButtonItem barBtnItemWithImg:@"icon_home_search" highImg:@"searchbar_textfield_search_icon" target:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
}
-(void)search
{
    
}
#pragma mark - tableView代理，数据源
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.homeCellArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cell=@"cellIdentify";
    HJHomeCell *homeCell=[tableView dequeueReusableCellWithIdentifier:cell];
    if (!homeCell) {
        homeCell=[HJHomeCell hj_viewFromXib];
    }
    homeCell.selectionStyle =UITableViewCellSelectionStyleNone;
    homeCell.homeCellModel=self.homeCellArray[indexPath.row];
    //获得cell 高度 放入字典
    [self.cellHeightDict setObject:@([homeCell getCellHeight]) forKey:@(indexPath.row)];
    return homeCell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.cellHeightDict[@(indexPath.row)] doubleValue];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HJGoodsVC *vc=[[HJGoodsVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - tableView头部
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView=[[UIView alloc]init];
    SDCycleScrollView *cycleView=[[SDCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, Width, 200)];
    [headView addSubview:cycleView];
    cycleView.imageURLStringsGroup=self.imageArr;
    cycleView.placeholderImage=[UIImage imageNamed:@"place.png"];
    cycleView.dotColor=RGB(211, 192, 162, 1.0f);
    cycleView.pageControlStyle=SDCycleScrollViewPageContolStyleClassic;
    cycleView.delegate=self;
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, cycleView.maxY, Width, 30)];
    label.text=@"YUESHI CHOSEN";
    label.textColor=RGB(231, 198, 168, 1.0f);
    label.textAlignment = NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:15.0];
    label.backgroundColor=[UIColor whiteColor];
    [headView addSubview:label];
    
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, label.maxY, Width, 200)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.headImage]];
    [headView addSubview:imageView];
    UIToolbar *toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, Width, 200)];
    toolBar.alpha=0.8;
    [imageView addSubview:toolBar];
    UIImageView *imageView1=[[UIImageView alloc]initWithFrame:CGRectMake(Width*0.2, 70, Width*0.6, 70)];
    imageView1.image=[UIImage imageNamed:@"InfoCelltitle"];
    [toolBar addSubview:imageView1];
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, imageView1.width, imageView1.height)];
    label1.textAlignment=NSTextAlignmentCenter;
    label1.text=self.headText;
    label1.font=[UIFont systemFontOfSize:17.0];
    [imageView1 addSubview:label1];
    imageView.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
    [imageView addGestureRecognizer:tap];
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing=15;
    layout.itemSize=CGSizeMake(120, 200);
    layout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    layout.sectionInset=UIEdgeInsetsMake(0, 15, 0, 15);
    
    UICollectionView *collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, imageView.maxY, Width, 220) collectionViewLayout:layout];
    collectionView.backgroundColor=[UIColor whiteColor];
    collectionView.delegate=self;
    collectionView.dataSource=self;
    collectionView.showsHorizontalScrollIndicator=NO;
    [headView addSubview:collectionView];
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HJShopCell class]) bundle:nil] forCellWithReuseIdentifier:@"shopCell"];
    return headView;
}

-(void)tapClick
{
    HJShopVC *vc=[[HJShopVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
        HJShopVC *vc=[[HJShopVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 650;
}
#pragma mark - collectionView代理，数据源
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 8;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HJShopCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"shopCell" forIndexPath:indexPath];
    
    cell.shopCellModel=self.shopCellArray[0];
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"兄弟，你点击了第%ld个!",indexPath.row]];
}
#pragma mark - 获取数据
-(void)getData
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Home" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    //NSLog(@"%@",json);
    NSMutableArray *bannerArr = [NSMutableArray array];
    bannerArr = json[@"datas"][@"banner"];
    for (int i=0; i<bannerArr.count; i++) {
        NSString *imageStr=bannerArr[i][@"advertImg"];
        [self.imageArr addObject:imageStr];
    }
    NSMutableArray *data_type = [NSMutableArray array];
    data_type = json[@"datas"][@"data_type"];
    for (int i=1; i<data_type.count; i++) {
        HJHomeCellModel *homeCellModel=[HJHomeCellModel mj_objectWithKeyValues:data_type[i]];
        [self.homeCellArray addObject:homeCellModel];
    }
    self.headText=json[@"datas"][@"data_type"][0][@"relation_object_title"];
    self.headImage=json[@"datas"][@"data_type"][0][@"relation_object_image"];
    HJShopCellModel *cellModel=[[HJShopCellModel alloc]init];
    cellModel.imageName=@"shasha.jpg";
    cellModel.name=@"妹纸加微信";
    cellModel.price=@"123.00";
    [self.shopCellArray addObject:cellModel];
}
@end
