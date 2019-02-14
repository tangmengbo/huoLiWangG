//
//  NetWorkingHomeViewController.m
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/9.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "GongZuoTaiZhangViewController.h"

@interface GongZuoTaiZhangViewController ()

@end

@implementation GongZuoTaiZhangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLale.text = @"工作台账";
    self.titleLale.textColor = [UIColor whiteColor];
    
    self.backImageView.frame = CGRectMake(self.backImageView.frame.origin.x, (self.navView.frame.size.height-18*BILIY)/2,  18*59/65*BILI, 18*BILIY);
    self.backImageView.image = [UIImage imageNamed:@"xiaoxi_lingDang"];
    UIButton * rightButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-50*BILI, 0, 50*BILI, self.navView.frame.size.height)];
    [rightButton addTarget:self action:@selector(bangZhuButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setTitle:@"帮助" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:16*BILI];
    [self.navView addSubview:rightButton];
    
    float buttonWidth = (VIEW_WIDTH-25*BILI-30*BILI-25*BILI)/2;
    float originY = (VIEW_HEIGHT-buttonWidth*3-20*BILI-(self.navView.frame.origin.y+self.navView.frame.size.height))/2-SafeAreaBottomHeight/2;
    
    UIButton *  huiMinZhengCeButton = [[UIButton alloc] initWithFrame:CGRectMake(25*BILI, self.navView.frame.origin.y+self.navView.frame.size.height+originY, buttonWidth, buttonWidth)];
    huiMinZhengCeButton.layer.cornerRadius = 8*BILI;
    huiMinZhengCeButton.backgroundColor = UIColorFromRGB(0xFF9735);
    [huiMinZhengCeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    huiMinZhengCeButton.titleLabel.font = [UIFont systemFontOfSize:16*BILI];
    [huiMinZhengCeButton addTarget:self action:@selector(huiMinZhengCeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:huiMinZhengCeButton];
    
    UILabel * zhongDianLableLable = [[UILabel alloc] initWithFrame:CGRectMake(0*BILI, huiMinZhengCeButton.frame.size.height/2+30*BILI, huiMinZhengCeButton.frame.size.width, 15*BILI)];
    zhongDianLableLable.textColor = [UIColor whiteColor];
    zhongDianLableLable.font = [UIFont systemFontOfSize:15*BILI];
    zhongDianLableLable.textAlignment = NSTextAlignmentCenter;
    zhongDianLableLable.text = @"重点场所台账";
    [huiMinZhengCeButton addSubview:zhongDianLableLable];
    
    UIImageView * tipImageView = [[UIImageView alloc] initWithFrame:CGRectMake((huiMinZhengCeButton.frame.size.width-40*BILI)/2, huiMinZhengCeButton.frame.size.height/2+10*BILI-40*BILI, 40*BILI, 40*BILI)];
    tipImageView.image = [UIImage imageNamed:@"zhongDianChangSuoTaiZHang"];
    [huiMinZhengCeButton addSubview:tipImageView];
    
    
    
    UIButton *  pingAnJianSheButton = [[UIButton alloc] initWithFrame:CGRectMake(huiMinZhengCeButton.frame.origin.x+huiMinZhengCeButton.frame.size.width+30*BILI, huiMinZhengCeButton.frame.origin.y, buttonWidth, buttonWidth)];
    pingAnJianSheButton.layer.cornerRadius = 8*BILI;
    pingAnJianSheButton.backgroundColor = UIColorFromRGB(0x3EA5E7);
    [pingAnJianSheButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    pingAnJianSheButton.titleLabel.font = [UIFont systemFontOfSize:16*BILI];
    [pingAnJianSheButton addTarget:self action:@selector(pingAnJianSheButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pingAnJianSheButton];
    
    
    UILabel * yiBanLableLable = [[UILabel alloc] initWithFrame:CGRectMake(0*BILI, huiMinZhengCeButton.frame.size.height/2+30*BILI, huiMinZhengCeButton.frame.size.width, 15*BILI)];
    yiBanLableLable.textColor = [UIColor whiteColor];
    yiBanLableLable.font = [UIFont systemFontOfSize:15*BILI];
    yiBanLableLable.textAlignment = NSTextAlignmentCenter;
    yiBanLableLable.text = @"一般场所台账";
    [pingAnJianSheButton addSubview:yiBanLableLable];
    
    UIImageView * yiBanImageView = [[UIImageView alloc] initWithFrame:CGRectMake((huiMinZhengCeButton.frame.size.width-40*BILI)/2, huiMinZhengCeButton.frame.size.height/2+10*BILI-40*BILI*83/99, 40*BILI, 40*BILI*83/99)];
    yiBanImageView.image = [UIImage imageNamed:@"yiBanChangSuoTaiZhang"];
    [pingAnJianSheButton addSubview:yiBanImageView];

    
    UIButton *  puFaXuanChuanButton = [[UIButton alloc] initWithFrame:CGRectMake(25*BILI, pingAnJianSheButton.frame.origin.y+pingAnJianSheButton.frame.size.height+10*BILIY, buttonWidth, buttonWidth)];
    puFaXuanChuanButton.layer.cornerRadius = 8*BILI;
    puFaXuanChuanButton.backgroundColor = UIColorFromRGB(0x00D2D6);
    [puFaXuanChuanButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    puFaXuanChuanButton.titleLabel.font = [UIFont systemFontOfSize:16*BILI];
    [puFaXuanChuanButton addTarget:self action:@selector(puFaXuanChuanButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:puFaXuanChuanButton];
    
    
    UILabel * guanKongLable = [[UILabel alloc] initWithFrame:CGRectMake(0*BILI, huiMinZhengCeButton.frame.size.height/2+30*BILI, huiMinZhengCeButton.frame.size.width, 15*BILI)];
    guanKongLable.textColor = [UIColor whiteColor];
    guanKongLable.font = [UIFont systemFontOfSize:15*BILI];
    guanKongLable.textAlignment = NSTextAlignmentCenter;
    guanKongLable.text = @"管控台账";
    [puFaXuanChuanButton addSubview:guanKongLable];
    
    UIImageView * guanKongImageView = [[UIImageView alloc] initWithFrame:CGRectMake((huiMinZhengCeButton.frame.size.width-40*BILI)/2, huiMinZhengCeButton.frame.size.height/2+10*BILI-40*BILI*132/116, 40*BILI, 40*BILI*132/116)];
    guanKongImageView.image = [UIImage imageNamed:@"guanKongTaiZhang"];
    [puFaXuanChuanButton addSubview:guanKongImageView];
    
    
    UIButton *  ruHuZouFangButton = [[UIButton alloc] initWithFrame:CGRectMake(puFaXuanChuanButton.frame.origin.x+puFaXuanChuanButton.frame.size.width+30*BILI, pingAnJianSheButton.frame.origin.y+pingAnJianSheButton.frame.size.height+10*BILIY, buttonWidth, buttonWidth)];
    ruHuZouFangButton.layer.cornerRadius = 8*BILI;
    ruHuZouFangButton.backgroundColor = UIColorFromRGB(0x1ADB9F);
    [ruHuZouFangButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    ruHuZouFangButton.titleLabel.font = [UIFont systemFontOfSize:16*BILI];
    [ruHuZouFangButton addTarget:self action:@selector(ruHuZouFangButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ruHuZouFangButton];
    
    UILabel * ruHuLable = [[UILabel alloc] initWithFrame:CGRectMake(0*BILI, huiMinZhengCeButton.frame.size.height/2+30*BILI, huiMinZhengCeButton.frame.size.width, 15*BILI)];
    ruHuLable.textColor = [UIColor whiteColor];
    ruHuLable.font = [UIFont systemFontOfSize:15*BILI];
    ruHuLable.textAlignment = NSTextAlignmentCenter;
    ruHuLable.text = @"入户走访";
    [ruHuZouFangButton addSubview:ruHuLable];
    
    UIImageView * ruHuImageView = [[UIImageView alloc] initWithFrame:CGRectMake((huiMinZhengCeButton.frame.size.width-40*BILI)/2, huiMinZhengCeButton.frame.size.height/2+10*BILI-40*BILI, 40*BILI, 40*BILI)];
    ruHuImageView.image = [UIImage imageNamed:@"ruHu"];
    [ruHuZouFangButton addSubview:ruHuImageView];
    
    UIButton *  zhengCeJieDuButton = [[UIButton alloc] initWithFrame:CGRectMake(25*BILI, puFaXuanChuanButton.frame.origin.y+puFaXuanChuanButton.frame.size.height+10*BILIY, buttonWidth, buttonWidth)];
    zhengCeJieDuButton.layer.cornerRadius = 8*BILI;
    zhengCeJieDuButton.backgroundColor = UIColorFromRGB(0xA995DC);
    [zhengCeJieDuButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    zhengCeJieDuButton.titleLabel.font = [UIFont systemFontOfSize:16*BILI];
    [zhengCeJieDuButton addTarget:self action:@selector(zhengCeJieDuButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:zhengCeJieDuButton];
    
    UILabel * chuZhiLable = [[UILabel alloc] initWithFrame:CGRectMake(0*BILI, huiMinZhengCeButton.frame.size.height/2+30*BILI, huiMinZhengCeButton.frame.size.width, 15*BILI)];
    chuZhiLable.textColor = [UIColor whiteColor];
    chuZhiLable.font = [UIFont systemFontOfSize:15*BILI];
    chuZhiLable.textAlignment = NSTextAlignmentCenter;
    chuZhiLable.text = @"处置台账";
    [zhengCeJieDuButton addSubview:chuZhiLable];
    
    UIImageView * chuZhiImageView = [[UIImageView alloc] initWithFrame:CGRectMake((huiMinZhengCeButton.frame.size.width-40*BILI)/2, huiMinZhengCeButton.frame.size.height/2+10*BILI-40*BILI, 40*BILI, 40*BILI)];
    chuZhiImageView.image = [UIImage imageNamed:@"zhongDianChangSuoTaiZHang"];
    [zhengCeJieDuButton addSubview:chuZhiImageView];
    
    UIButton *  yuMenYinXiangButton = [[UIButton alloc] initWithFrame:CGRectMake(zhengCeJieDuButton.frame.origin.x+zhengCeJieDuButton.frame.size.width+30*BILI, zhengCeJieDuButton.frame.origin.y, buttonWidth, buttonWidth)];
    yuMenYinXiangButton.layer.cornerRadius = 8*BILI;
    yuMenYinXiangButton.backgroundColor = UIColorFromRGB(0xFBA1B9);
    [yuMenYinXiangButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    yuMenYinXiangButton.titleLabel.font = [UIFont systemFontOfSize:16*BILI];
    [yuMenYinXiangButton addTarget:self action:@selector(yuMenYinXiangButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:yuMenYinXiangButton];
    
    UILabel * baoGaoLable = [[UILabel alloc] initWithFrame:CGRectMake(0*BILI, huiMinZhengCeButton.frame.size.height/2+30*BILI, huiMinZhengCeButton.frame.size.width, 15*BILI)];
    baoGaoLable.textColor = [UIColor whiteColor];
    baoGaoLable.font = [UIFont systemFontOfSize:15*BILI];
    baoGaoLable.textAlignment = NSTextAlignmentCenter;
    baoGaoLable.text = @"报告台账";
    [yuMenYinXiangButton addSubview:baoGaoLable];
    
    UIImageView * baoGaoImageView = [[UIImageView alloc] initWithFrame:CGRectMake((huiMinZhengCeButton.frame.size.width-40*BILI)/2, huiMinZhengCeButton.frame.size.height/2+10*BILI-40*BILI, 40*BILI, 40*BILI)];
    baoGaoImageView.image = [UIImage imageNamed:@"zhongDianChangSuoTaiZHang"];
    [yuMenYinXiangButton addSubview:baoGaoImageView];

}

-(void)huiMinZhengCeButtonClick
{
    GZTZ_ZhongDIanChangSuoListViewController * vc = [[GZTZ_ZhongDIanChangSuoListViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)pingAnJianSheButtonClick
{
    GZTZ_YiBanChangSuoListViewController * vc = [[GZTZ_YiBanChangSuoListViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)puFaXuanChuanButtonClick
{
    GZTZ_GuanKongTaiZhangListViewController * vc = [[GZTZ_GuanKongTaiZhangListViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)ruHuZouFangButtonClick
{
    GZTZ_RuHuListViewController * vc = [[GZTZ_RuHuListViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)zhengCeJieDuButtonClick
{
    GZTZ_ChuZhiTaiZhangListViewController * vc = [[GZTZ_ChuZhiTaiZhangListViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)yuMenYinXiangButtonClick
{
    GZTZ_BaoGaoTaiZhangListViewController * vc = [[GZTZ_BaoGaoTaiZhangListViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)leftClick
{
    XiaoXiClassifyViewController * vc = [[XiaoXiClassifyViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)bangZhuButtonClick
{
    BangZhuListViewController * vc = [[BangZhuListViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self setTabBarShow];
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
