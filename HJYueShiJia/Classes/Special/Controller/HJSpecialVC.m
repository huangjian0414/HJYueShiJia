//
//  HJSpecialVC.m
//  HJYueShiJia
//
//  Created by huangjian on 17/4/24.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "HJSpecialVC.h"
#import "HJVideoVC.h"
#import "HJListTopVC.h"
#import "HJKnowledgeVC.h"
#import "HJHumanismVC.h"
#import "HJMapVC.h"
#import "HJActivityVC.h"
@interface HJSpecialVC ()<UIScrollViewDelegate,UINavigationControllerDelegate>
@property (nonatomic,weak)UIView *indicatorView;
@property (nonatomic,weak)UIButton *selectedBtn;
@property (nonatomic,weak)UIScrollView *scrollView;

@property (nonatomic,weak)UIView *titleView;
@end

@implementation HJSpecialVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self setUpNavi];
    [self setUpChildViews];
    [self setUpheadersView];
    [self setUpUnderScrollView];
}
-(void)setUpUnderScrollView
{
    UIScrollView *scroll=[[UIScrollView alloc]initWithFrame:self.view.frame];
    scroll.backgroundColor=[UIColor whiteColor];
    scroll.delegate=self;
    scroll.pagingEnabled=YES;
    //scroll.showsHorizontalScrollIndicator=NO;
    scroll.contentSize=CGSizeMake(scroll.width*self.childViewControllers.count, 0);
    [self.view insertSubview:scroll atIndex:0];
    self.scrollView=scroll;
    //不自动调整inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self scrollViewDidEndScrollingAnimation:scroll];
}
-(void)setUpChildViews
{
    HJVideoVC *vc1=[[HJVideoVC alloc]init];
    vc1.title=@"视频";
    [self addChildViewController:vc1];
    
    HJListTopVC *vc2=[[HJListTopVC alloc]init];
    vc2.title=@"榜单";
    [self addChildViewController:vc2];
    
    HJKnowledgeVC *vc3=[[HJKnowledgeVC alloc]init];
    vc3.title=@"知识";
    [self addChildViewController:vc3];
    
    HJActivityVC *vc4=[[HJActivityVC alloc]init];
    vc4.title=@"人文";
    [self addChildViewController:vc4];
    
    HJMapVC *vc5=[[HJMapVC alloc]init];
    vc5.title=@"地图";
    [self addChildViewController:vc5];
    
    HJActivityVC *vc6=[[HJActivityVC alloc]init];
    vc6.title=@"活动";
    [self addChildViewController:vc6];
}
-(void)setUpheadersView
{
    UIView *titleView=[[UIView alloc]initWithFrame:CGRectMake(0, 64, Width, 44)];
    titleView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:titleView];
    self.titleView=titleView;
    
    UIView *indicatorView=[[UIView alloc]initWithFrame:CGRectMake(0, 42, Width/self.childViewControllers.count, 2)];
    indicatorView.backgroundColor=RGB(230, 198, 168, 1);
    [titleView addSubview:indicatorView];
    self.indicatorView=indicatorView;
    
    CGFloat width=Width/self.childViewControllers.count;
    for (int i=0; i<self.childViewControllers.count; i++) {
        UIButton *btn=[UIButton  buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(i*width, 0, width, 44);
        btn.tag=i;
        UIViewController *vc=self.childViewControllers[i];
        [btn setTitle:vc.title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [btn setTitleColor:RGB(230, 198, 168, 1) forState:UIControlStateDisabled];
        btn.titleLabel.font=[UIFont boldSystemFontOfSize:15];
        [btn addTarget:self action:@selector(touchBtn:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:btn];
        
        if (i==0) {
            btn.enabled=NO;
            self.selectedBtn=btn;
        }
    }
    
}
-(void)touchBtn:(UIButton *)btn
{
    self.selectedBtn.enabled=YES;
    btn.enabled=NO;
    self.selectedBtn=btn;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.centerX=btn.centerX;
    }];
    //控制器滑动
    [self.scrollView setContentOffset:CGPointMake(btn.tag*self.scrollView.width, 0) animated:YES];
}
-(void)setUpNavi
{
    UIImageView *titleView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 60, 20)];
    titleView.image=[UIImage imageNamed:@"YS_food+"];
    self.navigationItem.titleView=titleView;
    self.navigationItem.rightBarButtonItem=[UIBarButtonItem barBtnItemWithImg:@"icon_home_search" highImg:@"searchbar_textfield_search_icon" target:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
}
-(void)search
{
    
}
//非手动滑
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSInteger index=scrollView.contentOffset.x/scrollView.width;
    UIViewController *vc=self.childViewControllers[index];
    vc.view.frame=CGRectMake(scrollView.contentOffset.x, 0, scrollView.width, scrollView.height);
    [scrollView addSubview:vc.view];
    
}
//手动滑
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    NSInteger index=scrollView.contentOffset.x/scrollView.width;
    for (UIButton *btn in self.titleView.subviews) {
        if (index==btn.tag) {
            [self touchBtn:btn];
        }
    }
    

}
@end
