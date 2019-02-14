//
//  SJTabBarController.m
//  SajiaoShopping
//
//  Created by 鸣 王 on 15/10/10.
//  Copyright © 2015年 唐蒙波. All rights reserved.
//

#import "SJTabBarController.h"
#import "ConstDefine.h"


@interface SJTabBarController ()

@end

@implementation SJTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    for(UIView *view in self.view.subviews){
        
        if([view isKindOfClass:[UITabBar class]]){
            
            view.hidden = YES;
            
            break;
            
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)initTabBar:(int)type
{
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, VIEW_HEIGHT-(SafeAreaBottomHeight),VIEW_WIDTH ,SafeAreaBottomHeight)];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bottomView];
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 0.5)];
    lineView.backgroundColor = UIColorFromRGB(0xd9d9e3);
    [self.bottomView addSubview: lineView];
    
    
    if (type==1) {
        
        self.button1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH/4, (130*USERCC))];
        self.button1.tag = 0;
        [self.button1 addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomView addSubview:self.button1];
        
        
        self.homeImageView1 = [[UIImageView alloc] initWithFrame:CGRectMake((self.button1.frame.size.width-24)/2, 8, 24, 24)];
        self.homeImageView1.image = [UIImage imageNamed:@"tabbar_platform_n"];
        [self.button1 addSubview:self.homeImageView1];
        
        self.homeLable1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 8+24+3, self.button1.frame.size.width, 9)] ;
        self.homeLable1.font = [UIFont systemFontOfSize:9];
        self.homeLable1.textAlignment = NSTextAlignmentCenter;
        self.homeLable1.text = @"工作台";
        self.homeLable1.textColor = [UIColor blackColor];
        [self.button1 addSubview:self.homeLable1];
        
        
        self.homeImageView2 = [[UIImageView alloc] initWithFrame:self.homeImageView1.frame];
        self.homeImageView2.image = [UIImage imageNamed:@"tabbar_platform_h"];
        [self.button1 addSubview:self.homeImageView2];
        
        self.homeLable2 = [[UILabel alloc] initWithFrame:self.homeLable1.frame];
        self.homeLable2.font = [UIFont systemFontOfSize:9];
        self.homeLable2.textAlignment = NSTextAlignmentCenter;
        self.homeLable2.text = @"工作台";
        self.homeLable2.textColor = UIColorFromRGB(0xFE9052);
        [self.button1 addSubview:self.homeLable2];
        
        
        
        self.button2 = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH/4, 0, VIEW_WIDTH/5, (130*USERCC))];
        self.button2.tag = 1;
        [self.button2 addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomView addSubview:self.button2];
        
        self.noticeImageView1 = [[UIImageView alloc] initWithFrame:self.homeImageView1.frame];
        self.noticeImageView1.image = [UIImage imageNamed:@"tabbar_netWorking_n"];
        [self.button2 addSubview:self.noticeImageView1];
        
        self.noticeLable1 = [[UILabel alloc] initWithFrame:self.homeLable1.frame] ;
        self.noticeLable1.font = [UIFont systemFontOfSize:9];
        self.noticeLable1.textAlignment = NSTextAlignmentCenter;
        self.noticeLable1.text = @"工作台账";
        self.noticeLable1.textColor = [UIColor blackColor];
        [self.button2 addSubview:self.noticeLable1];
        
        
        self.noticeImageView2 = [[UIImageView alloc] initWithFrame:self.homeImageView1.frame];
        self.noticeImageView2.image = [UIImage imageNamed:@"tabbar_netWorking_h"];
        [self.button2 addSubview:self.noticeImageView2];
        
        self.noticeLable2 = [[UILabel alloc] initWithFrame:self.homeLable1.frame] ;
        self.noticeLable2.font = [UIFont systemFontOfSize:9];
        self.noticeLable2.textAlignment = NSTextAlignmentCenter;
        self.noticeLable2.text = @"工作台账";
        self.noticeLable2.textColor = UIColorFromRGB(0xFE9052);
        [self.button2 addSubview:self.noticeLable2];
        
        
        
        
        self.button3 = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH/4*2, 0, VIEW_WIDTH/5, (130*USERCC))];
        self.button3.tag = 2;
        [self.button3 addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomView addSubview:self.button3];
        
        
        self.centerImageView1 = [[UIImageView alloc] initWithFrame:self.homeImageView1.frame];
        self.centerImageView1.image = [UIImage imageNamed:@"tabbar_baoLiao_n"];
        [self.button3 addSubview:self.centerImageView1];
        
        self.centerImageView2 = [[UIImageView alloc] initWithFrame:self.homeImageView1.frame];
        self.centerImageView2.image = [UIImage imageNamed:@"tabbar_baoLiao_h"];
        [self.button3 addSubview:self.centerImageView2];
        
        self.centerLable1 = [[UILabel alloc] initWithFrame:self.homeLable1.frame] ;
        self.centerLable1.font =[UIFont systemFontOfSize:9];
        self.centerLable1.textAlignment = NSTextAlignmentCenter;
        self.centerLable1.text = @"爆料";
        self.centerLable1.textColor = [UIColor blackColor];
        [self.button3 addSubview:self.centerLable1];
        
        self.centerLable2 = [[UILabel alloc] initWithFrame:self.homeLable1.frame] ;
        self.centerLable2.font = [UIFont systemFontOfSize:9];
        self.centerLable2.textAlignment = NSTextAlignmentCenter;
        self.centerLable2.text = @"爆料";
        self.centerLable2.textColor = UIColorFromRGB(0xFE9052);
        [self.button3 addSubview:self.centerLable2];
        
        
        
        self.button4 = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH/4*3, 0, VIEW_WIDTH/5, (130*USERCC))];
        self.button4.tag = 3;
        [self.button4 addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomView addSubview:self.button4];
        
        self.chatterImageView1 = [[UIImageView alloc] initWithFrame:self.homeImageView1.frame];
        self.chatterImageView1.image = [UIImage imageNamed:@"tabbar_owner_n"];
        [self.button4 addSubview:self.chatterImageView1];
        
        self.chatterLable1 = [[UILabel alloc] initWithFrame:self.homeLable1.frame] ;
        self.chatterLable1.font =[UIFont systemFontOfSize:9];
        self.chatterLable1.textAlignment = NSTextAlignmentCenter;
        self.chatterLable1.text = @"我的";
        self.chatterLable1.textColor = [UIColor blackColor];
        [self.button4 addSubview:self.chatterLable1];
        
        
        self.chatterImageView2 = [[UIImageView alloc] initWithFrame:self.homeImageView1.frame];
        self.chatterImageView2.image = [UIImage imageNamed:@"tabbar_owner_h"];
        [self.button4 addSubview:self.chatterImageView2];
        
        self.chatterLable2 = [[UILabel alloc] initWithFrame:self.homeLable1.frame] ;
        self.chatterLable2.font = [UIFont systemFontOfSize:9];
        self.chatterLable2.textAlignment = NSTextAlignmentCenter;
        self.chatterLable2.text = @"我的";
        self.chatterLable2.textColor = UIColorFromRGB(0xFE9052);
        [self.button4 addSubview:self.chatterLable2];
        
        self.unReadMesLable = [[UILabel alloc] initWithFrame:CGRectMake(self.button2.frame.size.width-34*BILI, 4*BILI, 20*BILI, 15*BILI)];
        self.unReadMesLable.textColor = [UIColor whiteColor];
        self.unReadMesLable.font = [UIFont systemFontOfSize:10*BILI];
        self.unReadMesLable.textAlignment = NSTextAlignmentCenter;
        self.unReadMesLable.layer.cornerRadius = 15*BILI/2;
        self.unReadMesLable.layer.masksToBounds = YES;
        self.unReadMesLable.hidden = YES;
        self.unReadMesLable.backgroundColor = [UIColor redColor];
        [self.button4 addSubview:self.unReadMesLable];
        
        
        
        
        UIView * topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 1)];
        topLineView.backgroundColor = [UIColor blackColor];
        topLineView.alpha = 0.05;
        [self.bottomView addSubview:topLineView];
        
        self.homeLable1.hidden = YES;
        self.homeImageView1.hidden = YES;
        self.homeLable2.hidden = NO;
        self.homeImageView2.hidden = NO;
        
        self.noticeLable1.hidden = NO;
        self.noticeImageView1.hidden = NO;
        self.noticeLable2.hidden = YES;
        self.noticeImageView2.hidden = YES;
        
        self.centerLable1.hidden = NO;
        self.centerImageView1.hidden = NO;
        self.centerLable2.hidden = YES;
        self.centerImageView2.hidden = YES;
        
        self.chatterLable1.hidden = NO;
        self.chatterImageView1.hidden = NO;
        self.chatterLable2.hidden = YES;
        self.chatterImageView2.hidden = YES;
        
    }
    
    if (type==2) {
        
        self.button1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH/3, (130*USERCC))];
        self.button1.tag = 0;
        [self.button1 addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomView addSubview:self.button1];
        
        
        self.homeImageView1 = [[UIImageView alloc] initWithFrame:CGRectMake((self.button1.frame.size.width-24)/2, 8, 24, 24)];
        self.homeImageView1.image = [UIImage imageNamed:@"tabbar_platform_n"];
        [self.button1 addSubview:self.homeImageView1];
        
        self.homeLable1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 8+24+3, self.button1.frame.size.width, 9)] ;
        self.homeLable1.font = [UIFont systemFontOfSize:9];
        self.homeLable1.textAlignment = NSTextAlignmentCenter;
        self.homeLable1.text = @"工作台";
        self.homeLable1.textColor = [UIColor blackColor];
        [self.button1 addSubview:self.homeLable1];
        
        
        self.homeImageView2 = [[UIImageView alloc] initWithFrame:self.homeImageView1.frame];
        self.homeImageView2.image = [UIImage imageNamed:@"tabbar_platform_h"];
        [self.button1 addSubview:self.homeImageView2];
        
        self.homeLable2 = [[UILabel alloc] initWithFrame:self.homeLable1.frame];
        self.homeLable2.font = [UIFont systemFontOfSize:9];
        self.homeLable2.textAlignment = NSTextAlignmentCenter;
        self.homeLable2.text = @"工作台";
        self.homeLable2.textColor = UIColorFromRGB(0xFE9052);
        [self.button1 addSubview:self.homeLable2];
        
        
        
        self.button2 = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH/3, 0, VIEW_WIDTH/5, (130*USERCC))];
        self.button2.tag = 1;
        [self.button2 addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomView addSubview:self.button2];
        
        self.noticeImageView1 = [[UIImageView alloc] initWithFrame:self.homeImageView1.frame];
        self.noticeImageView1.image = [UIImage imageNamed:@"tabbar_netWorking_n"];
        [self.button2 addSubview:self.noticeImageView1];
        
        self.noticeLable1 = [[UILabel alloc] initWithFrame:self.homeLable1.frame] ;
        self.noticeLable1.font = [UIFont systemFontOfSize:9];
        self.noticeLable1.textAlignment = NSTextAlignmentCenter;
        self.noticeLable1.text = @"工作台账";
        self.noticeLable1.textColor = [UIColor blackColor];
        [self.button2 addSubview:self.noticeLable1];
        
        
        self.noticeImageView2 = [[UIImageView alloc] initWithFrame:self.homeImageView1.frame];
        self.noticeImageView2.image = [UIImage imageNamed:@"tabbar_netWorking_h"];
        [self.button2 addSubview:self.noticeImageView2];
        
        self.noticeLable2 = [[UILabel alloc] initWithFrame:self.homeLable1.frame] ;
        self.noticeLable2.font = [UIFont systemFontOfSize:9];
        self.noticeLable2.textAlignment = NSTextAlignmentCenter;
        self.noticeLable2.text = @"工作台账";
        self.noticeLable2.textColor = UIColorFromRGB(0xFE9052);
        [self.button2 addSubview:self.noticeLable2];
        
        
        
        
        self.button3 = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH/3*2, 0, VIEW_WIDTH/5, (130*USERCC))];
        self.button3.tag = 2;
        [self.button3 addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomView addSubview:self.button3];
        
        
        self.centerImageView1 = [[UIImageView alloc] initWithFrame:self.homeImageView1.frame];
        self.centerImageView1.image = [UIImage imageNamed:@"tabbar_owner_n"];
        [self.button3 addSubview:self.centerImageView1];
        
        self.centerImageView2 = [[UIImageView alloc] initWithFrame:self.homeImageView1.frame];
        self.centerImageView2.image = [UIImage imageNamed:@"tabbar_owner_h"];
        [self.button3 addSubview:self.centerImageView2];
        
        self.centerLable1 = [[UILabel alloc] initWithFrame:self.homeLable1.frame] ;
        self.centerLable1.font =[UIFont systemFontOfSize:9];
        self.centerLable1.textAlignment = NSTextAlignmentCenter;
        self.centerLable1.text = @"我的";
        self.centerLable1.textColor = [UIColor blackColor];
        [self.button3 addSubview:self.centerLable1];
        
        self.centerLable2 = [[UILabel alloc] initWithFrame:self.homeLable1.frame] ;
        self.centerLable2.font = [UIFont systemFontOfSize:9];
        self.centerLable2.textAlignment = NSTextAlignmentCenter;
        self.centerLable2.text = @"我的";
        self.centerLable2.textColor = UIColorFromRGB(0xFE9052);
        [self.button3 addSubview:self.centerLable2];
         
        
        
