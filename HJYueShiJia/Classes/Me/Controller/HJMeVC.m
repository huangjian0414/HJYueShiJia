//
//  HJMeVC.m
//  HJYueShiJia
//
//  Created by huangjian on 17/4/24.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "HJMeVC.h"
#import "UIImage+HJOriginalImage.h"
#import "HJMeOrderCell.h"
#import "HJMeAccountCell.h"
@interface HJMeVC ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) UIImageView *topImageView;
@end

@implementation HJMeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpTableView];
    [self setUpTopView];
    [self setUpSettingBtn];
}
-(void)setUpTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.tableView = tableView;
    [self.view addSubview:tableView];

}
-(void)setUpTopView
{
    self.topImageView = [[UIImageView alloc] initWithFrame:(CGRectMake(0, -200, Width, 200))];
    self.topImageView.image = [UIImage imageNamed:@"wishbg.jpg"];
    
    self.topImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    self.topImageView.clipsToBounds = YES;
    [self.tableView addSubview:self.topImageView];
    UIImageView *iconImage = [[UIImageView alloc] init];
    iconImage.image=[UIImage circleImageNamed:@"shasha.jpg"];
    [self.topImageView addSubview:iconImage];
    
    UILabel *userLabel = [[UILabel alloc] init];
    userLabel.text = @"hashaki";
    userLabel.font = [UIFont systemFontOfSize:18.0];
    userLabel.textColor = [UIColor whiteColor];
    userLabel.textAlignment = NSTextAlignmentCenter;
    [self.topImageView addSubview:userLabel];
    
    iconImage.sd_layout.centerXEqualToView(self.topImageView).centerYEqualToView(self.topImageView).widthIs(60).heightIs(60);
    userLabel.sd_layout.topSpaceToView(iconImage,18).centerXEqualToView(iconImage).widthIs(100).heightIs(21);
    
    self.tableView.contentInset = UIEdgeInsetsMake(200, 0, 0, 0);
}
-
(void)setUpSettingBtn
{
    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [settingBtn setBackgroundImage:[UIImage imageNamed:@"mine_setting"] forState:UIControlStateNormal];
    [self.view addSubview:settingBtn];
    settingBtn.sd_layout.topSpaceToView(self.view,25).leftSpaceToView(self.view,15).widthIs(settingBtn.currentBackgroundImage.size.width).heightIs(settingBtn.currentBackgroundImage.size.height);
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID=@"meCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.row==0) {
        HJMeOrderCell *orderCell=[HJMeOrderCell cellInitWithTableView:tableView];
        return orderCell;
    }else if (indexPath.row==1)
    {
        HJMeAccountCell *accountCell=[HJMeAccountCell cellInitWithTableView:tableView];
        return accountCell;
        
        
    }else if (indexPath.row==2)
    {
        cell.textLabel.text = @"我的收藏";
        
    }else if (indexPath.row==3)
    {
        cell.textLabel.text = @"我的活动";
    }else if (indexPath.row==4)
    {
        cell.textLabel.text = @"邀请好友";
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
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 150;
    } else if (indexPath.row == 1) {
        return 150;
    } else  {
        return 44;
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY=scrollView.contentOffset.y;
    
    if (offsetY<-200) {
        CGRect frame=self.topImageView.frame;
        
        self.topImageView.frame=CGRectMake(0, offsetY, frame.size.width, -offsetY);
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}


@end
