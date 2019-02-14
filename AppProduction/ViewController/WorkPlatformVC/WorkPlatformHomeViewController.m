//
//  WorkPlatformHomeViewController.m
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/9.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "WorkPlatformHomeViewController.h"

@interface WorkPlatformHomeViewController ()

@end

@implementation WorkPlatformHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cloudClient = [CloudClient getInstance];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cleanUpAction) name:@"stopUploadLocation" object:nil];
    
    
    [self initLoactionManger];
    [self initNavView];
    [self initContentView];

    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    
}
-(void)initLoactionManger
{
    self.locationManager = [[AMapLocationManager alloc] init];
    self.locationManager.delegate = self;
    //self.locationManager.distanceFilter = 1;
    self.locationManager.locatingWithReGeocode = YES;
    //iOS 9（不包含iOS 9） 之前设置允许后台定位参数，保持不会被系统挂起
    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
    //iOS 9（包含iOS 9）之后新特性：将允许出现这种场景，同一app中多个locationmanager：一些只能在前台定位，另一些可在后台定位，并可随时禁止其后台定位。
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9) {
        self.locationManager.allowsBackgroundLocationUpdates = YES;
    }
    [self.locationManager setLocatingWithReGeocode:YES];
    //开始持续定位
    [self.locationManager startUpdatingLocation];
}
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode
{
    if (reGeocode)
    {
        NSLog(@"reGeocode:%@", reGeocode);
        self.detailAddress = [NSString stringWithFormat:@"%@%@%@%@%@%@",reGeocode.province,reGeocode.city,reGeocode.district,reGeocode.street,reGeocode.number,reGeocode.POIName];
        
        
    }
    if (!self.location) {
        
        self.location = location;
        self.location2 = location;
        [self.cloudClient uploadAddress:@"trackerLocal.do"
                                    lot:[NSString stringWithFormat:@"%f",self.location.coordinate.longitude]
                                    lat:[NSString stringWithFormat:@"%f",self.location.coordinate.latitude]
                                address:[Common getobjectForKey:self.detailAddress]
                               delegate:self
                               selector:@selector(uploadAddressSuccess:)
                          errorSelector:@selector(uploadAddressError:)];
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(timerRecord) userInfo:nil repeats:YES];
       
    }
    else
    {
        self.location2 = location;
    }
    
    
}
-(void)timerRecord
{
    //1.将两个经纬度点转成投影点
    MAMapPoint point1 = MAMapPointForCoordinate(CLLocationCoordinate2DMake(self.location.coordinate.latitude,self.location.coordinate.longitude));
    MAMapPoint point2 = MAMapPointForCoordinate(CLLocationCoordinate2DMake(self.location2.coordinate.latitude,self.location2.coordinate.longitude));
    //2.计算距离
    CLLocationDistance distance = MAMetersBetweenMapPoints(point1,point2);
    NSLog(@"%f开始",distance);
    if (distance>300)
    {
        self.location  = self.location2;//reGeocode.formattedAddress
        NSLog(@"%f大于",distance);
        [self.cloudClient uploadAddress:@"trackerLocal.do"
                                    lot:[NSString stringWithFormat:@"%f",self.location.coordinate.longitude]
                                    lat:[NSString stringWithFormat:@"%f",self.location.coordinate.latitude]
                                address:[Common getobjectForKey:self.detailAddress]
                               delegate:self
                               selector:@selector(uploadAddressSuccess:)
                          errorSelector:@selector(uploadAddressError:)];
    }

}
- (void)cleanUpAction
{
    [self.timer invalidate];
    self.timer = nil;
    //停止定位
    [self.locationManager stopUpdatingLocation];
    
    [self.locationManager setDelegate:nil];
    
}
-(void)uploadAddressSuccess:(NSDictionary *)info
{
    
}
-(void)uploadAddressError:(NSDictionary *)info
{
    
}