//
//        self.button4 = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH/3*2, 0, VIEW_WIDTH/5, (130*USERCC))];
//        self.button4.tag = 2;
//        [self.button4 addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
//        [self.bottomView addSubview:self.button4];
//
//        self.chatterImageView1 = [[UIImageView alloc] initWithFrame:self.homeImageView1.frame];
//        self.chatterImageView1.image = [UIImage imageNamed:@"tabbar_owner_n"];
//        [self.button4 addSubview:self.chatterImageView1];
//
//        self.chatterLable1 = [[UILabel alloc] initWithFrame:self.homeLable1.frame] ;
//        self.chatterLable1.font =[UIFont systemFontOfSize:9];
//        self.chatterLable1.textAlignment = NSTextAlignmentCenter;
//        self.chatterLable1.text = @"我的";
//        self.chatterLable1.textColor = [UIColor blackColor];
//        [self.button4 addSubview:self.chatterLable1];
//
//
//        self.chatterImageView2 = [[UIImageView alloc] initWithFrame:self.homeImageView1.frame];
//        self.chatterImageView2.image = [UIImage imageNamed:@"tabbar_owner_h"];
//        [self.button4 addSubview:self.chatterImageView2];
//
//        self.chatterLable2 = [[UILabel alloc] initWithFrame:self.homeLable1.frame] ;
//        self.chatterLable2.font = [UIFont systemFontOfSize:9];
//        self.chatterLable2.textAlignment = NSTextAlignmentCenter;
//        self.chatterLable2.text = @"我的";
//        self.chatterLable2.textColor = UIColorFromRGB(0xFE9052);
//        [self.button4 addSubview:self.chatterLable2];
        
        self.unReadMesLable = [[UILabel alloc] initWithFrame:CGRectMake(self.button2.frame.size.width-34*BILI, 4*BILI, 20*BILI, 15*BILI)];
        self.unReadMesLable.textColor = [UIColor whiteColor];
        self.unReadMesLable.font = [UIFont systemFontOfSize:10*BILI];
        self.unReadMesLable.textAlignment = NSTextAlignmentCenter;
        self.unReadMesLable.layer.cornerRadius = 15*BILI/2;
        self.unReadMesLable.layer.masksToBounds = YES;
        self.unReadMesLable.hidden = YES;
        self.unReadMesLable.backgroundColor = [UIColor redColor];
        [self.button4 addSubview:self.unReadMesLable];
        
        
        
        
        UIView * topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 1)];
        topLineView.backgroundColor = [UIColor blackColor];
        topLineView.alpha = 0.05;
        [self.bottomView addSubview:topLineView];
        
        self.homeLable1.hidden = YES;
        self.homeImageView1.hidden = YES;
        self.homeLable2.hidden = NO;
        self.homeImageView2.hidden = NO;
        
        self.noticeLable1.hidden = NO;
        self.noticeImageView1.hidden = NO;
        self.noticeLable2.hidden = YES;
        self.noticeImageView2.hidden = YES;
        
        self.centerLable1.hidden = NO;
        self.centerImageView1.hidden = NO;
        self.centerLable2.hidden = YES;
        self.centerImageView2.hidden = YES;
        
        self.chatterLable1.hidden = NO;
        self.chatterImageView1.hidden = NO;
        self.chatterLable2.hidden = YES;
        self.chatterImageView2.hidden = YES;
        
    }
    
    if (type==3) {
        
        self.button1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH/3, (130*USERCC))];
        self.button1.tag = 0;
        [self.button1 addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomView addSubview:self.button1];
        
        
        self.homeImageView1 = [[UIImageView alloc] initWithFrame:CGRectMake((self.button1.frame.size.width-24)/2, 8, 24, 24)];
        self.homeImageView1.image = [UIImage imageNamed:@"btn_home_n"];
        [self.button1 addSubview:self.homeImageView1];
        
        self.homeLable1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 8+24+3, self.button1.frame.size.width, 9)] ;
        self.homeLable1.font = [UIFont systemFontOfSize:9];
        self.homeLable1.textAlignment = NSTextAlignmentCenter;
        self.homeLable1.text = @"视频聊天";
        self.homeLable1.textColor = [UIColor blackColor];
        [self.button1 addSubview:self.homeLable1];
        
        
        self.homeImageView2 = [[UIImageView alloc] initWithFrame:self.homeImageView1.frame];
        self.homeImageView2.image = [UIImage imageNamed:@"btn_home_h"];
        [self.button1 addSubview:self.homeImageView2];
        
        self.homeLable2 = [[UILabel alloc] initWithFrame:self.homeLable1.frame];
        self.homeLable2.font = [UIFont systemFontOfSize:9];
        self.homeLable2.textAlignment = NSTextAlignmentCenter;
        self.homeLable2.text = @"视频聊天";
        self.homeLable2.textColor = [UIColor redColor];
        [self.button1 addSubview:self.homeLable2];
        
        
        
        self.button2 = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH/3, 0, VIEW_WIDTH/5, (130*USERCC))];
        self.button2.tag = 1;
        [self.button2 addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomView addSubview:self.button2];
        
        self.noticeImageView1 = [[UIImageView alloc] initWithFrame:self.homeImageView1.frame];
        self.noticeImageView1.image = [UIImage imageNamed:@"spx_btn_my_n"];
        [self.button2 addSubview:self.noticeImageView1];
        
        self.noticeLable1 = [[UILabel alloc] initWithFrame:self.homeLable1.frame] ;
        self.noticeLable1.font = [UIFont systemFontOfSize:9];
        self.noticeLable1.textAlignment = NSTextAlignmentCenter;
        self.noticeLable1.text = @"发现";
        self.noticeLable1.textColor = [UIColor blackColor];
        [self.button2 addSubview:self.noticeLable1];
        
        
        self.noticeImageView2 = [[UIImageView alloc] initWithFrame:self.homeImageView1.frame];
        self.noticeImageView2.image = [UIImage imageNamed:@"spx_btn_my_h"];
        [self.button2 addSubview:self.noticeImageView2];
        
        self.noticeLable2 = [[UILabel alloc] initWithFrame:self.homeLable1.frame] ;
        self.noticeLable2.font = [UIFont systemFontOfSize:9];
        self.noticeLable2.textAlignment = NSTextAlignmentCenter;
        self.noticeLable2.text = @"发现";
        self.noticeLable2.textColor = [UIColor redColor];
        [self.button2 addSubview:self.noticeLable2];
        
        
        
        
        self.button3 = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH/3*2, 0, VIEW_WIDTH/5, (130*USERCC))];
        self.button3.tag = 2;
        [self.button3 addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomView addSubview:self.button3];
        
        
        self.centerImageView1 = [[UIImageView alloc] initWithFrame:CGRectMake((self.button3.frame.size.width-39)/2,1*BILI , 39, 39)];
        self.centerImageView1.image = [UIImage imageNamed:@"btn_paihang_n"];
        [self.button3 addSubview:self.centerImageView1];
        
        self.centerImageView2 = [[UIImageView alloc] initWithFrame:CGRectMake((self.button3.frame.size.width-39)/2,1*BILI , 39, 39)];
        self.centerImageView2.image = [UIImage imageNamed:@"btn_paihang_h"];
        [self.button3 addSubview:self.centerImageView2];
        
        self.centerLable1 = [[UILabel alloc] initWithFrame:self.homeLable1.frame] ;
        self.centerLable1.font =[UIFont systemFontOfSize:9];
        self.centerLable1.textAlignment = NSTextAlignmentCenter;
        self.centerLable1.text = @"排行榜";
        self.centerLable1.textColor = [UIColor blackColor];
        [self.button3 addSubview:self.centerLable1];
        
        self.centerLable2 = [[UILabel alloc] initWithFrame:self.homeLable1.frame] ;
        self.centerLable2.font = [UIFont systemFontOfSize:9];
        self.centerLable2.textAlignment = NSTextAlignmentCenter;
        self.centerLable2.text = @"排行榜";
        self.centerLable2.textColor = [UIColor redColor];
        [self.button3 addSubview:self.centerLable2];
        
        UIView * topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 1)];
        topLineView.backgroundColor = [UIColor blackColor];
        topLineView.alpha = 0.05;
        [self.bottomView addSubview:topLineView];
        
        self.homeLable1.hidden = YES;
        self.homeImageView1.hidden = YES;
        self.homeLable2.hidden = NO;
        self.homeImageView2.hidden = NO;
        
        self.noticeLable1.hidden = NO;
        self.noticeImageView1.hidden = NO;
        self.noticeLable2.hidden = YES;
        self.noticeImageView2.hidden = YES;
        
        self.centerLable1.hidden = NO;
        self.centerImageView1.hidden = NO;
        self.centerLable2.hidden = YES;
        self.centerImageView2.hidden = YES;
        
        self.chatterLable1.hidden = NO;
        self.chatterImageView1.hidden = NO;
        self.chatterLable2.hidden = YES;
        self.chatterImageView2.hidden = YES;
        
    }
    

   
}
-(void)selectButton:(id)sender
{
    

    UIButton * button = (UIButton *)sender;
    if (button.tag ==0)
    {
        self.selectedIndex = 0;
        
        self.homeLable1.hidden = YES;
        self.homeImageView1.hidden = YES;
        self.homeLable2.hidden = NO;
        self.homeImageView2.hidden = NO;
        
        self.noticeLable1.hidden = NO;
        self.noticeImageView1.hidden = NO;
        self.noticeLable2.hidden = YES;
        self.noticeImageView2.hidden = YES;
        
        self.centerLable1.hidden = NO;
        self.centerImageView1.hidden = NO;
        self.centerLable2.hidden = YES;
        self.centerImageView2.hidden = YES;
        
        self.chatterLable1.hidden = NO;
        self.chatterImageView1.hidden = NO;
        self.chatterLable2.hidden = YES;
        self.chatterImageView2.hidden = YES;
        
        self.ownerLable1.hidden = NO;
        self.ownerImageView1.hidden = NO;
        self.ownerLable2.hidden = YES;
        self.ownerImageView2.hidden = YES;
       
    }
    else if (button.tag ==1)
    {
        
        self.selectedIndex = 1;
       
        self.homeLable1.hidden = NO;
        self.homeImageView1.hidden = NO;
        self.homeLable2.hidden = YES;
        self.homeImageView2.hidden = YES;
        
        self.noticeLable1.hidden = YES;
        self.noticeImageView1.hidden = YES;
        self.noticeLable2.hidden = NO;
        self.noticeImageView2.hidden = NO;
        
        self.centerLable1.hidden = NO;
        self.centerImageView1.hidden = NO;
        self.centerLable2.hidden = YES;
        self.centerImageView2.hidden = YES;
        
        self.chatterLable1.hidden = NO;
        self.chatterImageView1.hidden = NO;
        self.chatterLable2.hidden = YES;
        self.chatterImageView2.hidden = YES;
        
        self.ownerLable1.hidden = NO;
        self.ownerImageView1.hidden = NO;
        self.ownerLable2.hidden = YES;
        self.ownerImageView2.hidden = YES;
       
        
    }
    else if (button.tag ==2)
    {
        
        self.selectedIndex = 2;
        
        
        self.homeLable1.hidden = NO;
        self.homeImageView1.hidden = NO;
        self.homeLable2.hidden = YES;
        self.homeImageView2.hidden = YES;
        
        self.noticeLable1.hidden = NO;
        self.noticeImageView1.hidden = NO;
        self.noticeLable2.hidden = YES;
        self.noticeImageView2.hidden = YES;
        
        self.centerLable1.hidden = YES;
        self.centerImageView1.hidden = YES;
        self.centerLable2.hidden = NO;
        self.centerImageView2.hidden = NO;
        
        self.chatterLable1.hidden = NO;
        self.chatterImageView1.hidden = NO;
        self.chatterLable2.hidden = YES;
        self.chatterImageView2.hidden = YES;
        
        self.ownerLable1.hidden = NO;
        self.ownerImageView1.hidden = NO;
        self.ownerLable2.hidden = YES;
        self.ownerImageView2.hidden = YES;
       
    }
    else if (button.tag ==3)
    {
    self.selectedIndex = 3;
        self.homeLable1.hidden = NO;
        self.homeImageView1.hidden = NO;
        self.homeLable2.hidden = YES;
        self.homeImageView2.hidden = YES;
        
        self.noticeLable1.hidden = NO;
        self.noticeImageView1.hidden = NO;
        self.noticeLable2.hidden = YES;
        self.noticeImageView2.hidden = YES;
        
        self.centerLable1.hidden = NO;
        self.centerImageView1.hidden = NO;
        self.centerLable2.hidden = YES;
        self.centerImageView2.hidden = YES;
        
        self.chatterLable1.hidden = YES;
        self.chatterImageView1.hidden = YES;
        self.chatterLable2.hidden = NO;
        self.chatterImageView2.hidden = NO;
        
        self.ownerLable1.hidden = NO;
        self.ownerImageView1.hidden = NO;
        self.ownerLable2.hidden = YES;
        self.ownerImageView2.hidden = YES;
    }
    else if (button.tag ==4)
    {
        self.selectedIndex = 4;
        self.homeLable1.hidden = NO;
        self.homeImageView1.hidden = NO;
        self.homeLable2.hidden = YES;
        self.homeImageView2.hidden = YES;
        
        self.noticeLable1.hidden = NO;
        self.noticeImageView1.hidden = NO;
        self.noticeLable2.hidden = YES;
        self.noticeImageView2.hidden = YES;
        
        self.centerLable1.hidden = NO;
        self.centerImageView1.hidden = NO;
        self.centerLable2.hidden = YES;
        self.centerImageView2.hidden = YES;
        
        self.chatterLable1.hidden = NO;
        self.chatterImageView1.hidden = NO;
        self.chatterLable2.hidden = YES;
        self.chatterImageView2.hidden = YES;
        
        self.ownerLable1.hidden = YES;
        self.ownerImageView1.hidden = YES;
        self.ownerLable2.hidden = NO;
        self.ownerImageView2.hidden = NO;
    }
}

