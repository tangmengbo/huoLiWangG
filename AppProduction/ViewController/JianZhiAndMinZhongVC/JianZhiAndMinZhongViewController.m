//
//  JianZhiAndMinZhongViewController.m
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/27.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "JianZhiAndMinZhongViewController.h"

@interface JianZhiAndMinZhongViewController ()

@end

@implementation JianZhiAndMinZhongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLale.text = @"平安玉门";
    self.titleLale.textColor = [UIColor whiteColor];
    
    
    
    self.backImageView.hidden = YES;
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT-(self.navView.frame.origin.y+self.navView.frame.size.height))];
    [self.view addSubview:self.mainScrollView];
    
    
    
    UIButton * xuanChuanButton = [[UIButton alloc] initWithFrame:CGRectMake(-VIEW_WIDTH, 13*BILI, VIEW_WIDTH-0*BILI, VIEW_WIDTH*378/1200)];
    [xuanChuanButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [xuanChuanButton addTarget:self action:@selector(xuanChuanButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [xuanChuanButton setBackgroundImage:[UIImage imageNamed:@"sjwl"] forState:UIControlStateNormal];
    xuanChuanButton.layer.cornerRadius = 15*BILI;
    [self.mainScrollView addSubview:xuanChuanButton];
    
    UILabel * wangGeLable = [[UILabel alloc] initWithFrame:CGRectMake(23*BILI, 23*BILI, 200, 20*BILI)];
    wangGeLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:20*BILI];
    wangGeLable.textColor = [UIColor whiteColor];
    wangGeLable.text = @"宣传";
    [xuanChuanButton addSubview:wangGeLable];
    
    UIImageView * wangGeImageVeiew = [[UIImageView alloc] initWithFrame:CGRectMake(xuanChuanButton.frame.size.width-20*BILI-40*BILI, xuanChuanButton.frame.size.height-20*BILI-40*BILI, 40*BILI, 40*BILI)];
    wangGeImageVeiew.image = [UIImage imageNamed:@"shuJv"];
    [xuanChuanButton addSubview:wangGeImageVeiew];
    
    
    UIButton * baoLiaoButton = [[UIButton alloc] initWithFrame:CGRectMake(-VIEW_WIDTH, xuanChuanButton.frame.origin.y+xuanChuanButton.frame.size.height, VIEW_WIDTH-0*BILI, VIEW_WIDTH*378/1200)];
    [baoLiaoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [baoLiaoButton addTarget:self action:@selector(baoLiaoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [baoLiaoButton setBackgroundImage:[UIImage imageNamed:@"baoLiaoButtonClick"] forState:UIControlStateNormal];
    [baoLiaoButton setBackgroundImage:[UIImage imageNamed:@"blxx"] forState:UIControlStateNormal];
    baoLiaoButton.layer.cornerRadius = 15*BILI;
    [self.mainScrollView addSubview:baoLiaoButton];
    
    UILabel * shiJianLable = [[UILabel alloc] initWithFrame:CGRectMake(23*BILI, 23*BILI, 200, 20*BILI)];
    shiJianLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:20*BILI];
    shiJianLable.textColor = [UIColor whiteColor];
    shiJianLable.text = @"爆料";
    [baoLiaoButton addSubview:shiJianLable];
    
    UIImageView * shiJianImageVeiew = [[UIImageView alloc] initWithFrame:CGRectMake(baoLiaoButton.frame.size.width-20*BILI-40*BILI, baoLiaoButton.frame.size.height-20*BILI-40*BILI*92/81, 40*BILI, 40*BILI*92/81)];
    shiJianImageVeiew.image = [UIImage imageNamed:@"baoLiao"];
    [baoLiaoButton addSubview:shiJianImageVeiew];
    
    
    
    UIButton * jiangLiButton = [[UIButton alloc] initWithFrame:CGRectMake(-VIEW_WIDTH, baoLiaoButton.frame.origin.y+baoLiaoButton.frame.size.height+0*BILI, VIEW_WIDTH-0*BILI, VIEW_WIDTH*378/1200)];
    [jiangLiButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [jiangLiButton addTarget:self action:@selector(jiangLiButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [jiangLiButton setBackgroundImage:[UIImage imageNamed:@"tjfx"] forState:UIControlStateNormal];
    jiangLiButton.layer.cornerRadius = 15*BILI;
    [self.mainScrollView addSubview:jiangLiButton];
    
    UILabel * tongJiLable = [[UILabel alloc] initWithFrame:CGRectMake(23*BILI, 23*BILI, 200, 20*BILI)];
    tongJiLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:20*BILI];;
    tongJiLable.textColor = [UIColor whiteColor];
    tongJiLable.text = @"奖励";
    [jiangLiButton addSubview:tongJiLable];
    
    UIImageView * tongJiImageVeiew = [[UIImageView alloc] initWithFrame:CGRectMake(jiangLiButton.frame.size.width-20*BILI-40*BILI, jiangLiButton.frame.size.height-20*BILI- 40*BILI*80/75, 40*BILI, 40*BILI*80/75)];
    tongJiImageVeiew.image = [UIImage imageNamed:@"kaoHePingBi"];
    [jiangLiButton addSubview:tongJiImageVeiew];
    
    
    
    UIButton * ownerButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH, jiangLiButton.frame.origin.y+jiangLiButton.frame.size.height+0*BILI, VIEW_WIDTH-0*BILI, VIEW_WIDTH*378/1200)];
    [ownerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [ownerButton addTarget:self action:@selector(ownerButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [ownerButton setBackgroundImage:[UIImage imageNamed:@"me"] forState:UIControlStateNormal];
    ownerButton.layer.cornerRadius = 15*BILI;
    [self.mainScrollView addSubview:ownerButton];
    
    UILabel * ownerLable = [[UILabel alloc] initWithFrame:CGRectMake(23*BILI, 23*BILI, 200, 20*BILI)];
    ownerLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:20*BILI];;
    ownerLable.textColor = [UIColor whiteColor];
    ownerLable.text = @"我的";
    [ownerButton addSubview:ownerLable];
    
    UIImageView * ownerImageVeiew = [[UIImageView alloc] initWithFrame:CGRectMake(jiangLiButton.frame.size.width-20*BILI-40*BILI, jiangLiButton.frame.size.height-20*BILI- 40*BILI, 40*BILI, 40*BILI)];
    ownerImageVeiew.image = [UIImage imageNamed:@"white_ren"];
    [ownerButton addSubview:ownerImageVeiew];
    
    
    [self.mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH, ownerButton.frame.origin.y+ownerButton.frame.size.height+13*BILI)];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    xuanChuanButton.frame = CGRectMake(0*BILI, xuanChuanButton.frame.origin.y, xuanChuanButton.frame.size.width, xuanChuanButton.frame.size.height);
    baoLiaoButton.frame = CGRectMake(0*BILI, baoLiaoButton.frame.origin.y, baoLiaoButton.frame.size.width, baoLiaoButton.frame.size.height);
    jiangLiButton.frame = CGRectMake(0*BILI, jiangLiButton.frame.origin.y, jiangLiButton.frame.size.width, jiangLiButton.frame.size.height);
    ownerButton.frame = CGRectMake(0*BILI, ownerButton.frame.origin.y, ownerButton.frame.size.width, ownerButton.frame.size.height);
    [UIView commitAnimations];
}

-(void)xuanChuanButtonClick
{
    XuanChuanViewController * vc = [[XuanChuanViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)baoLiaoButtonClick
{
    BaoLiaoHomeViewController * vc = [[BaoLiaoHomeViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)jiangLiButtonClick
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * userInfo = [defaults objectForKey:USERINFO];
    NSNumber * typeNumber = [userInfo objectForKey:@"logintype"];
    
    
    
    HomeWebViewController * vc = [[HomeWebViewController alloc] init];
    vc.url =[NSString stringWithFormat:@"%@%@?token=%@&userid=%@&logintype=%d", HTTP_REQUESTURL, @"pubInfo!rewardInfo.do",[userInfo objectForKey:@"token"],[userInfo objectForKey:@"userid"],typeNumber.intValue];
    vc.titleStr = @"奖励";
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)ownerButtonClick
{
    OwnerHomeViewController * vc = [[OwnerHomeViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
