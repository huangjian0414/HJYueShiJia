//
//  HJStoreHomeVC.m
//  HJYueShiJia
//
//  Created by huangjian on 17/5/2.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "HJStoreHomeVC.h"
#import "HJStoreHomeCell.h"
#import "HJStoreHeaderView.h"
static NSString *storeCell=@"storeCell";
static NSString *storeHeader=@"storeHeader";
@interface HJStoreHomeVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,assign)BOOL isGrid;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray *cellModelArr;

@property (nonatomic,copy)NSString *ImgURL;

@property (nonatomic, strong) UIButton *rightBtn;
@end

@implementation HJStoreHomeVC
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
    self.isGrid=NO;
    [self setUpNavi];
    self.view.backgroundColor=[UIColor whiteColor];
    [self setUpCollectionView];
}
-(void)setUpNavi
{
    self.title=@"悦食家";
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:RGB(230, 198, 168, 1)};
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightBtn = rightButton;
    [rightButton setBackgroundImage:[UIImage imageNamed:@"product_list_grid_btn"] forState:UIControlStateNormal];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"product_list_grid_btn"] forState:UIControlStateHighlighted];

    rightButton.size = rightButton.currentBackgroundImage.size;
    [rightButton addTarget:self action:@selector(listTouch) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem= rightItem;
}
-(void)listTouch
{
    self.isGrid=!self.isGrid;
    [self.collectionView reloadData];
    if (self.isGrid) {
        [self.rightBtn setBackgroundImage:[UIImage imageNamed:@"product_list_list_btn"] forState:UIControlStateNormal];
    } else {
        [self.rightBtn setBackgroundImage:[UIImage imageNamed:@"product_list_grid_btn"] forState:UIControlStateNormal];
    }
    
}
-(void)setUpCollectionView
{
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing=0;
    layout.minimumInteritemSpacing=0;
    self.collectionView=[[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
    
    [self.collectionView registerClass:[HJStoreHomeCell class] forCellWithReuseIdentifier:storeCell];
    [self.collectionView registerClass:[HJStoreHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:storeHeader];
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
    self.collectionView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.collectionView];
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.cellModelArr.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HJStoreHomeCell *Cell= [collectionView dequeueReusableCellWithReuseIdentifier:storeCell forIndexPath:indexPath];
    Cell.isGrid=self.isGrid;
    Cell.storeHomeCellModel=self.cellModelArr[indexPath.row];
    
    return Cell;
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview=nil;
    if (kind==UICollectionElementKindSectionHeader) {
        HJStoreHeaderView *headerView=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:storeHeader forIndexPath:indexPath];
        headerView.imgURL=self.ImgURL;
        reusableview=headerView;
        return reusableview;
    }
    return nil;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
        return CGSizeMake(Width, 200 );
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isGrid) {
        return CGSizeMake((Width-20)/2, (Width-20)/2+100);
    }else
    {
    return CGSizeMake(Width-10, Width/3);
    }
}

-(void)getData
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"StoreHome" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    NSArray *list=json[@"datas"][@"goods_list"];
    for (NSDictionary *dict in list) {
        HJStoreHomeCellModel *model=[HJStoreHomeCellModel mj_objectWithKeyValues:dict];
        [self.cellModelArr addObject:model];
    }
    self.ImgURL=json[@"datas"][@"store_banner"];
}

@end
