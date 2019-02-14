//
//  XuanChuanViewController.m
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/11.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "XuanChuanViewController.h"

@interface XuanChuanViewController ()

@end

@implementation XuanChuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTabBarHidden];
    
    float buttonWidth = (VIEW_WIDTH-25*BILI-30*BILI-25*BILI)/2;
    float originY = (VIEW_HEIGHT-buttonWidth*3-20*BILI-(self.navView.frame.origin.y+self.navView.frame.size.height))/2;
    
    UIImageView * bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, VIEW_WIDTH, VIEW_HEIGHT)];
    bottomImageView.image = [UIImage imageNamed:@"logo_in_image"];
    [self.view addSubview:bottomImageView];
    
    self.navView = [[UIView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, VIEW_WIDTH, 44*BILIY)];
    self.navView.backgroundColor = UIColorFromRGB(0x5077AA);
    [self.view addSubview:self.navView];
    
    
    self.titleLale = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 44*BILIY)];
    self.titleLale.textColor = [UIColor blackColor];
    self.titleLale.textAlignment = NSTextAlignmentCenter;
    self.titleLale.font = [UIFont fontWithName:@"Helvetica-Bold" size:16*BILI];
    self.titleLale.text = @"宣传";
    self.titleLale.textColor = [UIColor whiteColor];
    [self.navView addSubview:self.titleLale];
    
    
    self.leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0,  0, 60, 44*BILIY)];
    [self.leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    self.leftButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.navView addSubview:self.leftButton];
    
    self.backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12*BILI, (44*BILIY-18*BILI)/2, 18*18/30*BILI, 18*BILI)];
    self.backImageView.image = [UIImage imageNamed:@"white_back"];
    [self.leftButton addSubview:self.backImageView];

    
    
    UIButton *  huiMinZhengCeButton = [[UIButton alloc] initWithFrame:CGRectMake(25*BILI, self.navView.frame.origin.y+self.navView.frame.size.height+originY, buttonWidth, buttonWidth)];
    huiMinZhengCeButton.layer.cornerRadius = 8*BILI;
    huiMinZhengCeButton.backgroundColor = UIColorFromRGB(0x3EA5E7);
     [huiMinZhengCeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    huiMinZhengCeButton.titleLabel.font = [UIFont systemFontOfSize:16*BILI];
    [huiMinZhengCeButton addTarget:self action:@selector(huiMinZhengCeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:huiMinZhengCeButton];
    
    UILabel * yiBanLableLable = [[UILabel alloc] initWithFrame:CGRectMake(0*BILI, huiMinZhengCeButton.frame.size.height/2+30*BILI, huiMinZhengCeButton.frame.size.width, 15*BILI)];
    yiBanLableLable.textColor = [UIColor whiteColor];
    yiBanLableLable.font = [UIFont systemFontOfSize:15*BILI];
    yiBanLableLable.textAlignment = NSTextAlignmentCenter;
    yiBanLableLable.text = @"惠民政策";
    [huiMinZhengCeButton addSubview:yiBanLableLable];
    
    UIImageView * yiBanImageView = [[UIImageView alloc] initWithFrame:CGRectMake((huiMinZhengCeButton.frame.size.width-40*BILI)/2, huiMinZhengCeButton.frame.size.height/2+10*BILI-40*BILI*92/81, 40*BILI, 40*BILI*92/81)];
    yiBanImageView.image = [UIImage imageNamed:@"baoLiao"];
    [huiMinZhengCeButton addSubview:yiBanImageView];
    
    
    
    UIButton *  pingAnJianSheButton = [[UIButton alloc] initWithFrame:CGRectMake(huiMinZhengCeButton.frame.origin.x+huiMinZhengCeButton.frame.size.width+30*BILI, huiMinZhengCeButton.frame.origin.y, buttonWidth, buttonWidth)];
    pingAnJianSheButton.layer.cornerRadius = 8*BILI;
    pingAnJianSheButton.backgroundColor = UIColorFromRGB(0xFF9735);
    [pingAnJianSheButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
     pingAnJianSheButton.titleLabel.font = [UIFont systemFontOfSize:16*BILI];
    [pingAnJianSheButton addTarget:self action:@selector(pingAnJianSheButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pingAnJianSheButton];
    
    
    UILabel * guanKongLable = [[UILabel alloc] initWithFrame:CGRectMake(0*BILI, huiMinZhengCeButton.frame.size.height/2+30*BILI, huiMinZhengCeButton.frame.size.width, 15*BILI)];
    guanKongLable.textColor = [UIColor whiteColor];
    guanKongLable.font = [UIFont systemFontOfSize:15*BILI];
    guanKongLable.textAlignment = NSTextAlignmentCenter;
    guanKongLable.text = @"平安建设";
    [pingAnJianSheButton addSubview:guanKongLable];
    
    UIImageView * guanKongImageView = [[UIImageView alloc] initWithFrame:CGRectMake((huiMinZhengCeButton.frame.size.width-40*BILI)/2, huiMinZhengCeButton.frame.size.height/2+10*BILI-40*BILI, 40*BILI, 40*BILI)];
    guanKongImageView.image = [UIImage imageNamed:@"loufang"];
    [pingAnJianSheButton addSubview:guanKongImageView];
   
    
    
    UIButton *  puFaXuanChuanButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-buttonWidth)/2, pingAnJianSheButton.frame.origin.y+pingAnJianSheButton.frame.size.height+10*BILIY, buttonWidth, buttonWidth)];
    puFaXuanChuanButton.layer.cornerRadius = 8*BILI;
    puFaXuanChuanButton.backgroundColor = UIColorFromRGB(0xA995DC);
    [puFaXuanChuanButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
     puFaXuanChuanButton.titleLabel.font = [UIFont systemFontOfSize:16*BILI];
    [puFaXuanChuanButton addTarget:self action:@selector(puFaXuanChuanButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:puFaXuanChuanButton];

    
    UILabel * ruHuLable = [[UILabel alloc] initWithFrame:CGRectMake(0*BILI, huiMinZhengCeButton.frame.size.height/2+30*BILI, huiMinZhengCeButton.frame.size.width, 15*BILI)];
    ruHuLable.textColor = [UIColor whiteColor];
    ruHuLable.font = [UIFont systemFontOfSize:15*BILI];
    ruHuLable.textAlignment = NSTextAlignmentCenter;
    ruHuLable.text = @"普法宣传";
    [puFaXuanChuanButton addSubview:ruHuLable];
    
    UIImageView * ruHuImageView = [[UIImageView alloc] initWithFrame:CGRectMake((huiMinZhengCeButton.frame.size.width-40*BILI)/2, huiMinZhengCeButton.frame.size.height/2+10*BILI-40*BILI, 40*BILI, 40*BILI)];
    ruHuImageView.image = [UIImage imageNamed:@"tianping"];
    [puFaXuanChuanButton addSubview:ruHuImageView];


    
    UIButton *  zhengCeJieDuButton = [[UIButton alloc] initWithFrame:CGRectMake(25*BILI, puFaXuanChuanButton.frame.origin.y+puFaXuanChuanButton.frame.size.height+10*BILIY, buttonWidth, buttonWidth)];
    zhengCeJieDuButton.layer.cornerRadius = 8*BILI;
    zhengCeJieDuButton.backgroundColor = UIColorFromRGB(0x00D2D6);
    [zhengCeJieDuButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
     zhengCeJieDuButton.titleLabel.font = [UIFont systemFontOfSize:16*BILI];
    [zhengCeJieDuButton addTarget:self action:@selector(zhengCeJieDuButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:zhengCeJieDuButton];
    
    UILabel * chuZhiLable = [[UILabel alloc] initWithFrame:CGRectMake(0*BILI, huiMinZhengCeButton.frame.size.height/2+30*BILI, huiMinZhengCeButton.frame.size.width, 15*BILI)];
    chuZhiLable.textColor = [UIColor whiteColor];
    chuZhiLable.font = [UIFont systemFontOfSize:15*BILI];
    chuZhiLable.textAlignment = NSTextAlignmentCenter;
    chuZhiLable.text = @"政策解读";
    [zhengCeJieDuButton addSubview:chuZhiLable];
    
    UIImageView * chuZhiImageView = [[UIImageView alloc] initWithFrame:CGRectMake((huiMinZhengCeButton.frame.size.width-40*BILI)/2, huiMinZhengCeButton.frame.size.height/2+10*BILI-40*BILI, 40*BILI, 40*BILI)];
    chuZhiImageView.image = [UIImage imageNamed:@"zhongDianChangSuoTaiZHang"];
    [zhengCeJieDuButton addSubview:chuZhiImageView];
    
    
    
    UIButton *  yuMenYinXiangButton = [[UIButton alloc] initWithFrame:CGRectMake(zhengCeJieDuButton.frame.origin.x+zhengCeJieDuButton.frame.size.width+30*BILI, zhengCeJieDuButton.frame.origin.y, buttonWidth, buttonWidth)];
    yuMenYinXiangButton.layer.cornerRadius = 4*BILI;
    yuMenYinXiangButton.backgroundColor = UIColorFromRGB(0x5BBD63);
    [yuMenYinXiangButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
     yuMenYinXiangButton.titleLabel.font = [UIFont systemFontOfSize:16*BILI];
    [yuMenYinXiangButton addTarget:self action:@selector(yuMenYinXiangButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:yuMenYinXiangButton];
    
    UILabel * baoGaoLable = [[UILabel alloc] initWithFrame:CGRectMake(0*BILI, huiMinZhengCeButton.frame.size.height/2+30*BILI, huiMinZhengCeButton.frame.size.width, 15*BILI)];
    baoGaoLable.textColor = [UIColor whiteColor];
    baoGaoLable.font = [UIFont systemFontOfSize:15*BILI];
    baoGaoLable.textAlignment = NSTextAlignmentCenter;
    baoGaoLable.text = @"玉门印象";
    [yuMenYinXiangButton addSubview:baoGaoLable];
    
    UIImageView * baoGaoImageView = [[UIImageView alloc] initWithFrame:CGRectMake((huiMinZhengCeButton.frame.size.width-40*BILI)/2, huiMinZhengCeButton.frame.size.height/2+10*BILI-40*BILI, 40*BILI, 40*BILI)];
    baoGaoImageView.image = [UIImage imageNamed:@"yumen"];
    [yuMenYinXiangButton addSubview:baoGaoImageView];
    
    
}
-(void)leftClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)huiMinZhengCeButtonClick
{
    ZhengCeXuanChuanListViewController * vc = [[ZhengCeXuanChuanListViewController alloc] init];
    vc.titleStr = @"惠民政策";
    vc.type = @"1";
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)pingAnJianSheButtonClick
{
    ZhengCeXuanChuanListViewController * vc = [[ZhengCeXuanChuanListViewController alloc] init];
    vc.titleStr = @"平安建设";
    vc.type = @"2";
    [self.navigationController pushViewController:vc animated:YES];

}

-(void)puFaXuanChuanButtonClick
{
    ZhengCeXuanChuanListViewController * vc = [[ZhengCeXuanChuanListViewController alloc] init];
    vc.titleStr = @"普法宣传";
    vc.type = @"3";
    [self.navigationController pushViewController:vc animated:YES];

}

-(void)zhengCeJieDuButtonClick
{
    ZhengCeXuanChuanListViewController * vc = [[ZhengCeXuanChuanListViewController alloc] init];
    vc.titleStr = @"政策解读";
    vc.type = @"4";
    [self.navigationController pushViewController:vc animated:YES];

}

-(void)yuMenYinXiangButtonClick
{
    ZhengCeXuanChuanListViewController * vc = [[ZhengCeXuanChuanListViewController alloc] init];
    vc.titleStr = @"玉门印象";
    vc.type = @"5";
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
