//
//  HJGoodsDetilVC.m
//  HJYueShiJia
//
//  Created by huangjian on 17/5/1.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "HJGoodsDetilVC.h"
#import <WebKit/WebKit.h>

@interface HJGoodsDetilVC ()
@property (nonatomic,strong)WKWebView *wkwebView;
@property (nonatomic,strong)UIProgressView *progressView;
@end

@implementation HJGoodsDetilVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"产品详情";
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:RGB(230, 198, 168, 1)};
    [self setUpWkWebView];
}
-(void)setUpWkWebView
{
    WKWebView *wkView=[[WKWebView alloc]initWithFrame:self.view.frame];
    [wkView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.goodsDetailURL]]];
    [self.view addSubview:wkView];
    self.wkwebView=wkView;
    UIProgressView *progressView=[[UIProgressView alloc]initWithFrame:CGRectMake(0, 64, Width, 2)];
    progressView.progressTintColor=RGB(230, 198, 168, 1);
    [self.view addSubview:progressView];
    self.progressView=progressView;
    
    [self.wkwebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if (object==self.wkwebView &&[keyPath isEqualToString:@"estimatedProgress"]) {
        if (self.wkwebView.estimatedProgress==1) {
            self.progressView.hidden=YES;
            [self.progressView setProgress:0 animated:NO];
        }else
        {
            self.progressView.hidden=NO;
            [self.progressView setProgress:self.wkwebView.estimatedProgress animated:YES];
        }
    }
}

-(void)dealloc
{
    [self.wkwebView removeObserver:self forKeyPath:@"estimatedProgress"];
}
@end
