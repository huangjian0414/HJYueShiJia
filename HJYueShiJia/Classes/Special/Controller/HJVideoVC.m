//
//  HJVideoVC.m
//  HJYueShiJia
//
//  Created by huangjian on 17/5/4.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "HJVideoVC.h"
#import "HJVideoModel.h"
#import "HJVideoCell.h"
#import "WMPlayer.h"
#import "Masonry.h"
#import "UIView+HJAnimation.h"
@interface HJVideoVC ()<UITableViewDelegate,UITableViewDataSource,HJVideoCellDelegate,WMPlayerDelegate>
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *videoModelArr;
@property (strong, nonatomic)NSMutableDictionary *cellHeights;
@property (nonatomic,weak)WMPlayer *videoPlayer;

@property (nonatomic,strong)NSIndexPath *indexP;

@property (nonatomic, assign) UIInterfaceOrientation currentOrientation;
@property (nonatomic,weak)HJVideoCell *videoCell;
@end

@implementation HJVideoVC
-(NSMutableArray *)videoModelArr
{
    if (!_videoModelArr) {
        _videoModelArr=[NSMutableArray array];
    }
    return _videoModelArr;
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
    [self getData];
    [self setUpTableView];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //获取设备旋转方向的通知,即使关闭了自动旋转,一样可以监测到设备的旋转方向
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    //旋转屏幕通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(changeOrientation:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil
     ];
}
-(void)changeOrientation:(NSNotification *)notification
{
    if (self.videoPlayer==nil||self.videoPlayer.superview==nil){
        return;
    }
    
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)orientation;
    switch (interfaceOrientation) {
        case UIInterfaceOrientationPortraitUpsideDown:{
            NSLog(@"第3个旋转方向---电池栏在下");
        }
            break;
        case UIInterfaceOrientationPortrait:{
            NSLog(@"第0个旋转方向---电池栏在上");
            if (self.videoPlayer.isFullscreen) {
                [self.videoPlayer removeFromSuperview];
                [self.videoCell.contentView addSubview:self.videoPlayer];
                [self orientationChange:UIInterfaceOrientationPortrait];
                self.videoPlayer.isFullscreen = NO;
                self.videoPlayer.closeBtnStyle = CloseBtnStyleClose;
                
            }
        }
            break;
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:{
            NSLog(@"第1个旋转方向---电池栏在右");
            if (self.videoPlayer.isFullscreen==NO) {
                [self.videoPlayer removeFromSuperview];
                [[UIApplication sharedApplication].keyWindow addSubview:self.videoPlayer];
                [self orientationChange:interfaceOrientation];
                self.videoPlayer.isFullscreen = YES;
                self.videoPlayer.closeBtnStyle = CloseBtnStylePop;
            }
            
        }
            break;
        default:
            break;
    }
    [self setNeedsStatusBarAppearanceUpdate];

}
//监测到屏幕旋转去调用的方法
-(void)orientationChange:(UIInterfaceOrientation)orientation{
    if (orientation ==UIInterfaceOrientationPortrait) {//
        [self.videoPlayer mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.videoCell.contentView).with.offset(0);
            make.left.equalTo(self.videoCell.contentView).with.offset(0);
            make.right.equalTo(self.videoCell.contentView).with.offset(0);
            make.height.equalTo(@(self.videoCell.imgView.size.height));
        }];
    }else{
        [self.videoPlayer mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@([UIScreen mainScreen].bounds.size.width));
            make.height.equalTo(@([UIScreen mainScreen].bounds.size.height));
            make.center.equalTo(self.videoPlayer.superview);
        }];
    }
    
    self.videoPlayer.transform = CGAffineTransformIdentity;
    self.videoPlayer.transform = [self getOrientation:orientation];
    [UIView setAnimationDuration:1.0];
    //开始旋转
    [UIView commitAnimations];
}
//获取当前的旋转状态
-(CGAffineTransform)getOrientation:(UIInterfaceOrientation)orientation{
    //根据要进行旋转的方向来计算旋转的角度
    if (orientation ==UIInterfaceOrientationPortrait) {
        return CGAffineTransformIdentity;
    }else if (orientation ==UIInterfaceOrientationLandscapeLeft){
        return CGAffineTransformMakeRotation(-M_PI_2);
    }else if(orientation ==UIInterfaceOrientationLandscapeRight){
        return CGAffineTransformMakeRotation(M_PI_2);
    }
    return CGAffineTransformIdentity;
}

-(void)toOrientation:(UIInterfaceOrientation)orientation{
//    //获取到当前状态条的方向
    UIInterfaceOrientation currentOrientation = [UIApplication sharedApplication].statusBarOrientation;
    //判断如果当前方向和要旋转的方向一致,那么不做任何操作
    if (currentOrientation == orientation) {
        return;
    }
    
    //根据要旋转的方向,使用Masonry重新修改限制
    if (orientation ==UIInterfaceOrientationPortrait) {//
        [self.videoPlayer mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.videoCell.contentView).with.offset(0);
            make.left.equalTo(self.videoCell.contentView).with.offset(0);
            make.right.equalTo(self.videoCell.contentView).with.offset(0);
            make.height.equalTo(@(self.videoCell.imgView.frame.size.height));
        }];
    }else{
        //这个地方加判断是为了从全屏的一侧,直接到全屏的另一侧不用修改限制,否则会出错;
        if (currentOrientation ==UIInterfaceOrientationPortrait) {
            [self.videoPlayer mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@([UIScreen mainScreen].bounds.size.height));
                make.height.equalTo(@([UIScreen mainScreen].bounds.size.width));
                make.center.equalTo(self.videoPlayer.superview);
            }];
        }
    }
    //iOS6.0之后,设置状态条的方法能使用的前提是shouldAutorotate为NO,也就是说这个视图控制器内,旋转要关掉;
    [[UIApplication sharedApplication] setStatusBarOrientation:orientation animated:NO];
    //获取旋转状态条需要的时间:
    [UIView beginAnimations:nil context:nil];
    //更改了状态条的方向,但是设备方向UIInterfaceOrientation还是正方向的,这就要设置给你播放视频的视图的方向设置旋转
    //给你的播放视频的view视图设置旋转
    self.videoPlayer.transform = CGAffineTransformIdentity;
    self.videoPlayer.transform = [WMPlayer getCurrentDeviceOrientation];
    [UIView setAnimationDuration:1.0];
    //开始旋转
    [UIView commitAnimations];
    
}

