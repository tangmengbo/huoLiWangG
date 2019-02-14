//
//  XiaoXiClassifyViewController.m
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/25.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "XiaoXiClassifyViewController.h"

@interface XiaoXiClassifyViewController ()

@end

@implementation XiaoXiClassifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLale.text = @"消息";
    self.titleLale.textColor = [UIColor whiteColor];
    [self setTabBarHidden];
    
    UIButton * gongGaoButton = [[UIButton alloc] initWithFrame:CGRectMake(0*BILI, self.navView.frame.origin.y+self.navView.frame.size.height+13*BILI, VIEW_WIDTH-0*BILI, (VIEW_WIDTH-0*BILI)*372/1200)];
    [gongGaoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [gongGaoButton addTarget:self action:@selector(gongGaoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [gongGaoButton setBackgroundImage:[UIImage imageNamed:@"gggb_icon"] forState:UIControlStateNormal];
    gongGaoButton.layer.cornerRadius = 8*BILI;
    [self.view addSubview:gongGaoButton];
    
    UILabel * gongGaoLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, 13*BILI, 200, 15*BILI)];
    gongGaoLable.font = [UIFont systemFontOfSize:15*BILI];
    gongGaoLable.textColor = [UIColor whiteColor];
    gongGaoLable.text = @"公告广播";
   // [gongGaoButton addSubview:gongGaoLable];
    
    UIImageView * gongGaoImageVeiew = [[UIImageView alloc] initWithFrame:CGRectMake(gongGaoButton.frame.size.width-20*BILI-30*BILI, gongGaoButton.frame.size.height-10*BILI-30*BILI, 30*BILI, 30*BILI)];
    gongGaoImageVeiew.image = [UIImage imageNamed:@"laba"];
   // [gongGaoButton addSubview:gongGaoImageVeiew];
    
    UIButton * tongZhiButton = [[UIButton alloc] initWithFrame:CGRectMake(0*BILI, gongGaoButton.frame.origin.y+gongGaoButton.frame.size.height, VIEW_WIDTH-0*BILI, (VIEW_WIDTH-0*BILI)*372/1200)];
    [tongZhiButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [tongZhiButton addTarget:self action:@selector(tongZhiButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [tongZhiButton setBackgroundImage:[UIImage imageNamed:@"tz_icon"] forState:UIControlStateNormal];    tongZhiButton.layer.cornerRadius = 15*BILI;
    [self.view addSubview:tongZhiButton];
    
    
    UILabel * tongZhiLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, 13*BILI, 200, 15*BILI)];
    tongZhiLable.font = [UIFont systemFontOfSize:15*BILI];
    tongZhiLable.textColor = [UIColor whiteColor];
    tongZhiLable.text = @"通知";
   // [tongZhiButton addSubview:tongZhiLable];
    
    UIImageView * tongZhiImageVeiew = [[UIImageView alloc] initWithFrame:CGRectMake(gongGaoButton.frame.size.width-20*BILI-30*BILI, gongGaoButton.frame.size.height-10*BILI-30*BILI*65/59, 30*BILI, 30*BILI*65/59)];
    tongZhiImageVeiew.image = [UIImage imageNamed:@"xiaoxi_lingDang"];
   // [tongZhiButton addSubview:tongZhiImageVeiew];

    
    UIButton * yuJingButton = [[UIButton alloc] initWithFrame:CGRectMake(0*BILI, tongZhiButton.frame.origin.y+tongZhiButton.frame.size.height+0*BILI, VIEW_WIDTH-0*BILI, (VIEW_WIDTH-0*BILI)*372/1200)];
    [yuJingButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [yuJingButton addTarget:self action:@selector(yuJingButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [yuJingButton setBackgroundImage:[UIImage imageNamed:@"yj_icon"] forState:UIControlStateNormal];
    yuJingButton.layer.cornerRadius = 15*BILI;
    [self.view addSubview:yuJingButton];
    
    UILabel * yuJingLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, 13*BILI, 200, 15*BILI)];
    yuJingLable.font = [UIFont systemFontOfSize:15*BILI];
    yuJingLable.textColor = [UIColor whiteColor];
    yuJingLable.text = @"预警消息";
   // [yuJingButton addSubview:yuJingLable];
    
    UIImageView * yuJingImageVeiew = [[UIImageView alloc] initWithFrame:CGRectMake(gongGaoButton.frame.size.width-20*BILI-30*BILI, gongGaoButton.frame.size.height-10*BILI-30*BILI, 30*BILI, 30*BILI)];
    yuJingImageVeiew.image = [UIImage imageNamed:@"jingling"];
   // [yuJingButton addSubview:yuJingImageVeiew];

    
    UIButton * myMessageButton = [[UIButton alloc] initWithFrame:CGRectMake(0*BILI, yuJingButton.frame.origin.y+yuJingButton.frame.size.height+0*BILI, VIEW_WIDTH-0*BILI, (VIEW_WIDTH-0*BILI)*372/1200)];
    [myMessageButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [myMessageButton addTarget:self action:@selector(myMessageButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [myMessageButton setBackgroundImage:[UIImage imageNamed:@"wd_icon"] forState:UIControlStateNormal];
    myMessageButton.layer.cornerRadius = 15*BILI;
    [self.view addSubview:myMessageButton];
    
    UILabel * woXiaoXiLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, 13*BILI, 200, 15*BILI)];
    woXiaoXiLable.font = [UIFont systemFontOfSize:15*BILI];
    woXiaoXiLable.textColor = [UIColor whiteColor];
    woXiaoXiLable.text = @"我的消息";
   // [myMessageButton addSubview:woXiaoXiLable];
    
    UIImageView * woXiaoXiImageVeiew = [[UIImageView alloc] initWithFrame:CGRectMake(gongGaoButton.frame.size.width-20*BILI-30*BILI, gongGaoButton.frame.size.height-10*BILI-30*BILI, 30*BILI, 30*BILI)];
    woXiaoXiImageVeiew.image = [UIImage imageNamed:@"xinxi"];
   // [myMessageButton addSubview:woXiaoXiImageVeiew];
}
-(void)gongGaoButtonClick
{
    XiaoXiListViewController * vc = [[XiaoXiListViewController alloc] init];
    vc.titleStr = @"广播通知";
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)tongZhiButtonClick
{
    XiaoXiListViewController * vc = [[XiaoXiListViewController alloc] init];
    vc.titleStr = @"通知";
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)yuJingButtonClick
{
    XiaoXiListViewController * vc = [[XiaoXiListViewController alloc] init];
    vc.titleStr = @"预警消息";
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)myMessageButtonClick
{
    XiaoXiListViewController * vc = [[XiaoXiListViewController alloc] init];
    vc.titleStr = @"我的消息";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
