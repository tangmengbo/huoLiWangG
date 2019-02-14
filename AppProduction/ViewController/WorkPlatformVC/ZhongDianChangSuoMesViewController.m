//
//  ZhongDianChangSuoMesViewController.m
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/19.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ZhongDianChangSuoMesViewController.h"

@interface ZhongDianChangSuoMesViewController ()

@end

@implementation ZhongDianChangSuoMesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLale.text = @"重点场所信息";
    self.titleLale.textColor = [UIColor whiteColor];
    self.cloudClient = [CloudClient getInstance];
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT-(self.navView.frame.origin.y+self.navView.frame.size.height))];
    [self.view addSubview:self.mainScrollView];
    
    UIButton * ruHuZouFangButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-64*BILI-20*BILI, VIEW_HEIGHT-64*BILI-30*BILI, 64*BILI, 64*BILI)];
    [ruHuZouFangButton setBackgroundImage:[UIImage imageNamed:@"ruHuZouFang"] forState:UIControlStateNormal];
    [ruHuZouFangButton addTarget:self action:@selector(ruHuButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ruHuZouFangButton];
    
    UILabel * ruHuZouFangLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 36*BILI, 64*BILI, 14*BILI)];
    ruHuZouFangLable.font = [UIFont systemFontOfSize:6*BILI];
    ruHuZouFangLable.textAlignment = NSTextAlignmentCenter;
    ruHuZouFangLable.text = @"巡查登记";
    ruHuZouFangLable.textColor = [UIColor whiteColor];
    [ruHuZouFangButton addSubview:ruHuZouFangLable];
    
    [self showNewLoadingView:nil view:self.view];
    [self.cloudClient zhongDianChangSuoMes:@"patrolVisits!foucusPlaceView.do"
                                    dataid:self.dataid
                                       delegate:self
                                       selector:@selector(getMesSuccess:)
                                  errorSelector:@selector(getMesError:)];
}
-(void)ruHuButtonClick
{
    YiBAnChangSuoViewController * vc = [[YiBAnChangSuoViewController alloc] init];
    vc.info = self.info;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)getMesSuccess:(NSDictionary *)info
{
    self.info = info;
    [self hideNewLoadingView];
    ///////////////////////场所名称
    UILabel * nameLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, 0, VIEW_WIDTH, 50*BILI)];
    nameLable.textColor = UIColorFromRGB(0x4A4A4A);
    nameLable.font = [UIFont systemFontOfSize:18*BILI];
    nameLable.text = [NSString stringWithFormat:@"场所名称:  %@",[info objectForKey:@"placename"]];
    [self.mainScrollView addSubview:nameLable];
    
    UIView * nameLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50*BILI-1, VIEW_WIDTH-26*BILI, 1)];
    nameLineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [nameLable addSubview:nameLineView];
    
    //////////////////////场所负责人姓名
    UILabel * sexLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, nameLable.frame.origin.y+nameLable.frame.size.height, VIEW_WIDTH, 50*BILI)];
    sexLable.textColor = UIColorFromRGB(0x4A4A4A);
    sexLable.font = [UIFont systemFontOfSize:18*BILI];
    sexLable.text = [NSString stringWithFormat:@"场所负责人姓名:  %@",[info objectForKey:@"policename"]];
    [self.mainScrollView addSubview:sexLable];
    
    UIView * sexLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50*BILI-1, VIEW_WIDTH-26*BILI, 1)];
    sexLineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [sexLable addSubview:sexLineView];
    
    
    //////////////////////场所祥址
    UILabel * telLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, sexLable.frame.origin.y+sexLable.frame.size.height, VIEW_WIDTH, 50*BILI)];
    telLable.textColor = UIColorFromRGB(0x4A4A4A);
    telLable.font = [UIFont systemFontOfSize:18*BILI];
    telLable.text = [NSString stringWithFormat:@"场所祥址:  %@",[info objectForKey:@"address"]];
    telLable.adjustsFontSizeToFitWidth = YES;
    [self.mainScrollView addSubview:telLable];
    
    UIView * telLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50*BILI-1, VIEW_WIDTH-26*BILI, 1)];
    telLineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [telLable addSubview:telLineView];
    
    //////////////////////电子邮件
    UILabel * sfzLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, telLable.frame.origin.y+telLable.frame.size.height, VIEW_WIDTH, 50*BILI)];
    sfzLable.textColor = UIColorFromRGB(0x4A4A4A);
    sfzLable.font = [UIFont systemFontOfSize:18*BILI];
    sfzLable.text = [NSString stringWithFormat:@"电子邮件:  %@",[info objectForKey:@"email"]];
    [self.mainScrollView addSubview:sfzLable];
    
    UIView * sfzLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50*BILI-1, VIEW_WIDTH-26*BILI, 1)];
    sfzLineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [sfzLable addSubview:sfzLineView];
    
    
    //////////////////////主要经营活动
    UILabel * shengRiLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, sfzLable.frame.origin.y+sfzLable.frame.size.height, VIEW_WIDTH, 50*BILI)];
    shengRiLable.textColor = UIColorFromRGB(0x4A4A4A);
    shengRiLable.font = [UIFont systemFontOfSize:18*BILI];
    shengRiLable.text = [NSString stringWithFormat:@"主要经营活动:  %@",[info objectForKey:@"jyhd"]];
    [self.mainScrollView addSubview:shengRiLable];
    
    UIView * shengRiLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50*BILI-1, VIEW_WIDTH-26*BILI, 1)];
    shengRiLineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [shengRiLable addSubview:shengRiLineView];
    
    
    //////////////////////责任单位
    UILabel * minZuLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, shengRiLable.frame.origin.y+shengRiLable.frame.size.height, VIEW_WIDTH, 50*BILI)];
    minZuLable.textColor = UIColorFromRGB(0x4A4A4A);
    minZuLable.font = [UIFont systemFontOfSize:18*BILI];
    minZuLable.text = [NSString stringWithFormat:@"责任单位:  %@",[info objectForKey:@"pcs"]];
    [self.mainScrollView addSubview:minZuLable];
    
    UIView * mianZuLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50*BILI-1, VIEW_WIDTH-26*BILI, 1)];
    mianZuLineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [minZuLable addSubview:mianZuLineView];
    
    
    //////////////////////责任人
    UILabel * jiGuanLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, minZuLable.frame.origin.y+minZuLable.frame.size.height, VIEW_WIDTH, 50*BILI)];
    jiGuanLable.textColor = UIColorFromRGB(0x4A4A4A);
    jiGuanLable.font = [UIFont systemFontOfSize:18*BILI];
    jiGuanLable.text = [NSString stringWithFormat:@"责任人:  %@",[info objectForKey:@"policename"]];
    [self.mainScrollView addSubview:jiGuanLable];
    
    UIView * jiGuanLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50*BILI-1, VIEW_WIDTH-26*BILI, 1)];
    jiGuanLineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [jiGuanLable addSubview:jiGuanLineView];
    
    
    //////////////////////责任人电话
    UILabel * hunYinLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, jiGuanLable.frame.origin.y+jiGuanLable.frame.size.height, VIEW_WIDTH, 50*BILI)];
    hunYinLable.textColor = UIColorFromRGB(0x4A4A4A);
    hunYinLable.font = [UIFont systemFontOfSize:18*BILI];
    hunYinLable.text = [NSString stringWithFormat:@"责任人电话:  %@",[info objectForKey:@"policetel"]];
    [self.mainScrollView addSubview:hunYinLable];
    
    UIView * huiYinLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50*BILI-1, VIEW_WIDTH-26*BILI, 1)];
    huiYinLineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [hunYinLable addSubview:huiYinLineView];
    
    
    //////////////////////法人代表身份证号
    UILabel * zhengZhiMianMaoLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, hunYinLable.frame.origin.y+hunYinLable.frame.size.height, VIEW_WIDTH, 50*BILI)];
    zhengZhiMianMaoLable.textColor = UIColorFromRGB(0x4A4A4A);
    zhengZhiMianMaoLable.font = [UIFont systemFontOfSize:18*BILI];
    zhengZhiMianMaoLable.text = [NSString stringWithFormat:@"法人代表身份证号:  %@",[info objectForKey:@"legalcardno"]];
    zhengZhiMianMaoLable.adjustsFontSizeToFitWidth = YES;
    [self.mainScrollView addSubview:zhengZhiMianMaoLable];
    
    UIView * zhengZhiMianMaLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50*BILI-1, VIEW_WIDTH-26*BILI, 1)];
    zhengZhiMianMaLineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [zhengZhiMianMaoLable addSubview:zhengZhiMianMaLineView];
    
    
    //////////////////////法人代姓名
    UILabel * xueLiLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, zhengZhiMianMaoLable.frame.origin.y+zhengZhiMianMaoLable.frame.size.height, VIEW_WIDTH, 50*BILI)];
    xueLiLable.textColor = UIColorFromRGB(0x4A4A4A);
    xueLiLable.font = [UIFont systemFontOfSize:18*BILI];
    xueLiLable.text = [NSString stringWithFormat:@"法人代姓名:  %@",[info objectForKey:@"legalname"]];
    [self.mainScrollView addSubview:xueLiLable];
    
    UIView * xueLiLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50*BILI-1, VIEW_WIDTH-26*BILI, 1)];
    xueLiLineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [xueLiLable addSubview:xueLiLineView];
    
    
    //////////////////////法人代电话
    UILabel * zongJiaoLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, xueLiLable.frame.origin.y+xueLiLable.frame.size.height, VIEW_WIDTH, 50*BILI)];
    zongJiaoLable.textColor = UIColorFromRGB(0x4A4A4A);
    zongJiaoLable.font = [UIFont systemFontOfSize:18*BILI];
    zongJiaoLable.text = [NSString stringWithFormat:@"法人代电话:  %@",[info objectForKey:@"legaltel"]];
    [self.mainScrollView addSubview:zongJiaoLable];
    
    UIView * zongJiaoLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50*BILI-1, VIEW_WIDTH-26*BILI, 1)];
    zongJiaoLineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [zongJiaoLable addSubview:zongJiaoLineView];
    
    
    //////////////////////务工人员数量
    UILabel * zhiYeLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, zongJiaoLable.frame.origin.y+zongJiaoLable.frame.size.height, VIEW_WIDTH, 50*BILI)];
    zhiYeLable.textColor = UIColorFromRGB(0x4A4A4A);
    zhiYeLable.font = [UIFont systemFontOfSize:18*BILI];
    NSString * worknum = [info objectForKey:@"worknum"];
    zhiYeLable.text = [NSString stringWithFormat:@"务工人员数量:  %d",worknum.intValue];
    [self.mainScrollView addSubview:zhiYeLable];
    
    UIView * zhiYeLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50*BILI-1, VIEW_WIDTH-26*BILI, 1)];
    zhiYeLineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [zhiYeLable addSubview:zhiYeLineView];
    
    //////////////////////流动人员数量
    UILabel * fuWuChuSuoLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, zhiYeLable.frame.origin.y+zhiYeLable.frame.size.height, VIEW_WIDTH, 50*BILI)];
    fuWuChuSuoLable.textColor = UIColorFromRGB(0x4A4A4A);
    fuWuChuSuoLable.font = [UIFont systemFontOfSize:18*BILI];
    NSString * ldnum = [info objectForKey:@"ldnum"];
    fuWuChuSuoLable.text = [NSString stringWithFormat:@"流动人员数量:  %d",ldnum.intValue];
    [self.mainScrollView addSubview:fuWuChuSuoLable];
    
    UIView * fuWuChuSuoLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50*BILI-1, VIEW_WIDTH-26*BILI, 1)];
    fuWuChuSuoLineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [fuWuChuSuoLable addSubview:fuWuChuSuoLineView];
    
    //////////////////////网格名称
    UILabel * xianZhuDiZhiLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, fuWuChuSuoLable.frame.origin.y+fuWuChuSuoLable.frame.size.height, VIEW_WIDTH-26*BILI, 50*BILI)];
    xianZhuDiZhiLable.textColor = UIColorFromRGB(0x4A4A4A);
    xianZhuDiZhiLable.font = [UIFont systemFontOfSize:18*BILI];
    xianZhuDiZhiLable.text = [NSString stringWithFormat:@"网格名称:  %@",[info objectForKey:@"gridname"]];
    xianZhuDiZhiLable.adjustsFontSizeToFitWidth = YES;
    [self.mainScrollView addSubview:xianZhuDiZhiLable];
    
    UIView * xianZhuDiZhiLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50*BILI-1, VIEW_WIDTH-26*BILI, 1)];
    xianZhuDiZhiLineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [xianZhuDiZhiLable addSubview:xianZhuDiZhiLineView];
    
    //////////////////////网格员(长)姓名
    UILabel * beiZhuLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, xianZhuDiZhiLable.frame.origin.y+xianZhuDiZhiLable.frame.size.height, VIEW_WIDTH, 50*BILI)];
    beiZhuLable.textColor = UIColorFromRGB(0x4A4A4A);
    beiZhuLable.font = [UIFont systemFontOfSize:18*BILI];
    beiZhuLable.text = [NSString stringWithFormat:@"网格员(长)姓名:  %@",[info objectForKey:@"wgyname"]];
    [self.mainScrollView addSubview:beiZhuLable];
    
    UIView * beiZhuLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50*BILI-1, VIEW_WIDTH-26*BILI, 1)];
    beiZhuLineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [beiZhuLable addSubview:beiZhuLineView];
    
    //////////////////////网格员联系方式
    UILabel * renShuLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, beiZhuLable.frame.origin.y+beiZhuLable.frame.size.height, VIEW_WIDTH, 54*BILI)];
    renShuLable.textColor = UIColorFromRGB(0x4A4A4A);
    renShuLable.font = [UIFont systemFontOfSize:18*BILI];
    NSNumber * renShu = [info objectForKey:@"wgylxfs"];
    renShuLable.text = [NSString stringWithFormat:@"网格员联系方式:  %d",renShu.intValue];
    [self.mainScrollView addSubview:renShuLable];
    
    UIView * renShuLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 54*BILI-4*BILI, VIEW_WIDTH-26*BILI, 4*BILI)];
    renShuLineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [renShuLable addSubview:renShuLineView];
    
    [self.mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH, renShuLable.frame.origin.y+renShuLable.frame.size.height)];
    
}
-(void)getMesError:(NSDictionary *)info
{
    [self hideNewLoadingView];
    [Common showToastView:[info objectForKey:@"message"] view:self.view];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