-(void)setUpTableView
{
    UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64+44, Width, Height-64-44-44) style:UITableViewStyleGrouped];
    tableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0.001)];
    tableView.delegate=self;
    tableView.dataSource=self;
    [self.view addSubview:tableView];
    self.tableView=tableView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.videoModelArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID=@"videoCell";
    HJVideoCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[HJVideoCell hj_viewFromXib];
    }
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    cell.videoModel=self.videoModelArr[indexPath.row];
    cell.index=indexPath;
    [self.cellHeights setObject:@([cell getCellHeight]) forKey:@(indexPath.row)];
    cell.delegate=self;
    
//    if (self.videoPlayer&&self.videoPlayer.superview) {
//        
//        NSArray *indexpaths = [tableView indexPathsForVisibleRows];
//        if (![indexpaths containsObject:self.indexP]) {//复用
//            
//            if ([[UIApplication sharedApplication].keyWindow.subviews containsObject:self.videoPlayer]) {
//                self.videoPlayer.hidden = NO;
//                
//            }else{
//                self.videoPlayer.hidden = YES;
//            }
//        }else{
//            if ([cell.contentView.subviews containsObject:self.videoPlayer]) {
//                [cell.contentView addSubview:self.videoPlayer];
//                
//                [self.videoPlayer play];
//                self.videoPlayer.hidden = NO;
//            }
//            
//        }
//    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[self.cellHeights objectForKey:@(indexPath.row)]doubleValue];
}
-(void)touchPlay:(HJVideoCell *)videoCell
{
    if (self.videoPlayer) {
        [self.videoPlayer resetWMPlayer];
        [self.videoPlayer removeFromSuperview];
    }
    WMPlayer *player=[[WMPlayer alloc]initWithFrame:videoCell.backView.bounds];
    HJVideoModel *model=videoCell.videoModel;
    player.delegate=self;
    player.closeBtnStyle=CloseBtnStyleClose;
    player.URLString=model.article_video;
    player.titleLabel.text=model.article_title;
    [videoCell.contentView addSubview:player];
    
    self.videoPlayer=player;
    [player play];
    [self.videoPlayer play];
    self.indexP=videoCell.index;
    self.videoCell=videoCell;
    
}

-(void)wmplayer:(WMPlayer *)wmplayer clickedCloseButton:(UIButton *)closeBtn
{
    if (self.videoPlayer.isFullscreen) {
        [self.videoCell.contentView addSubview:self.videoPlayer];
        [self toOrientation:UIInterfaceOrientationPortrait];
        self.videoPlayer.isFullscreen = NO;
        self.videoPlayer.closeBtnStyle = CloseBtnStyleClose;
        return;
    }
    [self.videoPlayer resetWMPlayer];
    [self.videoPlayer removeFromSuperview];
}
-(void)wmplayer:(WMPlayer *)wmplayer clickedFullScreenButton:(UIButton *)fullScreenBtn
{
    [wmplayer removeFromSuperview];
    if (self.videoPlayer.isFullscreen) {
        [self.videoCell.contentView addSubview:self.videoPlayer];
        [self toOrientation:UIInterfaceOrientationPortrait];
        self.videoPlayer.isFullscreen = NO;
        self.videoPlayer.closeBtnStyle = CloseBtnStyleClose;
    }else
    {
        [[UIApplication sharedApplication].keyWindow addSubview:self.videoPlayer];
        [self toOrientation:UIInterfaceOrientationLandscapeRight];
        self.videoPlayer.isFullscreen = YES;
        self.videoPlayer.closeBtnStyle = CloseBtnStylePop;
    }
}

-(void)wmplayerFailedPlay:(WMPlayer *)wmplayer WMPlayerStatus:(WMPlayerState)state
{
    [self.videoPlayer resetWMPlayer];
    [self.videoPlayer removeFromSuperview];
}
-(void)wmplayerFinishedPlay:(WMPlayer *)wmplayer
{
    [self.videoPlayer resetWMPlayer];
    [self.videoPlayer removeFromSuperview];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.videoPlayer) {
        CGRect rectInTableView = [self.tableView rectForRowAtIndexPath:self.indexP];
        CGRect rectInSuperview = [self.tableView convertRect:rectInTableView toView:[self.tableView superview]];
        NSLog(@"-------huang %lf",rectInSuperview.origin.y);
        if (rectInSuperview.origin.y<40||rectInSuperview.origin.y>515) {
            if (self.videoPlayer.state==WMPlayerStatePlaying) {
                [self.videoPlayer pause];
            }
            
        }
    }
    
}
-(void)getData
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"shipin" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    NSArray *listArray = json[@"datas"][@"article_list"];
    
    for (NSDictionary *dict in listArray) {
        HJVideoModel *model=[HJVideoModel mj_objectWithKeyValues:dict];
        [self.videoModelArr addObject:model];
    }

}
-(void)viewWillDisappear:(BOOL)animated
{
    if (self.videoPlayer) {
        [self.videoPlayer resetWMPlayer];
        [self.videoPlayer removeFromSuperview];
    }
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
