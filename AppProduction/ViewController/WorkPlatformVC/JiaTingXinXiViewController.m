//
//  JiaTingXinXiViewController.m
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/10.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "JiaTingXinXiViewController.h"
#import "Common.h"

@interface JiaTingXinXiViewController ()

@end

@implementation JiaTingXinXiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLale.textColor = [UIColor whiteColor];
    self.titleLale.text = @"家庭信息";
    [self setTabBarHidden];
    
    self.cloudClient = [CloudClient getInstance];
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT-(self.navView.frame.origin.y+self.navView.frame.size.height))];
    self.mainScrollView.showsVerticalScrollIndicator = NO;
    self.mainScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.mainScrollView];
    
    UIButton * ruHuZouFangButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-64*BILI-20*BILI, VIEW_HEIGHT-64*BILI-30*BILI, 64*BILI, 64*BILI)];
    [ruHuZouFangButton setBackgroundImage:[UIImage imageNamed:@"ruHuZouFang"] forState:UIControlStateNormal];
    [ruHuZouFangButton addTarget:self action:@selector(ruHuButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ruHuZouFangButton];
    
    UILabel * ruHuZouFangLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 36*BILI, 64*BILI, 14*BILI)];
    ruHuZouFangLable.font = [UIFont systemFontOfSize:6*BILI];
    ruHuZouFangLable.textAlignment = NSTextAlignmentCenter;
    ruHuZouFangLable.text = @"入户走访";
    ruHuZouFangLable.textColor = [UIColor whiteColor];
    [ruHuZouFangButton addSubview:ruHuZouFangLable];
    
    [self showNewLoadingView:nil view:self.view];
    [self.cloudClient ruHuZouFangHuZhuDetailMes:@"population!householderView.do"
                                       holderid:self.holderid
                                       delegate:self
                                       selector:@selector(getMesSuccess:)
                                  errorSelector:@selector(getMesError:)];
    
   
}
-(void)getMesSuccess:(NSDictionary *)info
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
    
    //////////////////////性别
    UILabel * sexLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, nameLable.frame.origin.y+nameLable.frame.size.height, VIEW_WIDTH, 50*BILI)];
    sexLable.textColor = UIColorFromRGB(0x4A4A4A);
    sexLable.font = [UIFont systemFontOfSize:18*BILI];
    sexLable.text = [NSString stringWithFormat:@"性别:  %@",[info objectForKey:@"sex"]];
    [self.mainScrollView addSubview:sexLable];
    
    UIView * sexLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50*BILI-1, VIEW_WIDTH-26*BILI, 1)];
    sexLineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [sexLable addSubview:sexLineView];
    
    
    //////////////////////电话
    UILabel * telLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, sexLable.frame.origin.y+sexLable.frame.size.height, VIEW_WIDTH, 50*BILI)];
    telLable.textColor = UIColorFromRGB(0x4A4A4A);
    telLable.font = [UIFont systemFontOfSize:18*BILI];
    telLable.text = [NSString stringWithFormat:@"电话:  %@",[info objectForKey:@"tel"]];
    [self.mainScrollView addSubview:telLable];
    
    UIView * telLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50*BILI-1, VIEW_WIDTH-26*BILI, 1)];
    telLineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [telLable addSubview:telLineView];
    
    //////////////////////身份证
    UILabel * sfzLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, telLable.frame.origin.y+telLable.frame.size.height, VIEW_WIDTH, 50*BILI)];
    sfzLable.textColor = UIColorFromRGB(0x4A4A4A);
    sfzLable.font = [UIFont systemFontOfSize:18*BILI];
    sfzLable.text = [NSString stringWithFormat:@"身份证号:  %@",[info objectForKey:@"idcard"]];
    [self.mainScrollView addSubview:sfzLable];
    
    UIView * sfzLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50*BILI-1, VIEW_WIDTH-26*BILI, 1)];
    sfzLineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [sfzLable addSubview:sfzLineView];
    
    
    //////////////////////出生日期
    UILabel * shengRiLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, sfzLable.frame.origin.y+sfzLable.frame.size.height, VIEW_WIDTH, 50*BILI)];
    shengRiLable.textColor = UIColorFromRGB(0x4A4A4A);
    shengRiLable.font = [UIFont systemFontOfSize:18*BILI];
    shengRiLable.text = [NSString stringWithFormat:@"出生日期:  %@",[info objectForKey:@"birthdate"]];
    [self.mainScrollView addSubview:shengRiLable];
    
    UIView * shengRiLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50*BILI-1, VIEW_WIDTH-26*BILI, 1)];
    shengRiLineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [shengRiLable addSubview:shengRiLineView];
    
    
    //////////////////////民族
    UILabel * minZuLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, shengRiLable.frame.origin.y+shengRiLable.frame.size.height, VIEW_WIDTH, 50*BILI)];
    minZuLable.textColor = UIColorFromRGB(0x4A4A4A);
    minZuLable.font = [UIFont systemFontOfSize:18*BILI];
    minZuLable.text = [NSString stringWithFormat:@"民族:  %@",[info objectForKey:@"nation"]];
    [self.mainScrollView addSubview:minZuLable];
    
    UIView * mianZuLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50*BILI-1, VIEW_WIDTH-26*BILI, 1)];
    mianZuLineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [minZuLable addSubview:mianZuLineView];
    
    
    //////////////////////籍贯
    UILabel * jiGuanLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, minZuLable.frame.origin.y+minZuLable.frame.size.height, VIEW_WIDTH, 50*BILI)];
    jiGuanLable.textColor = UIColorFromRGB(0x4A4A4A);
    jiGuanLable.font = [UIFont systemFontOfSize:18*BILI];
     jiGuanLable.text = [NSString stringWithFormat:@"籍贯:  %@",[info objectForKey:@"nativeplace"]];
    [self.mainScrollView addSubview:jiGuanLable];
    
    UIView * jiGuanLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50*BILI-1, VIEW_WIDTH-26*BILI, 1)];
    jiGuanLineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [jiGuanLable addSubview:jiGuanLineView];
    
    
    //////////////////////婚姻状态
    UILabel * hunYinLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, jiGuanLable.frame.origin.y+jiGuanLable.frame.size.height, VIEW_WIDTH, 50*BILI)];
    hunYinLable.textColor = UIColorFromRGB(0x4A4A4A);
    hunYinLable.font = [UIFont systemFontOfSize:18*BILI];
    hunYinLable.text = [NSString stringWithFormat:@"婚姻状态:  %@",[info objectForKey:@"marital"]];
    [self.mainScrollView addSubview:hunYinLable];
    
    UIView * huiYinLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50*BILI-1, VIEW_WIDTH-26*BILI, 1)];
    huiYinLineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [hunYinLable addSubview:huiYinLineView];
    
    
    //////////////////////政治面貌
    UILabel * zhengZhiMianMaoLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, hunYinLable.frame.origin.y+hunYinLable.frame.size.height, VIEW_WIDTH, 50*BILI)];
    zhengZhiMianMaoLable.textColor = UIColorFromRGB(0x4A4A4A);
    zhengZhiMianMaoLable.font = [UIFont systemFontOfSize:18*BILI];
    zhengZhiMianMaoLable.text = [NSString stringWithFormat:@"政治面貌:  %@",[info objectForKey:@"political"]];
    [self.mainScrollView addSubview:zhengZhiMianMaoLable];
    
    UIView * zhengZhiMianMaLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50*BILI-1, VIEW_WIDTH-26*BILI, 1)];
    zhengZhiMianMaLineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [zhengZhiMianMaoLable addSubview:zhengZhiMianMaLineView];
    
    
    //////////////////////学历
    UILabel * xueLiLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, zhengZhiMianMaoLable.frame.origin.y+zhengZhiMianMaoLable.frame.size.height, VIEW_WIDTH, 50*BILI)];
    xueLiLable.textColor = UIColorFromRGB(0x4A4A4A);
    xueLiLable.font = [UIFont systemFontOfSize:18*BILI];
    xueLiLable.text = [NSString stringWithFormat:@"学历:  %@",[info objectForKey:@"education"]];
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
    
    
    //////////////////////职业
    UILabel * zhiYeLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, zongJiaoLable.frame.origin.y+zongJiaoLable.frame.size.height, VIEW_WIDTH, 50*BILI)];
    zhiYeLable.textColor = UIColorFromRGB(0x4A4A4A);
    zhiYeLable.font = [UIFont systemFontOfSize:18*BILI];
    zhiYeLable.text = [NSString stringWithFormat:@"职业:  %@",[info objectForKey:@"occupation"]];
    [self.mainScrollView addSubview:zhiYeLable];
    
    UIView * zhiYeLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50*BILI-1, VIEW_WIDTH-26*BILI, 1)];
    zhiYeLineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [zhiYeLable addSubview:zhiYeLineView];
    
    //////////////////////服务处所
    UILabel * fuWuChuSuoLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, zhiYeLable.frame.origin.y+zhiYeLable.frame.size.height, VIEW_WIDTH, 50*BILI)];
    fuWuChuSuoLable.textColor = UIColorFromRGB(0x4A4A4A);
    fuWuChuSuoLable.font = [UIFont systemFontOfSize:18*BILI];
    fuWuChuSuoLable.text = [NSString stringWithFormat:@"服务处所:  %@",[info objectForKey:@"workunit"]];
    [self.mainScrollView addSubview:fuWuChuSuoLable];
    
    UIView * fuWuChuSuoLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50*BILI-1, VIEW_WIDTH-26*BILI, 1)];
    fuWuChuSuoLineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [fuWuChuSuoLable addSubview:fuWuChuSuoLineView];
    
    //////////////////////现住地址
    UILabel * xianZhuDiZhiLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, fuWuChuSuoLable.frame.origin.y+fuWuChuSuoLable.frame.size.height, VIEW_WIDTH, 50*BILI)];
    xianZhuDiZhiLable.textColor = UIColorFromRGB(0x4A4A4A);
    xianZhuDiZhiLable.font = [UIFont systemFontOfSize:18*BILI];
    xianZhuDiZhiLable.text = [NSString stringWithFormat:@"现住地址:  %@",[info objectForKey:@"persentaddress"]];
    xianZhuDiZhiLable.adjustsFontSizeToFitWidth = YES;
    [self.mainScrollView addSubview:xianZhuDiZhiLable];
    
    UIView * xianZhuDiZhiLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50*BILI-1, VIEW_WIDTH-26*BILI, 1)];
    xianZhuDiZhiLineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [xianZhuDiZhiLable addSubview:xianZhuDiZhiLineView];
    
    //////////////////////备注
    UILabel * beiZhuLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, xianZhuDiZhiLable.frame.origin.y+xianZhuDiZhiLable.frame.size.height, VIEW_WIDTH, 50*BILI)];
    beiZhuLable.textColor = UIColorFromRGB(0x4A4A4A);
    beiZhuLable.font = [UIFont systemFontOfSize:18*BILI];
    beiZhuLable.text = [NSString stringWithFormat:@"备注:  %@",[info objectForKey:@"markinfo"]];
    [self.mainScrollView addSubview:beiZhuLable];
    
    UIView * beiZhuLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50*BILI-1, VIEW_WIDTH-26*BILI, 1)];
    beiZhuLineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [beiZhuLable addSubview:beiZhuLineView];
    
    //////////////////////家庭人数
    UILabel * renShuLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, beiZhuLable.frame.origin.y+beiZhuLable.frame.size.height, VIEW_WIDTH, 54*BILI)];
    renShuLable.textColor = UIColorFromRGB(0x4A4A4A);
    renShuLable.font = [UIFont systemFontOfSize:18*BILI];
    NSNumber * renShu = [info objectForKey:@"membernums"];
    renShuLable.text = [NSString stringWithFormat:@"家庭人数:  %d人",renShu.intValue];
    [self.mainScrollView addSubview:renShuLable];
    
    UIView * renShuLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 54*BILI-4*BILI, VIEW_WIDTH-26*BILI, 4*BILI)];
    renShuLineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [renShuLable addSubview:renShuLineView];
    
    NSArray * menberArray = [info objectForKey:@"housememberlist"];
    for (int i=0; i<menberArray.count; i++)
    {
        NSDictionary * info = [menberArray objectAtIndex:i];
        ///////////////////////姓名
        UILabel * nameLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, renShuLable.frame.origin.y+renShuLable.frame.size.height+(i*(12*50*BILI+4*BILI)), VIEW_WIDTH, 50*BILI)];
        nameLable.textColor = UIColorFromRGB(0x4A4A4A);
        nameLable.font = [UIFont systemFontOfSize:18*BILI];
        nameLable.text = [NSString stringWithFormat:@"姓名:  %@",[info objectForKey:@"realname"]];
        [self.mainScrollView addSubview:nameLable];
        
        //////////////////////性别
        UILabel * sexLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, nameLable.frame.origin.y+nameLable.frame.size.height, VIEW_WIDTH, 50*BILI)];
        sexLable.textColor = UIColorFromRGB(0x4A4A4A);
        sexLable.font = [UIFont systemFontOfSize:18*BILI];
        sexLable.text = [NSString stringWithFormat:@"姓别:  %@",[info objectForKey:@"sex"]];
        [self.mainScrollView addSubview:sexLable];
        
        //////////////////////户主关系
        UILabel * huZhuGuanXiLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, sexLable.frame.origin.y+sexLable.frame.size.height, VIEW_WIDTH, 50*BILI)];
        huZhuGuanXiLable.textColor = UIColorFromRGB(0x4A4A4A);
        huZhuGuanXiLable.font = [UIFont systemFontOfSize:18*BILI];
        huZhuGuanXiLable.text = [NSString stringWithFormat:@"户主关系:  %@",[info objectForKey:@"hzgx"]];
        [self.mainScrollView addSubview:huZhuGuanXiLable];
        
        /////////////////////////电话
        UILabel * telLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, huZhuGuanXiLable.frame.origin.y+huZhuGuanXiLable.frame.size.height, VIEW_WIDTH, 50*BILI)];
        telLable.textColor = UIColorFromRGB(0x4A4A4A);
        telLable.font = [UIFont systemFontOfSize:18*BILI];
        
        telLable.text = [NSString stringWithFormat:@"电话:  %@",[Common getobjectForKey:[info objectForKey:@"tel"]]];
        [self.mainScrollView addSubview:telLable];
        
        /////////////////////////身份证号
        UILabel * sfzLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, telLable.frame.origin.y+telLable.frame.size.height, VIEW_WIDTH, 50*BILI)];
        sfzLable.textColor = UIColorFromRGB(0x4A4A4A);
        sfzLable.font = [UIFont systemFontOfSize:18*BILI];
        sfzLable.text = [NSString stringWithFormat:@"身份证号:  %@",[info objectForKey:@"idcard"]];
        [self.mainScrollView addSubview:sfzLable];
        
        /////////////////////////出生日期
        UILabel * shengRiLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, sfzLable.frame.origin.y+sfzLable.frame.size.height, VIEW_WIDTH, 50*BILI)];
        shengRiLable.textColor = UIColorFromRGB(0x4A4A4A);
        shengRiLable.font = [UIFont systemFontOfSize:18*BILI];
        shengRiLable.text = [NSString stringWithFormat:@"出生日期:  %@",[info objectForKey:@"birthdate"]];
        [self.mainScrollView addSubview:shengRiLable];
        
        
        /////////////////////////婚姻状态
        UILabel * hunYinLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, shengRiLable.frame.origin.y+shengRiLable.frame.size.height, VIEW_WIDTH, 50*BILI)];
        hunYinLable.textColor = UIColorFromRGB(0x4A4A4A);
        hunYinLable.font = [UIFont systemFontOfSize:18*BILI];
        hunYinLable.text = [NSString stringWithFormat:@"婚姻状态:  %@",[info objectForKey:@"marital"]];
        [self.mainScrollView addSubview:hunYinLable];
        
        
        /////////////////////////学历
        UILabel * xueLiLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, hunYinLable.frame.origin.y+hunYinLable.frame.size.height, VIEW_WIDTH, 50*BILI)];
        xueLiLable.textColor = UIColorFromRGB(0x4A4A4A);
        xueLiLable.font = [UIFont systemFontOfSize:18*BILI];
        xueLiLable.text = [NSString stringWithFormat:@"学历:  %@",[info objectForKey:@"education"]];
        [self.mainScrollView addSubview:xueLiLable];
        
        /////////////////////////宗教信仰
        UILabel * zongJiaoLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, xueLiLable.frame.origin.y+xueLiLable.frame.size.height, VIEW_WIDTH, 50*BILI)];
        zongJiaoLable.textColor = UIColorFromRGB(0x4A4A4A);
        zongJiaoLable.font = [UIFont systemFontOfSize:18*BILI];
        zongJiaoLable.text = [NSString stringWithFormat:@"宗教信仰:  %@",[info objectForKey:@"faith"]];
        [self.mainScrollView addSubview:zongJiaoLable];
        
        /////////////////////////职业
        UILabel * zhiYeLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, zongJiaoLable.frame.origin.y+zongJiaoLable.frame.size.height, VIEW_WIDTH, 50*BILI)];
        zhiYeLable.textColor = UIColorFromRGB(0x4A4A4A);
        zhiYeLable.font = [UIFont systemFontOfSize:18*BILI];
        zhiYeLable.text = [NSString stringWithFormat:@"职业:  %@",[info objectForKey:@"occupation"]];
        [self.mainScrollView addSubview:zhiYeLable];
        
        /////////////////////////服务处所
        UILabel * fuWuChuSuoLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, zhiYeLable.frame.origin.y+zhiYeLable.frame.size.height, VIEW_WIDTH, 50*BILI)];
        fuWuChuSuoLable.textColor = UIColorFromRGB(0x4A4A4A);
        fuWuChuSuoLable.font = [UIFont systemFontOfSize:18*BILI];
        fuWuChuSuoLable.text = [NSString stringWithFormat:@"服务处所:  %@",[info objectForKey:@"workunit"]];
        [self.mainScrollView addSubview:fuWuChuSuoLable];
        
        /////////////////////////备注
        UILabel * beiZhuLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, fuWuChuSuoLable.frame.origin.y+fuWuChuSuoLable.frame.size.height, VIEW_WIDTH, 54*BILI)];
        beiZhuLable.textColor = UIColorFromRGB(0x4A4A4A);
        beiZhuLable.font = [UIFont systemFontOfSize:18*BILI];
        beiZhuLable.text = [NSString stringWithFormat:@"备注:  %@",[info objectForKey:@"markinfo"]];
        [self.mainScrollView addSubview:beiZhuLable];
        
        UIView * beiZhuLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 54*BILI-4*BILI, VIEW_WIDTH-26*BILI, 4*BILI)];
        beiZhuLineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
        [beiZhuLable addSubview:beiZhuLineView];
    }
    
    [self.mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH, renShuLable.frame.origin.y+renShuLable.frame.size.height+(menberArray.count*(12*50*BILI+4*BILI)))];
}
-(void)getMesError:(NSDictionary *)info
{
    [self hideNewLoadingView];
    [Common showToastView:[info objectForKey:@"message"] view:self.view];
}
-(void)ruHuButtonClick
{
    RuHuShangBaoViewController * vc = [[RuHuShangBaoViewController alloc] init];
    vc.info = self.info;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
