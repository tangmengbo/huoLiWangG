//
//  ZhongDianRenQunXinXiViewController.m
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/11.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ZhongDianRenQunXinXiViewController.h"

@interface ZhongDianRenQunXinXiViewController ()

@end

@implementation ZhongDianRenQunXinXiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLale.text = @"信息";
    self.titleLale.textColor = [UIColor whiteColor];
    
    [self setTabBarHidden];
    
    
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT-(self.navView.frame.origin.y+self.navView.frame.size.height))];
    self.mainScrollView.showsVerticalScrollIndicator = NO;
    self.mainScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.mainScrollView];
    
    UIButton * ruHuZouFangButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-64*BILI-20*BILI, VIEW_HEIGHT-64*BILI-30*BILI, 64*BILI, 64*BILI)];
    [ruHuZouFangButton setBackgroundImage:[UIImage imageNamed:@"ruHuZouFang"] forState:UIControlStateNormal];
    [ruHuZouFangButton addTarget:self action:@selector(zouFangDengJiButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ruHuZouFangButton];
    
    UILabel * ruHuZouFangLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 36*BILI, 64*BILI, 14*BILI)];
    ruHuZouFangLable.font = [UIFont systemFontOfSize:6*BILI];
    ruHuZouFangLable.textAlignment = NSTextAlignmentCenter;
    ruHuZouFangLable.text = @"走访登记";
    ruHuZouFangLable.textColor = [UIColor whiteColor];
    [ruHuZouFangButton addSubview:ruHuZouFangLable];


    
    self.cloudClient = [CloudClient getInstance];
    
    [self showNewLoadingView:nil view:self.view];
    [self.cloudClient zhongDianRenYuanDetail:@"population!fouscusUserView.do"
                                      dataid:self.dataid
                                    delegate:self
                                    selector:@selector(getMessageSuccess:)
                               errorSelector:@selector(getMessageError:)];
    
    
}
-(void)getMessageSuccess:(NSDictionary *)info
{
    [self hideNewLoadingView];
    
    self.info = info;
    
    ///////////////////////姓名
    UILabel * nameLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, 0, VIEW_WIDTH, 50*BILI)];
    nameLable.textColor = UIColorFromRGB(0x4A4A4A);
    nameLable.font = [UIFont systemFontOfSize:18*BILI];
    nameLable.text = [NSString stringWithFormat:@"姓名:  %@",[info objectForKey:@"realname"]];
    [self.mainScrollView addSubview:nameLable];
    
    UIView * nameLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50*BILI-1, VIEW_WIDTH-26*BILI, 1)];
    nameLineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [nameLable addSubview:nameLineView];
    
    //////////////////////人员属性
    UILabel * shuXingLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, nameLable.frame.origin.y+nameLable.frame.size.height, VIEW_WIDTH, 50*BILI)];
    shuXingLable.textColor = UIColorFromRGB(0x4A4A4A);
    shuXingLable.font = [UIFont systemFontOfSize:18*BILI];
    shuXingLable.text = [NSString stringWithFormat:@"人员属性:  %@",[info objectForKey:@"markinfo"]];
    [self.mainScrollView addSubview:shuXingLable];
    
    UIView * shuXingLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50*BILI-1, VIEW_WIDTH-26*BILI, 1)];
    shuXingLineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [shuXingLable addSubview:shuXingLineView];
    
    
    //////////////////////性别
    UILabel * sexLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, shuXingLable.frame.origin.y+shuXingLable.frame.size.height, VIEW_WIDTH, 50*BILI)];
    sexLable.textColor = UIColorFromRGB(0x4A4A4A);
    sexLable.font = [UIFont systemFontOfSize:18*BILI];
    sexLable.text = [NSString stringWithFormat:@"性别:  %@",[info objectForKey:@"sex"]];
    [self.mainScrollView addSubview:sexLable];
    
    UIView * sexLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50*BILI-1, VIEW_WIDTH-26*BILI, 1)];
    sexLineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [sexLable addSubview:sexLineView];
    
    //////////////////////民族
    UILabel * minZuLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, sexLable.frame.origin.y+sexLable.frame.size.height, VIEW_WIDTH, 50*BILI)];
    minZuLable.textColor = UIColorFromRGB(0x4A4A4A);
    minZuLable.font = [UIFont systemFontOfSize:18*BILI];
    minZuLable.text = [NSString stringWithFormat:@"民族:  %@",[info objectForKey:@"nation"]];
    [self.mainScrollView addSubview:minZuLable];
    
    UIView * mianZuLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50*BILI-1, VIEW_WIDTH-26*BILI, 1)];
    mianZuLineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [minZuLable addSubview:mianZuLineView];
    
    //////////////////////出生日期
    UILabel * shengRiLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, minZuLable.frame.origin.y+minZuLable.frame.size.height, VIEW_WIDTH, 50*BILI)];
    shengRiLable.textColor = UIColorFromRGB(0x4A4A4A);
    shengRiLable.font = [UIFont systemFontOfSize:18*BILI];
   shengRiLable.text = [NSString stringWithFormat:@"出生日期:  %@",[info objectForKey:@"birthdate"]];
    [self.mainScrollView addSubview:shengRiLable];
    
    UIView * shengRiLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50*BILI-1, VIEW_WIDTH-26*BILI, 1)];
    shengRiLineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [shengRiLable addSubview:shengRiLineView];
    
    //////////////////////身份证
    UILabel * sfzLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, shengRiLable.frame.origin.y+shengRiLable.frame.size.height, VIEW_WIDTH, 50*BILI)];
    sfzLable.textColor = UIColorFromRGB(0x4A4A4A);
    sfzLable.font = [UIFont systemFontOfSize:18*BILI];
    sfzLable.text = [NSString stringWithFormat:@"身份证号:  %@",[info objectForKey:@"idcard"]];
    [self.mainScrollView addSubview:sfzLable];
    
    UIView * sfzLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50*BILI-1, VIEW_WIDTH-26*BILI, 1)];
    sfzLineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [sfzLable addSubview:sfzLineView];
    
    
    //////////////////////电话
    UILabel * telLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, sfzLable.frame.origin.y+sfzLable.frame.size.height, VIEW_WIDTH, 50*BILI)];
    telLable.textColor = UIColorFromRGB(0x4A4A4A);
    telLable.font = [UIFont systemFontOfSize:18*BILI];
    telLable.text = [NSString stringWithFormat:@"电话号码:  %@",[info objectForKey:@"tel"]];
    [self.mainScrollView addSubview:telLable];
    
    UIView * telLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50*BILI-1, VIEW_WIDTH-26*BILI, 1)];
    telLineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [telLable addSubview:telLineView];
    
    
    //////////////////////学历
    UILabel * xueLiLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, telLable.frame.origin.y+telLable.frame.size.height, VIEW_WIDTH, 50*BILI)];
    xueLiLable.textColor = UIColorFromRGB(0x4A4A4A);
    xueLiLable.font = [UIFont systemFontOfSize:18*BILI];
    xueLiLable.text = [NSString stringWithFormat:@"文化水平:  %@",[info objectForKey:@"education"]];
    [self.mainScrollView addSubview:xueLiLable];
    
    UIView * xueLiLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50*BILI-1, VIEW_WIDTH-26*BILI, 1)];
    xueLiLineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [xueLiLable addSubview:xueLiLineView];
    
    
    //////////////////////宗教信仰
    UILabel * zongJiaoLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, xueLiLable.frame.origin.y+xueLiLable.frame.size.height, VIEW_WIDTH, 50*BILI)];
    zongJiaoLable.textColor = UIColorFromRGB(0x4A4A4A);
    zongJiaoLable.font = [UIFont systemFontOfSize:18*BILI];
    zongJiaoLable.text = [NSString stringWithFormat:@"宗教信仰:  %@",[info objectForKey:@"faith"]];
    [self.mainScrollView addSubview:zongJiaoLable];
    
    UIView * zongJiaoLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50*BILI-1, VIEW_WIDTH-26*BILI, 1)];
    zongJiaoLineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [zongJiaoLable addSubview:zongJiaoLineView];
    
    
    //////////////////////婚姻状态
    UILabel * hunYinLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, zongJiaoLable.frame.origin.y+zongJiaoLable.frame.size.height, VIEW_WIDTH, 50*BILI)];
    hunYinLable.textColor = UIColorFromRGB(0x4A4A4A);
    hunYinLable.font = [UIFont systemFontOfSize:18*BILI];
    hunYinLable.text = [NSString stringWithFormat:@"婚姻状态:  %@",[info objectForKey:@"marital"]];
    [self.mainScrollView addSubview:hunYinLable];
    
    UIView * huiYinLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50*BILI-1, VIEW_WIDTH-26*BILI, 1)];
    huiYinLineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [hunYinLable addSubview:huiYinLineView];
    
    //////////////////////服务处所
    UILabel * gongZuoDiDianLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, hunYinLable.frame.origin.y+hunYinLable.frame.size.height, VIEW_WIDTH, 50*BILI)];
    gongZuoDiDianLable.textColor = UIColorFromRGB(0x4A4A4A);
    gongZuoDiDianLable.font = [UIFont systemFontOfSize:18*BILI];
    gongZuoDiDianLable.text = [NSString stringWithFormat:@"工作地点:  %@",[info objectForKey:@"workunit"]];
    [self.mainScrollView addSubview:gongZuoDiDianLable];
    
    UIView * gongZuoDiDianLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50*BILI-1, VIEW_WIDTH-26*BILI, 1)];
    gongZuoDiDianLineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [gongZuoDiDianLable addSubview:gongZuoDiDianLineView];
    
    
    //////////////////////职业
    UILabel * zhiYeLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, gongZuoDiDianLable.frame.origin.y+gongZuoDiDianLable.frame.size.height, VIEW_WIDTH, 50*BILI)];
    zhiYeLable.textColor = UIColorFromRGB(0x4A4A4A);
    zhiYeLable.font = [UIFont systemFontOfSize:18*BILI];
    zhiYeLable.text = [NSString stringWithFormat:@"职业:  %@",[info objectForKey:@"occupation"]];
    [self.mainScrollView addSubview:zhiYeLable];
    
    UIView * zhiYeLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50*BILI-1, VIEW_WIDTH-26*BILI, 1)];
    zhiYeLineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [zhiYeLable addSubview:zhiYeLineView];
    
    //////////////////////现在位置
    UILabel * jiGuanLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, zhiYeLable.frame.origin.y+zhiYeLable.frame.size.height, VIEW_WIDTH, 50*BILI)];
    jiGuanLable.textColor = UIColorFromRGB(0x4A4A4A);
    jiGuanLable.font = [UIFont systemFontOfSize:18*BILI];
    jiGuanLable.text = [NSString stringWithFormat:@"现在位置:   %@",[info objectForKey:@"persentaddress"]];
    zongJiaoLable.adjustsFontSizeToFitWidth = YES;
    [self.mainScrollView addSubview:jiGuanLable];
    
    UIView * jiGuanLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50*BILI-1, VIEW_WIDTH-26*BILI, 1)];
    jiGuanLineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [jiGuanLable addSubview:jiGuanLineView];
    
    [self.mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH, jiGuanLable.frame.origin.y+jiGuanLable.frame.size.height)];

}
-(void)getMessageError:(NSDictionary *)info
{
    [self hideNewLoadingView];
    [Common showToastView:[info objectForKey:@"message"] view:self.view];
}
-(void)zouFangDengJiButtonClick
{
    ZhongDianRenQunShangBaoViewController * vc = [[ZhongDianRenQunShangBaoViewController alloc] init];
    vc.info = self.info;
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
