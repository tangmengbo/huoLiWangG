//
//  ZongZhiViewController.m
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/26.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ZongZhiViewController.h"
#import "ZongZhiTongJiFenXiViewController.h"

@interface ZongZhiViewController ()

@end

@implementation ZongZhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLale.text = @"工作台";
    self.titleLale.textColor = [UIColor whiteColor];
    
    self.backImageView.hidden = YES;
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT-(self.navView.frame.origin.y+self.navView.frame.size.height))];
    [self.view addSubview:self.mainScrollView];

    
    UIButton * wangGeButton = [[UIButton alloc] initWithFrame:CGRectMake(-VIEW_WIDTH, 13*BILI, VIEW_WIDTH-0*BILI, VIEW_WIDTH*378/1200)];
    [wangGeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [wangGeButton addTarget:self action:@selector(wangGeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [wangGeButton setBackgroundImage:[UIImage imageNamed:@"sjwl"] forState:UIControlStateNormal];
    wangGeButton.layer.cornerRadius = 15*BILI;
    [self.mainScrollView addSubview:wangGeButton];
    
    UILabel * wangGeLable = [[UILabel alloc] initWithFrame:CGRectMake(23*BILI, 23*BILI, 200, 15*BILI)];
    wangGeLable.font = [UIFont systemFontOfSize:18*BILI];
    wangGeLable.textColor = [UIColor whiteColor];
    wangGeLable.text = @"网格信息";
    [wangGeButton addSubview:wangGeLable];
    
    UIImageView * wangGeImageVeiew = [[UIImageView alloc] initWithFrame:CGRectMake(wangGeButton.frame.size.width-20*BILI-40*BILI, wangGeButton.frame.size.height-20*BILI-40*BILI, 40*BILI, 40*BILI)];
    wangGeImageVeiew.image = [UIImage imageNamed:@"shuJv"];
    [wangGeButton addSubview:wangGeImageVeiew];
    
    UIButton * shiJianButton = [[UIButton alloc] initWithFrame:CGRectMake(-VIEW_WIDTH, wangGeButton.frame.origin.y+wangGeButton.frame.size.height+0*BILI, VIEW_WIDTH-0*BILI, VIEW_WIDTH*378/1200)];
    [shiJianButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [shiJianButton addTarget:self action:@selector(shiJianGenZongButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [shiJianButton setBackgroundImage:[UIImage imageNamed:@"gjhf"] forState:UIControlStateNormal];
    shiJianButton.layer.cornerRadius = 15*BILI;
    [self.mainScrollView addSubview:shiJianButton];
    
    UILabel * shiJianLable = [[UILabel alloc] initWithFrame:CGRectMake(23*BILI, 23*BILI, 200, 15*BILI)];
    shiJianLable.font = [UIFont systemFontOfSize:18*BILI];
    shiJianLable.textColor = [UIColor whiteColor];
    shiJianLable.text = @"事件跟踪";
    [shiJianButton addSubview:shiJianLable];
    
    UIImageView * shiJianImageVeiew = [[UIImageView alloc] initWithFrame:CGRectMake(wangGeButton.frame.size.width-20*BILI-40*BILI, wangGeButton.frame.size.height-20*BILI-40*BILI, 40*BILI, 40*BILI)];
    shiJianImageVeiew.image = [UIImage imageNamed:@"huiFang"];
    [shiJianButton addSubview:shiJianImageVeiew];
    
    UIButton * tongJiFenXiButton = [[UIButton alloc] initWithFrame:CGRectMake(-VIEW_WIDTH, shiJianButton.frame.origin.y+shiJianButton.frame.size.height+0*BILI, VIEW_WIDTH-0*BILI, VIEW_WIDTH*378/1200)];
    [tongJiFenXiButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [tongJiFenXiButton addTarget:self action:@selector(tongJiFenXiButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [tongJiFenXiButton setBackgroundImage:[UIImage imageNamed:@"tjfx"] forState:UIControlStateNormal];
    tongJiFenXiButton.layer.cornerRadius = 15*BILI;
    [self.mainScrollView addSubview:tongJiFenXiButton];
    
    UILabel * tongJiLable = [[UILabel alloc] initWithFrame:CGRectMake(23*BILI, 23*BILI, 200, 15*BILI)];
    tongJiLable.font = [UIFont systemFontOfSize:18*BILI];
    tongJiLable.textColor = [UIColor whiteColor];
    tongJiLable.text = @"统计分析";
    [tongJiFenXiButton addSubview:tongJiLable];
    
    UIImageView * tongJiImageVeiew = [[UIImageView alloc] initWithFrame:CGRectMake(wangGeButton.frame.size.width-20*BILI-40*BILI, wangGeButton.frame.size.height-20*BILI- 40*BILI, 40*BILI, 40*BILI)];
    tongJiImageVeiew.image = [UIImage imageNamed:@"tongJi"];
    [tongJiFenXiButton addSubview:tongJiImageVeiew];
    
    UIButton * baoLiaoButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH, tongJiFenXiButton.frame.origin.y+tongJiFenXiButton.frame.size.height+0*BILI, VIEW_WIDTH-0*BILI, VIEW_WIDTH*378/1200)];
    [baoLiaoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [baoLiaoButton addTarget:self action:@selector(baoLiaoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [baoLiaoButton setBackgroundImage:[UIImage imageNamed:@"blxx"] forState:UIControlStateNormal];
    baoLiaoButton.layer.cornerRadius = 15*BILI;
    [self.mainScrollView addSubview:baoLiaoButton];
    
    UILabel * baoLiaoLable = [[UILabel alloc] initWithFrame:CGRectMake(23*BILI, 23*BILI, 200, 15*BILI)];
    baoLiaoLable.font = [UIFont systemFontOfSize:18*BILI];
    baoLiaoLable.textColor = [UIColor whiteColor];
    baoLiaoLable.text = @"爆料信息";
    [baoLiaoButton addSubview:baoLiaoLable];
    
    UIImageView * baoLiaoImageVeiew = [[UIImageView alloc] initWithFrame:CGRectMake(wangGeButton.frame.size.width-20*BILI-40*BILI, wangGeButton.frame.size.height-20*BILI- 40*BILI*92/81, 40*BILI, 40*BILI*92/81)];
    baoLiaoImageVeiew.image = [UIImage imageNamed:@"baoLiao"];
    [baoLiaoButton addSubview:baoLiaoImageVeiew];
    
    UIButton * kaoHePingBiButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH, baoLiaoButton.frame.origin.y+baoLiaoButton.frame.size.height+0*BILI, VIEW_WIDTH-0*BILI, VIEW_WIDTH*378/1200I)];
    [kaoHePingBiButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [kaoHePingBiButton addTarget:self action:@selector(kaoHePingBiButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [kaoHePingBiButton setBackgroundImage:[UIImage imageNamed:@"khpb"] forState:UIControlStateNormal];
    kaoHePingBiButton.layer.cornerRadius = 15*BILI;
    [self.mainScrollView addSubview:kaoHePingBiButton];
    
    UILabel * kaoHeLable = [[UILabel alloc] initWithFrame:CGRectMake(23*BILI, 23*BILI, 200, 15*BILI)];
    kaoHeLable.font = [UIFont systemFontOfSize:18*BILI];
    kaoHeLable.textColor = [UIColor whiteColor];
    kaoHeLable.text = @"考核评比";
    [kaoHePingBiButton addSubview:kaoHeLable];
    
    UIImageView * kaoHeImageVeiew = [[UIImageView alloc] initWithFrame:CGRectMake(wangGeButton.frame.size.width-20*BILI-40*BILI, wangGeButton.frame.size.height-20*BILI- 40*BILI*80/75, 40*BILI, 40*BILI*80/75)];
    kaoHeImageVeiew.image = [UIImage imageNamed:@"kaoHePingBi"];
    [kaoHePingBiButton addSubview:kaoHeImageVeiew];
    
    
    UIButton * ownerButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH, kaoHePingBiButton.frame.origin.y+kaoHePingBiButton.frame.size.height+0*BILI, VIEW_WIDTH-0*BILI, VIEW_WIDTH*378/1200)];
    [ownerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [ownerButton addTarget:self action:@selector(ownerButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [ownerButton setBackgroundImage:[UIImage imageNamed:@"me"] forState:UIControlStateNormal];
    ownerButton.layer.cornerRadius = 15*BILI;
    [self.mainScrollView addSubview:ownerButton];
    
    UILabel * ownerLable = [[UILabel alloc] initWithFrame:CGRectMake(23*BILI, 23*BILI, 200, 15*BILI)];
    ownerLable.font = [UIFont systemFontOfSize:18*BILI];
    ownerLable.textColor = [UIColor whiteColor];
    ownerLable.text = @"我的";
    [ownerButton addSubview:ownerLable];
    
    UIImageView * ownerImageVeiew = [[UIImageView alloc] initWithFrame:CGRectMake(wangGeButton.frame.size.width-20*BILI-40*BILI, wangGeButton.frame.size.height-20*BILI- 40*BILI, 40*BILI, 40*BILI)];
    ownerImageVeiew.image = [UIImage imageNamed:@"white_ren"];
    [ownerButton addSubview:ownerImageVeiew];
    
    [self.mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH, ownerButton.frame.origin.y+ownerButton.frame.size.height+13*BILI)];

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    wangGeButton.frame = CGRectMake(0*BILI, wangGeButton.frame.origin.y, wangGeButton.frame.size.width, wangGeButton.frame.size.height);
    shiJianButton.frame = CGRectMake(0*BILI, shiJianButton.frame.origin.y, shiJianButton.frame.size.width, shiJianButton.frame.size.height);
    tongJiFenXiButton.frame = CGRectMake(0*BILI, tongJiFenXiButton.frame.origin.y, tongJiFenXiButton.frame.size.width, tongJiFenXiButton.frame.size.height);
    baoLiaoButton.frame = CGRectMake(0*BILI, baoLiaoButton.frame.origin.y, baoLiaoButton.frame.size.width, baoLiaoButton.frame.size.height);
    kaoHePingBiButton.frame = CGRectMake(0*BILI, kaoHePingBiButton.frame.origin.y, kaoHePingBiButton.frame.size.width, kaoHePingBiButton.frame.size.height);
    ownerButton.frame = CGRectMake(0*BILI, ownerButton.frame.origin.y, ownerButton.frame.size.width, ownerButton.frame.size.height);
    [UIView commitAnimations];
}
-(void)wangGeButtonClick
{
    WangGeXinXiViewController * vc = [[WangGeXinXiViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)shiJianGenZongButtonClick
{
    ShiJianGenZongListViewController * vc = [[ShiJianGenZongListViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)tongJiFenXiButtonClick
{
    ZongZhiTongJiFenXiViewController * vc = [[ZongZhiTongJiFenXiViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)baoLiaoButtonClick
{
    BaoLiaoHomeViewController * vc = [[BaoLiaoHomeViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)kaoHePingBiButtonClick
{
    KaoHePingBiListViewController * vc = [[KaoHePingBiListViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)ownerButtonClick
{
    OwnerHomeViewController * vc = [[OwnerHomeViewController alloc] init];
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