-(void)setItemSelected:(int)index
{
    
    

        if (index ==0)
        {
            self.selectedIndex = 0;
            
            self.homeLable1.hidden = YES;
            self.homeImageView1.hidden = YES;
            self.homeLable2.hidden = NO;
            self.homeImageView2.hidden = NO;
            
            self.noticeLable1.hidden = NO;
            self.noticeImageView1.hidden = NO;
            self.noticeLable2.hidden = YES;
            self.noticeImageView2.hidden = YES;
            
            self.centerLable1.hidden = NO;
            self.centerImageView1.hidden = NO;
            self.centerLable2.hidden = YES;
            self.centerImageView2.hidden = YES;
            
            self.chatterLable1.hidden = NO;
            self.chatterImageView1.hidden = NO;
            self.chatterLable2.hidden = YES;
            self.chatterImageView2.hidden = YES;
            
            self.ownerLable1.hidden = NO;
            self.ownerImageView1.hidden = NO;
            self.ownerLable2.hidden = YES;
            self.ownerImageView2.hidden = YES;
            
            
        }
        else if (index ==1)
        {
            
            self.selectedIndex = 1;
            
            self.homeLable1.hidden = NO;
            self.homeImageView1.hidden = NO;
            self.homeLable2.hidden = YES;
            self.homeImageView2.hidden = YES;
            
            self.noticeLable1.hidden = YES;
            self.noticeImageView1.hidden = YES;
            self.noticeLable2.hidden = NO;
            self.noticeImageView2.hidden = NO;
            
            self.centerLable1.hidden = NO;
            self.centerImageView1.hidden = NO;
            self.centerLable2.hidden = YES;
            self.centerImageView2.hidden = YES;
            
            self.chatterLable1.hidden = NO;
            self.chatterImageView1.hidden = NO;
            self.chatterLable2.hidden = YES;
            self.chatterImageView2.hidden = YES;
            
            self.ownerLable1.hidden = NO;
            self.ownerImageView1.hidden = NO;
            self.ownerLable2.hidden = YES;
            self.ownerImageView2.hidden = YES;
            
            
        }
        else if (index ==2)
        {
            
            self.selectedIndex = 2;
            
            self.homeLable1.hidden = NO;
            self.homeImageView1.hidden = NO;
            self.homeLable2.hidden = YES;
            self.homeImageView2.hidden = YES;
            
            self.noticeLable1.hidden = NO;
            self.noticeImageView1.hidden = NO;
            self.noticeLable2.hidden = YES;
            self.noticeImageView2.hidden = YES;
            
            self.centerLable1.hidden = YES;
            self.centerImageView1.hidden = YES;
            self.centerLable2.hidden = NO;
            self.centerImageView2.hidden = NO;
            
            self.chatterLable1.hidden = NO;
            self.chatterImageView1.hidden = NO;
            self.chatterLable2.hidden = YES;
            self.chatterImageView2.hidden = YES;
            
            self.ownerLable1.hidden = NO;
            self.ownerImageView1.hidden = NO;
            self.ownerLable2.hidden = YES;
            self.ownerImageView2.hidden = YES;
        }
        else if (index ==3)
        {
            self.selectedIndex = 3;
            self.homeLable1.hidden = NO;
            self.homeImageView1.hidden = NO;
            self.homeLable2.hidden = YES;
            self.homeImageView2.hidden = YES;
            
            self.noticeLable1.hidden = NO;
            self.noticeImageView1.hidden = NO;
            self.noticeLable2.hidden = YES;
            self.noticeImageView2.hidden = YES;
            
            self.centerLable1.hidden = NO;
            self.centerImageView1.hidden = NO;
            self.centerLable2.hidden = YES;
            self.centerImageView2.hidden = YES;
            
            self.chatterLable1.hidden = YES;
            self.chatterImageView1.hidden = YES;
            self.chatterLable2.hidden = NO;
            self.chatterImageView2.hidden = NO;
            
            self.ownerLable1.hidden = NO;
            self.ownerImageView1.hidden = NO;
            self.ownerLable2.hidden = YES;
            self.ownerImageView2.hidden = YES;
        }
        else if (index ==4)
        {
            self.selectedIndex = 4;
            self.homeLable1.hidden = NO;
            self.homeImageView1.hidden = NO;
            self.homeLable2.hidden = YES;
            self.homeImageView2.hidden = YES;
            
            self.noticeLable1.hidden = NO;
            self.noticeImageView1.hidden = NO;
            self.noticeLable2.hidden = YES;
            self.noticeImageView2.hidden = YES;
            
            self.centerLable1.hidden = NO;
            self.centerImageView1.hidden = NO;
            self.centerLable2.hidden = YES;
            self.centerImageView2.hidden = YES;
            
            self.chatterLable1.hidden = NO;
            self.chatterImageView1.hidden = NO;
            self.chatterLable2.hidden = YES;
            self.chatterImageView2.hidden = YES;
            
            self.ownerLable1.hidden = YES;
            self.ownerImageView1.hidden = YES;
            self.ownerLable2.hidden = NO;
            self.ownerImageView2.hidden = NO;
        }

    

}
-(BOOL)checkAlsoLogin
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * userInfo = [defaults objectForKey:USERINFO];
    if (userInfo) {
        return YES;
    }
    else
    {
        return NO;
    }
}
- (void)viewDidDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