-(void)initNavView
{
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

}
-(void)initContentView
{
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT-(self.navView.frame.origin.y+self.navView.frame.size.height+SafeAreaBottomHeight))];
    [self.view addSubview:self.mainScrollView];
    float buttonWidth = (VIEW_WIDTH-26*BILI-7*BILI)/2;
    float buttonHeight = 199*BILIY/2;
    for (int i=0; i<8; i++)
    {
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(13*BILI+(buttonWidth+7*BILI)*(i%2), 10*BILIY+(buttonHeight+8*BILIY)*(i/2), buttonWidth, buttonHeight)];
        button.tag = i;
        button.layer.cornerRadius = 8*BILI;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.mainScrollView addSubview:button];

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
    
    UILabel * fenGeLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI,10*BILI+(buttonHeight+8*BILI)*4, VIEW_WIDTH-26*BILI, 40*BILI)];
    fenGeLable.backgroundColor = UIColorFromRGB(0xEEF1F5);
    fenGeLable.textAlignment = NSTextAlignmentCenter;
    fenGeLable.textColor = UIColorFromRGB(0x787878);
    fenGeLable.font = [UIFont systemFontOfSize:18*BILI];
    fenGeLable.text = @"网格长管理";
    [self.mainScrollView addSubview:fenGeLable];
    
    
    for (int i=0; i<4; i++)
    {
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(13*BILI+(buttonWidth+7*BILI)*(i%2), fenGeLable.frame.origin.y+fenGeLable.frame.size.height+10*BILIY+(buttonHeight+8*BILIY)*(i/2), buttonWidth, buttonHeight)];
        button.tag = i+8;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.layer.cornerRadius = 8*BILI;
        [self.mainScrollView addSubview:button];

        UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(12*BILI, 10*BILI, 200, 18*BILI)];
        titleLable.textColor = [UIColor whiteColor];
        titleLable.font = [UIFont systemFontOfSize:18*BILI];
        [button addSubview:titleLable];
        
        UIImageView * tipImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        [button addSubview:tipImageView];

        if (i==0)
        {
            titleLable.text = @"报告审阅";
            button.backgroundColor = UIColorFromRGB(0x5BBD63);
            tipImageView.frame = CGRectMake(button.frame.size.width-40*BILI-15*BILI, button.frame.size.height-40*BILI*132/116-13*BILI, 40*BILI, 40*BILI*132/116);
            tipImageView.image = [UIImage imageNamed:@"guanKongTaiZhang"];        }
        else if (i==1)
        {
            titleLable.text = @"统计分析";
            button.backgroundColor = UIColorFromRGB(0xFFCF00);
            tipImageView.frame = CGRectMake(button.frame.size.width-40*BILI-15*BILI, button.frame.size.height-40*BILI-13*BILI, 40*BILI, 40*BILI);
            tipImageView.image = [UIImage imageNamed:@"tongJi"];
            
        }
        else if (i==2)
        {
            titleLable.text = @"轨迹回放";
            button.backgroundColor = UIColorFromRGB(0xEE7F6C);
            tipImageView.frame = CGRectMake(button.frame.size.width-40*BILI-15*BILI, button.frame.size.height-40*BILI-13*BILI, 40*BILI, 40*BILI);
            tipImageView.image = [UIImage imageNamed:@"huiFang"];
            
        }
        else if (i==3)
        {
            titleLable.text = @"网格信息";
            button.backgroundColor = UIColorFromRGB(0xEAB90D);
            tipImageView.frame = CGRectMake(button.frame.size.width-40*BILI-15*BILI, button.frame.size.height-40*BILI*132/116-13*BILI, 40*BILI, 40*BILI*132/116);
            tipImageView.image = [UIImage imageNamed:@"guanKongTaiZhang"];
            
        }
        
        [self.mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH, button.frame.origin.y+button.frame.size.height+10*BILI)];
        
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
    else if (button.tag==8)
    {
        BaoGaoShenYueViewController * vc = [[BaoGaoShenYueViewController alloc] init];
        vc.titleStr = @"报告审阅";
        [self.navigationController pushViewController:vc animated:YES];

    }
    else if (button.tag==9)
    {
        TongJiFenXiViewController * vc = [[TongJiFenXiViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];

    }
    else if (button.tag==10)
    {
        WangGeYuanListViewController * vc = [[WangGeYuanListViewController alloc] init];
        vc.fromWhere = @"gjhf";
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (button.tag==11)
    {
      
        WangGeXinXiViewController * vc = [[WangGeXinXiViewController alloc] init];
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

-(void)guiJiHuiFangButtonClick
{
    
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



@end
