//
//  WangGeYuanHomeViewController.m
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/27.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "WangGeYuanHomeViewController.h"

@interface WangGeYuanHomeViewController ()

@end

@implementation WangGeYuanHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.titleLale.text = @"工作台";
    self.titleLale.textColor = [UIColor whiteColor];
    
    
    
    self.backImageView.frame = CGRectMake(self.backImageView.frame.origin.x, (self.navView.frame.size.height-18*BILIY)/2,  18*59/65*BILI, 18*BILIY);
    self.backImageView.image = [UIImage imageNamed:@"xiaoxi_lingDang"];
    
    UIButton * rightButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-50*BILI, 0, 50*BILI, self.navView.frame.size.height)];
    [rightButton addTarget:self action:@selector(bangZhuButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setTitle:@"帮助" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:16*BILI];
    [self.navView addSubview:rightButton];
    
    [self initContentView];
    
    
}
-(void)initContentView
{
    float buttonWidth = (VIEW_WIDTH-26*BILI-7*BILI)/2;
    
    float buttonHeight = (VIEW_HEIGHT-(self.navView.frame.origin.y+self.navView.frame.size.height+SafeAreaBottomHeight+13*5*BILI))/4;
    for (int i=0; i<8; i++)
    {
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(13*BILI+(buttonWidth+7*BILI)*(i%2), self.navView.frame.origin.y+self.navView.frame.size.height+13*BILIY+(buttonHeight+13*BILIY)*(i/2), buttonWidth, buttonHeight)];
        button.tag = i;
        button.layer.cornerRadius = 8*BILI;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
        UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(12*BILI, 10*BILI, 200, 18*BILI)];
        titleLable.textColor = [UIColor whiteColor];
        titleLable.font = [UIFont systemFontOfSize:18*BILI];
        [button addSubview:titleLable];
        
        UIImageView * tipImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        [button addSubview:tipImageView];
        if (i==0)
        {
            titleLable.text = @"入户";
            tipImageView.frame = CGRectMake(button.frame.size.width-40*BILI-15*BILI, button.frame.size.height-40*BILI-13*BILI, 40*BILI, 40*BILI);
            tipImageView.image = [UIImage imageNamed:@"ruHu"];
            button.backgroundColor =UIColorFromRGB(0x1ADB9F);
        }
        else if (i==1)
        {
            titleLable.text = @"宣传";
            button.backgroundColor = UIColorFromRGB(0x5BBD63);
            tipImageView.frame = CGRectMake(button.frame.size.width-40*BILI-15*BILI, button.frame.size.height-40*BILI*132/116-13*BILI, 40*BILI, 40*BILI*132/116);
            tipImageView.image = [UIImage imageNamed:@"guanKongTaiZhang"];
        }
        else if (i==2)
        {
            titleLable.text = @"巡查";
            button.backgroundColor = UIColorFromRGB(0x64E4D7);
            tipImageView.frame = CGRectMake(button.frame.size.width-40*BILI-15*BILI, button.frame.size.height-40*BILI*83/99-13*BILI, 40*BILI, 40*BILI*83/99);
            tipImageView.image = [UIImage imageNamed:@"yiBanChangSuoTaiZhang"];
        }
        else if (i==3)
        {
            titleLable.text = @"管控";
            button.backgroundColor = UIColorFromRGB(0x788BF3);
            tipImageView.frame = CGRectMake(button.frame.size.width-40*BILI-15*BILI, button.frame.size.height-40*BILI*132/119-13*BILI, 40*BILI, 40*BILI*132/119);
            tipImageView.image = [UIImage imageNamed:@"guanKong"];
        }
        else if (i==4)
        {
            titleLable.text = @"处置";
            button.backgroundColor = UIColorFromRGB(0xFBA1B9);
            tipImageView.frame = CGRectMake(button.frame.size.width-40*BILI-15*BILI, button.frame.size.height-40*BILI*132/119-13*BILI, 40*BILI, 40*BILI*132/119);
            tipImageView.image = [UIImage imageNamed:@"guanKong"];
        }
        else if (i==5)
        {
            titleLable.text = @"报告";
            button.backgroundColor = UIColorFromRGB(0xFDA192);
            tipImageView.frame = CGRectMake(button.frame.size.width-40*BILI-15*BILI, button.frame.size.height-40*BILI*132/119-13*BILI, 40*BILI, 40*BILI*132/119);
            tipImageView.image = [UIImage imageNamed:@"guanKong"];
        }
        else if (i==6)
        {
            titleLable.text = @"事件跟踪";
            button.backgroundColor = UIColorFromRGB(0x586DDF);
            tipImageView.frame = CGRectMake(button.frame.size.width-40*BILI-15*BILI, button.frame.size.height-40*BILI*132/119-13*BILI, 40*BILI, 40*BILI*132/119);
            tipImageView.image = [UIImage imageNamed:@"guanKong"];
        }
        else if (i==7)
        {
            titleLable.text = @"任务处理";
            button.backgroundColor = UIColorFromRGB(0xFFD43E);
            tipImageView.frame = CGRectMake(button.frame.size.width-40*BILI-15*BILI, button.frame.size.height-40*BILI*132/116-13*BILI, 40*BILI, 40*BILI*132/116);
            tipImageView.image = [UIImage imageNamed:@"guanKongTaiZhang"];
        }
        
        
        
        
    }
    
   
}
-(void)buttonClick:(id)sender
{
    UIButton * button = (UIButton *)sender;
    if (button.tag==0) {
        
        HuZhuMessageListViewController * vc = [[HuZhuMessageListViewController alloc] init];
        vc.type = @"户主信息";
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    else if (button.tag==1)
    {
        XuanChuanViewController * vc = [[XuanChuanViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (button.tag==2)
    {
        [self initZouFangView];
    }
    else if (button.tag==3)
    {
        ZhongDianRenYuanChaXunListViewController * vc = [[ZhongDianRenYuanChaXunListViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (button.tag==4)
    {
        ChuZhiDetailViewController * vc = [[ChuZhiDetailViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (button.tag==5)
    {
        BaoGaoShenYueViewController * vc = [[BaoGaoShenYueViewController alloc] init];
        vc.titleStr = @"报告列表";
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    else if (button.tag==6)
    {
        ShiJianGenZongListViewController * vc = [[ShiJianGenZongListViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (button.tag==7)
    {
        RenWuChuLiListViewController * vc = [[RenWuChuLiListViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
 
}
-(void)initZouFangView
{
    self.zouFangBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
    self.zouFangBottomView.alpha = 0.5;
    self.zouFangBottomView.backgroundColor = [UIColor blackColor];
    [[UIApplication sharedApplication].keyWindow addSubview:self.zouFangBottomView];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zouFangBottomViewTap)];
    [self.zouFangBottomView addGestureRecognizer:tap];
    
    self.zouFangImageView = [[UIImageView alloc] initWithFrame:CGRectMake(30*BILI, (VIEW_HEIGHT-(VIEW_WIDTH-60*BILI)*498/464)/2,VIEW_WIDTH-60*BILI, (VIEW_WIDTH-60*BILI)*498/464)];
    self.zouFangImageView.image = [UIImage imageNamed:@"chanSuoTip"];
    self.zouFangImageView.userInteractionEnabled = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:self.zouFangImageView];
    
    UIButton * zhongDianChangSuoButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.zouFangImageView.frame.size.height-176*BILI/2-40*BILI-10*BILI, self.zouFangImageView.frame.size.width, 40*BILI)];
    zhongDianChangSuoButton.backgroundColor = [UIColor clearColor];
    [zhongDianChangSuoButton addTarget:self action:@selector(zhognDianChangSuoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.zouFangImageView addSubview:zhongDianChangSuoButton];
    
    UIButton * yiBanChangSuoButton = [[UIButton alloc] initWithFrame:CGRectMake(0, zhongDianChangSuoButton.frame.origin.y+40*BILI+18*BILI, self.zouFangImageView.frame.size.width, 40*BILI)];
    yiBanChangSuoButton.backgroundColor = [UIColor clearColor];
    [yiBanChangSuoButton addTarget:self action:@selector(yiBanChangSuoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.zouFangImageView addSubview:yiBanChangSuoButton];
    
    
}
-(void)zhognDianChangSuoButtonClick
{
    [self zouFangBottomViewTap];
    ZhongDianChangSuoListViewController * vc = [[ZhongDianChangSuoListViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)yiBanChangSuoButtonClick
{
    [self zouFangBottomViewTap];
    YiBAnChangSuoViewController * vc = [[YiBAnChangSuoViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)zouFangBottomViewTap
{
    [self.zouFangBottomView removeFromSuperview];
    [self.zouFangImageView removeFromSuperview];
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
