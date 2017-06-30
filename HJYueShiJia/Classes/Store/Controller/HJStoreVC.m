//
//  HJStoreVC.m
//  HJYueShiJia
//
//  Created by huangjian on 17/4/24.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "HJStoreVC.h"
#import "HJStoreCellModel.h"
#import "HJStoreCell.h"
#import "HJHeadIconModel.h"
#import "SDCycleScrollView.h"
#import "HJHeadIconCell.h"
#import "HJXsyhView.h"
#import "HJShopVC.h"
@interface HJStoreVC ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,SDCycleScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *backTopBtn;
@property (nonatomic, strong) NSMutableArray *imageArr;
@property (nonatomic, strong) NSMutableArray *cellModelArr;
@property (nonatomic, strong) NSMutableDictionary *cellHeights;

@property (nonatomic, strong) NSMutableDictionary *channelDict;
@property (nonatomic, strong) NSMutableArray *headModelArr;
@end

@implementation HJStoreVC
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
-(NSMutableArray *)imageArr
{
    if (!_imageArr) {
        _imageArr=[NSMutableArray array];
    }
    return _imageArr;
}
-(NSMutableArray *)headModelArr
{
    if (!_headModelArr) {
        _headModelArr=[NSMutableArray array];
    }
    return _headModelArr;
}
-(NSMutableDictionary *)channelDict
{
    if (!_channelDict) {
        _channelDict=[NSMutableDictionary dictionary];
    }
    return _channelDict;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    UIImageView *titleView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 60, 20)];
    titleView.image=[UIImage imageNamed:@"YS_food+"];
    self.navigationItem.titleView=titleView;
    self.navigationItem.rightBarButtonItem=[UIBarButtonItem barBtnItemWithImg:@"icon_home_search" highImg:@"searchbar_textfield_search_icon" target:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    [self getData];
    [self setUpTableView];
    [self setBackTopBtn];
}
-(void)setUpTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Width, Height)style:UITableViewStyleGrouped ];
    tableView.dataSource = self;
    tableView.delegate = self;
    self.tableView = tableView;
    [self.view addSubview:tableView];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
-(void)search
{
    
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
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellModelArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID=@"storeCell";
    HJStoreCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[HJStoreCell hj_viewFromXib];
    }
    cell.model=self.cellModelArr[indexPath.row];
    [self.cellHeights setObject:@([cell getCellHeight]) forKey:@(indexPath.row)];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.cellHeights[@(indexPath.row)] doubleValue];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView=[[UIView alloc]init];
    SDCycleScrollView *cycleView=[[SDCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, Width, 200)];
    [headerView addSubview:cycleView];
    cycleView.imageURLStringsGroup=self.imageArr;
    cycleView.placeholderImage=[UIImage imageNamed:@"place.png"];
    cycleView.dotColor=RGB(211, 192, 162, 1.0f);
    cycleView.pageControlStyle=SDCycleScrollViewPageContolStyleClassic;
    cycleView.delegate=self;
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing=0;
    layout.minimumInteritemSpacing=0;
    layout.itemSize=CGSizeMake(Width/4, 90);
    UICollectionView *collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 200, Width, 180) collectionViewLayout:layout];
    collectionView.backgroundColor=[UIColor whiteColor];
    collectionView.delegate=self;
    collectionView.dataSource=self;
    collectionView.scrollEnabled=NO;
    [headerView addSubview:collectionView];
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HJHeadIconCell class]) bundle:nil] forCellWithReuseIdentifier:@"iconCell"];
    
    HJXsyhView *xsyhView=[[HJXsyhView alloc]initWithFrame:CGRectMake(0, 380, Width, 200)];
    xsyhView.channelDict=self.channelDict;
    [headerView addSubview:xsyhView];
    
    
    return headerView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HJShopVC *vc=[[HJShopVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 580;
}
#pragma mark - collectionView代理，数据源
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 8;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HJHeadIconCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"iconCell" forIndexPath:indexPath];
    
    cell.model=self.headModelArr[indexPath.row];
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    HJHeadIconModel *model=self.headModelArr[indexPath.row];
    [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"兄弟，你点击了%@ !",model.tag_name]];
}

-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    
}



-(void)getData
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Store" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"----%@",json);
    NSMutableArray *array=json[@"datas"][@"banner"];
    for (int i=0; i<array.count; i++) {
        NSString *img=array[i][@"advertImg"];
        [self.imageArr addObject:img];
    }
    NSMutableArray *arr=[NSMutableArray array];
    arr=json[@"datas"][@"query"];
    for (int i=1; i<arr.count; i++) {
        HJStoreCellModel *model=[HJStoreCellModel mj_objectWithKeyValues:arr[i]];
        [self.cellModelArr addObject:model];
    }
    NSMutableArray *iconArr=[NSMutableArray array];
    iconArr=json[@"datas"][@"tag_classify"];
    for (int i=0; i<iconArr.count; i++) {
        HJHeadIconModel *model=[HJHeadIconModel mj_objectWithKeyValues:iconArr[i]];
        [self.headModelArr addObject:model];
    }
    self.channelDict=json[@"datas"][@"channel"];
   
}

@end
