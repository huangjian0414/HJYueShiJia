//
//  HJNewFeatureVC.m
//  HJYueShiJia
//
//  Created by huangjian on 17/4/24.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "HJNewFeatureVC.h"
#import "HJTabbarVC.h"

#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height
@interface HJNewFeatureVC ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scroll;
@property (nonatomic, strong) UIPageControl *pageControl;
@end

@implementation HJNewFeatureVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}
-(void)setUI
{
    self.scroll=[[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.scroll.contentSize=CGSizeMake(Width*5, Height);
    self.scroll.bounces=NO;
    self.scroll.showsHorizontalScrollIndicator=NO;
    self.scroll.pagingEnabled=YES;
    self.scroll.delegate=self;
    [self.view addSubview:self.scroll];
    
    for (int i=0; i<5; i++) {
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(Width*i, 0, Width, Height)];
        imageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"bg_guide_6_%d",i+1]];
        [self.scroll addSubview:imageView];
        if (i==4) {
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            btn.backgroundColor=[UIColor clearColor];
            btn.frame=CGRectMake(Width*i + 100, Height * 0.75, Width-200, Height * 0.15);
            [btn addTarget:self action:@selector(startApp) forControlEvents:UIControlEventTouchUpInside];
            [self.scroll addSubview:btn];
        }
    }
    
    self.pageControl=[[UIPageControl alloc]init];
    self.pageControl.frame=CGRectMake(Width * 0.45, Height * 0.9, 100, 44);
    self.pageControl.pageIndicatorTintColor=[UIColor lightGrayColor];
    self.pageControl.numberOfPages=5;
    self.pageControl.currentPageIndicatorTintColor=[UIColor redColor];
    [self.view addSubview:self.pageControl];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger page=scrollView.contentOffset.x/Width;
    if (page==4) {
        self.pageControl.hidden=YES;
    }else
    {
        self.pageControl.hidden=NO;
    }
    self.pageControl.currentPage=page+0.5;
}
-(void)startApp
{
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    HJTabbarVC *vc=[[HJTabbarVC alloc]init];
    window.rootViewController=vc;
}

@end
