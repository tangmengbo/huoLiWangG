//
//  OwnerHomeViewController.m
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/9.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "OwnerHomeViewController.h"
#import "EditPassWorldViewController.h"
#import "EditTelViewController.h"
#import "ImageCache.h"

@interface OwnerHomeViewController ()

@end

@implementation OwnerHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cloudClient = [CloudClient getInstance];
    
    self.titleLale.textColor = [UIColor whiteColor];
    self.titleLale.text = @"我的";
   
    
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * userInfo = [userDefaults objectForKey:USERINFO];
    NSNumber * typeNumber = [userInfo objectForKey:@"logintype"];
    self.view.backgroundColor = UIColorFromRGB(0xEEF1F5);

    
    if (typeNumber.intValue==1)//网格长
    {
        self.backImageView.frame = CGRectMake(self.backImageView.frame.origin.x, (self.navView.frame.size.height-18*BILIY)/2,  18*59/65*BILI, 18*BILIY);
        self.backImageView.image = [UIImage imageNamed:@"xiaoxi_lingDang"];
        
        
        
        UIButton * rightButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-50*BILI, 0, 50*BILI, self.navView.frame.size.height)];
        [rightButton addTarget:self action:@selector(bangZhuButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [rightButton setTitle:@"帮助" forState:UIControlStateNormal];
        [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        rightButton.titleLabel.font = [UIFont systemFontOfSize:16*BILI];
        [self.navView addSubview:rightButton];
        
    }
    else if (typeNumber.intValue==4)//综治
    {
    }
    
    
    UIView * topMessageView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, 156*BILIY/2)];
    topMessageView.backgroundColor = UIColorFromRGB(0x5077AA);
    [self.view addSubview:topMessageView];
    
     self.headerImageView = [[CustomImageView alloc] initWithFrame:CGRectMake(17*BILI, (156*BILIY/2-62*BILI)/2, 62*BILI, 62*BILI)];
    self.headerImageView.layer.borderWidth = 2;
    self.headerImageView.layer.borderColor = [UIColorFromRGB(0xBDCCDF) CGColor];
    self.headerImageView.layer.cornerRadius = 4*BILI;
    self.headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.headerImageView.autoresizingMask = UIViewAutoresizingNone;
    self.headerImageView.clipsToBounds = YES;
    self.headerImageView.userInteractionEnabled = YES;
    self.headerImageView.imgType = IMAGEVIEW_TYPE_CENTER;
    [topMessageView addSubview:self.headerImageView];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(eaditPhoto)];
    [self.headerImageView addGestureRecognizer:tap];
    
    
    self.nameLable = [[UILabel alloc] initWithFrame:CGRectMake(198*BILI/2, 10*BILI, VIEW_WIDTH-(198*BILI/2+12*BILI), 25*BILI)];
    self.nameLable.font = [UIFont systemFontOfSize:18*BILI];
    self.nameLable.textColor = [UIColor whiteColor];
    [topMessageView addSubview:self.nameLable];
    
    self.messageLable = [[UILabel alloc] initWithFrame:CGRectMake(198*BILI/2, self.nameLable.frame.origin.y+self.nameLable.frame.size.height+3*BILIY, VIEW_WIDTH-(198*BILI/2+12*BILI), 40*BILI)];
    self.messageLable.textColor= [UIColor whiteColor];
    self.messageLable.alpha = 0.4;
    self.messageLable.numberOfLines = 2;
    self.messageLable.font = [UIFont systemFontOfSize:14*BILI];
    [topMessageView addSubview:self.messageLable];
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    self.userInfo = [defaults objectForKey:USERINFO];
    
    self.headerImageView.urlPath = [self.userInfo objectForKey:@"photourl"];

    self.nameLable.text = [self.userInfo objectForKey:@"realname"];
    self.messageLable.text =[self.userInfo objectForKey:@"deptname"];
    
    if (typeNumber.intValue==1)//网格长
    {
        ///////////////////////////////////考核button
        UIButton * kaoHeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, topMessageView.frame.origin.y+topMessageView.frame.size.height, VIEW_WIDTH, 47*BILIY)];
        kaoHeButton.backgroundColor = [UIColor whiteColor];
        [kaoHeButton addTarget:self action:@selector(kaoHeButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:kaoHeButton];
        
        UIImageView * kaoHeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(18*BILI, (47*BILIY-22*BILIY)/2, 20*BILI, 22*BILI)];
        kaoHeImageView.image = [UIImage imageNamed:@"owner_kaoHe"];
        [kaoHeButton addSubview:kaoHeImageView];
        
        UILabel * kaoHeLable = [[UILabel alloc] initWithFrame:CGRectMake(63*BILI, 0, 100, 47*BILIY)];
        kaoHeLable.font = [UIFont systemFontOfSize:16*BILI];
        kaoHeLable.textColor = UIColorFromRGB(0xFF787878);
        kaoHeLable.text = @"考核";
        [kaoHeButton addSubview:kaoHeLable];
        
        UIImageView * kaoHeJianTouImageView = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_WIDTH-16*BILI*24/44-7*BILI, (47*BILIY-16*BILIY)/2, 16*BILI*24/44, 16*BILI)];
        kaoHeJianTouImageView.image = [UIImage imageNamed:@"owner_leftJianTou"];
        [kaoHeButton addSubview:kaoHeJianTouImageView];
        
        UIView * kaoHeLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 47*BILIY-1, VIEW_WIDTH, 1)];
        kaoHeLineView.backgroundColor = UIColorFromRGB(0xD8D8D8);
        [kaoHeButton addSubview:kaoHeLineView];
        
        ///////////////////////////////////轨迹button
        
        UIButton * guiJiButton = [[UIButton alloc] initWithFrame:CGRectMake(0, kaoHeButton.frame.origin.y+kaoHeButton.frame.size.height+19*BILIY, VIEW_WIDTH, 47*BILIY)];
        guiJiButton.backgroundColor = [UIColor whiteColor];
        [guiJiButton addTarget:self action:@selector(guiJiButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:guiJiButton];
        
        UIImageView * guiJiImageView = [[UIImageView alloc] initWithFrame:CGRectMake(18*BILI, (47*BILIY-20*BILI)/2, 20*BILI, 20*BILI)];
        guiJiImageView.image = [UIImage imageNamed:@"owner_guiJi"];
        [guiJiButton addSubview:guiJiImageView];
        
        UILabel * guiJiLable = [[UILabel alloc] initWithFrame:CGRectMake(63*BILI, 0, 100, 47*BILIY)];
        guiJiLable.font = [UIFont systemFontOfSize:16*BILI];
        guiJiLable.textColor = UIColorFromRGB(0x787878);
        guiJiLable.text = @"轨迹";
        [guiJiButton addSubview:guiJiLable];
        
        UIImageView * guiJiJianTouImageView = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_WIDTH-16*BILI*24/44-7*BILI, (47*BILIY-16*BILIY)/2, 16*BILI*24/44, 16*BILI)];
        guiJiJianTouImageView.image = [UIImage imageNamed:@"owner_leftJianTou"];
        [guiJiButton addSubview:guiJiJianTouImageView];
        
        UIView * guiJiLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 47*BILIY-1, VIEW_WIDTH, 1)];
        guiJiLineView.backgroundColor = UIColorFromRGB(0xD8D8D8);
        [guiJiButton addSubview:guiJiLineView];
        
        ///////////////////////////////////消息button
        
        UIButton * xiaoXiButton = [[UIButton alloc] initWithFrame:CGRectMake(0, guiJiButton.frame.origin.y+guiJiButton.frame.size.height, VIEW_WIDTH, 47*BILIY)];
        xiaoXiButton.backgroundColor = [UIColor whiteColor];
        [xiaoXiButton addTarget:self action:@selector(xiaoXiButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:xiaoXiButton];
        
        UIImageView * xiaoXiImageView = [[UIImageView alloc] initWithFrame:CGRectMake(18*BILI, (47*BILIY-20*BILI*81/99)/2, 20*BILI, 20*BILI*81/99)];
        xiaoXiImageView.image = [UIImage imageNamed:@"xinFeng"];
        [xiaoXiButton addSubview:xiaoXiImageView];
        
        UILabel * xiaoXiLable = [[UILabel alloc] initWithFrame:CGRectMake(63*BILI, 0, 100, 47*BILIY)];
        xiaoXiLable.font = [UIFont systemFontOfSize:16*BILI];
        xiaoXiLable.textColor = UIColorFromRGB(0x787878);
        xiaoXiLable.text = @"消息";
        [xiaoXiButton addSubview:xiaoXiLable];
        
        UIImageView * xiaoXiJianTouImageView = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_WIDTH-16*BILI*24/44-7*BILI, (47*BILIY-16*BILIY)/2, 16*BILI*24/44, 16*BILI)];
        xiaoXiJianTouImageView.image = [UIImage imageNamed:@"owner_leftJianTou"];
        [xiaoXiButton addSubview:xiaoXiJianTouImageView];
        
        UIView * xiaoXiLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 47*BILIY-1, VIEW_WIDTH, 1)];
        xiaoXiLineView.backgroundColor = UIColorFromRGB(0xD8D8D8);
        [xiaoXiButton addSubview:xiaoXiLineView];
        
        ///////////////////////////////////电话button
        
        UIButton * telButton = [[UIButton alloc] initWithFrame:CGRectMake(0, xiaoXiButton.frame.origin.y+xiaoXiButton.frame.size.height, VIEW_WIDTH, 47*BILIY)];
        telButton.backgroundColor = [UIColor whiteColor];
        [telButton addTarget:self action:@selector(editTel) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:telButton];
        
        UIImageView * telImageView = [[UIImageView alloc] initWithFrame:CGRectMake(18*BILI, (47*BILIY-20*BILI)/2, 20*BILI, 20*BILI)];
        telImageView.image = [UIImage imageNamed:@"owner_tel"];
        [telButton addSubview:telImageView];
        
        UILabel * telLable = [[UILabel alloc] initWithFrame:CGRectMake(63*BILI, 0, 100, 47*BILIY)];
        telLable.font = [UIFont systemFontOfSize:16*BILI];
        telLable.textColor = UIColorFromRGB(0x787878);
        telLable.text = @"电话";
        [telButton addSubview:telLable];
        
        self.telLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH-23*BILI, 47*BILIY)];
        self.telLable.font = [UIFont systemFontOfSize:13*BILI];
        self.telLable.text =[self.userInfo objectForKey:@"tel"];
        self.telLable.textAlignment = NSTextAlignmentRight;
        self.telLable.textColor = UIColorFromRGB(0x4A4A4A);
        [telButton addSubview:self.telLable];
        
        
        UIView * telLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 47*BILIY-1, VIEW_WIDTH, 1)];
        telLineView.backgroundColor = UIColorFromRGB(0xD8D8D8);
        [telButton addSubview:telLineView];
        
        ///////////////////////////////////修改密码button
        
        UIButton * changePWButton = [[UIButton alloc] initWithFrame:CGRectMake(0, telButton.frame.origin.y+telButton.frame.size.height, VIEW_WIDTH, 47*BILIY)];
        changePWButton.backgroundColor = [UIColor whiteColor];
        [changePWButton addTarget:self action:@selector(editPassWorld) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:changePWButton];
        
        UIImageView * changePWImageView = [[UIImageView alloc] initWithFrame:CGRectMake(18*BILI, (47*BILIY-16*BILI*62/50)/2, 16*BILI, 16*BILI*62/50)];
        changePWImageView.image = [UIImage imageNamed:@"owner_changePassworld"];
        [changePWButton addSubview:changePWImageView];
        
        UILabel * changePWLable = [[UILabel alloc] initWithFrame:CGRectMake(63*BILI, 0, 100, 47*BILIY)];
        changePWLable.font = [UIFont systemFontOfSize:16*BILI];
        changePWLable.textColor = UIColorFromRGB(0x787878);
        changePWLable.text = @"修改密码";
        [changePWButton addSubview:changePWLable];
        
        UIImageView * changePWJianTouImageView = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_WIDTH-16*BILI*24/44-7*BILI, (47*BILIY-16*BILIY)/2, 16*BILI*24/44, 16*BILI)];
        changePWJianTouImageView.image = [UIImage imageNamed:@"owner_leftJianTou"];
        [changePWButton addSubview:changePWJianTouImageView];
        
        UIView * changePWLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 47*BILIY-1, VIEW_WIDTH, 1)];
        changePWLineView.backgroundColor = UIColorFromRGB(0xD8D8D8);
        [changePWButton addSubview:changePWLineView];
        
        ///////////////////////////////////退出登录button
        
        UIButton * exitButton = [[UIButton alloc] initWithFrame:CGRectMake(0, changePWButton.frame.origin.y+changePWButton.frame.size.height+19*BILIY, VIEW_WIDTH, 47*BILIY)];
        exitButton.backgroundColor = [UIColor whiteColor];
        [exitButton setTitle:@"退出登录" forState:UIControlStateNormal];
        [exitButton setTitleColor:UIColorFromRGB(0x787878) forState:UIControlStateNormal];
        exitButton.titleLabel.font = [UIFont systemFontOfSize:16*BILI];
        [exitButton addTarget:self action:@selector(exitButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:exitButton];
        
    }
    else if (typeNumber.intValue==2)//网格员
    {
        ///////////////////////////////////考核button
        UIButton * kaoHeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, topMessageView.frame.origin.y+topMessageView.frame.size.height, VIEW_WIDTH, 47*BILIY)];
        kaoHeButton.backgroundColor = [UIColor whiteColor];
        [kaoHeButton addTarget:self action:@selector(kaoHeButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:kaoHeButton];
        
        UIImageView * kaoHeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(18*BILI, (47*BILIY-22*BILIY)/2, 20*BILI, 22*BILI)];
        kaoHeImageView.image = [UIImage imageNamed:@"owner_kaoHe"];
        [kaoHeButton addSubview:kaoHeImageView];
        
        UILabel * kaoHeLable = [[UILabel alloc] initWithFrame:CGRectMake(63*BILI, 0, 100, 47*BILIY)];
        kaoHeLable.font = [UIFont systemFontOfSize:16*BILI];
        kaoHeLable.textColor = UIColorFromRGB(0xFF787878);
        kaoHeLable.text = @"考核";
        [kaoHeButton addSubview:kaoHeLable];
        
        UIImageView * kaoHeJianTouImageView = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_WIDTH-16*BILI*24/44-7*BILI, (47*BILIY-16*BILIY)/2, 16*BILI*24/44, 16*BILI)];
        kaoHeJianTouImageView.image = [UIImage imageNamed:@"owner_leftJianTou"];
        [kaoHeButton addSubview:kaoHeJianTouImageView];
        
        UIView * kaoHeLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 47*BILIY-1, VIEW_WIDTH, 1)];
        kaoHeLineView.backgroundColor = UIColorFromRGB(0xD8D8D8);
        [kaoHeButton addSubview:kaoHeLineView];
        
        ///////////////////////////////////轨迹button
        
        UIButton * guiJiButton = [[UIButton alloc] initWithFrame:CGRectMake(0, kaoHeButton.frame.origin.y+kaoHeButton.frame.size.height+19*BILIY, VIEW_WIDTH, 47*BILIY)];
        guiJiButton.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:guiJiButton];
        
        UIImageView * guiJiImageView = [[UIImageView alloc] initWithFrame:CGRectMake(18*BILI, (47*BILIY-20*BILI)/2, 20*BILI, 20*BILI)];
        guiJiImageView.image = [UIImage imageNamed:@"owner_guiJi"];
        [guiJiButton addSubview:guiJiImageView];
        
        UILabel * guiJiLable = [[UILabel alloc] initWithFrame:CGRectMake(63*BILI, 0, 100, 47*BILIY)];
        guiJiLable.font = [UIFont systemFontOfSize:16*BILI];
        guiJiLable.textColor = UIColorFromRGB(0x787878);
        guiJiLable.text = @"轨迹";
        [guiJiButton addSubview:guiJiLable];
        
        UIImageView * guiJiJianTouImageView = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_WIDTH-16*BILI*24/44-7*BILI, (47*BILIY-16*BILIY)/2, 16*BILI*24/44, 16*BILI)];
        guiJiJianTouImageView.image = [UIImage imageNamed:@"owner_leftJianTou"];
        [guiJiButton addSubview:guiJiJianTouImageView];
        
        UIView * guiJiLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 47*BILIY-1, VIEW_WIDTH, 1)];
        guiJiLineView.backgroundColor = UIColorFromRGB(0xD8D8D8);
        [guiJiButton addSubview:guiJiLineView];
        
        ///////////////////////////////////消息button
        
        UIButton * xiaoXiButton = [[UIButton alloc] initWithFrame:CGRectMake(0, guiJiButton.frame.origin.y+guiJiButton.frame.size.height, VIEW_WIDTH, 47*BILIY)];
        xiaoXiButton.backgroundColor = [UIColor whiteColor];
        [xiaoXiButton addTarget:self action:@selector(xiaoXiButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:xiaoXiButton];
        
        UIImageView * xiaoXiImageView = [[UIImageView alloc] initWithFrame:CGRectMake(18*BILI, (47*BILIY-20*BILI*81/99)/2, 20*BILI, 20*BILI*81/99)];
        xiaoXiImageView.image = [UIImage imageNamed:@"xinFeng"];
        [xiaoXiButton addSubview:xiaoXiImageView];
        
        UILabel * xiaoXiLable = [[UILabel alloc] initWithFrame:CGRectMake(63*BILI, 0, 100, 47*BILIY)];
        xiaoXiLable.font = [UIFont systemFontOfSize:16*BILI];
        xiaoXiLable.textColor = UIColorFromRGB(0x787878);
        xiaoXiLable.text = @"消息";
        [xiaoXiButton addSubview:xiaoXiLable];
        
        UIImageView * xiaoXiJianTouImageView = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_WIDTH-16*BILI*24/44-7*BILI, (47*BILIY-16*BILIY)/2, 16*BILI*24/44, 16*BILI)];
        xiaoXiJianTouImageView.image = [UIImage imageNamed:@"owner_leftJianTou"];
        [xiaoXiButton addSubview:xiaoXiJianTouImageView];
        
        UIView * xiaoXiLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 47*BILIY-1, VIEW_WIDTH, 1)];
        xiaoXiLineView.backgroundColor = UIColorFromRGB(0xD8D8D8);
        [xiaoXiButton addSubview:xiaoXiLineView];
        
        ///////////////////////////////////电话button
        
        UIButton * telButton = [[UIButton alloc] initWithFrame:CGRectMake(0, xiaoXiButton.frame.origin.y+xiaoXiButton.frame.size.height, VIEW_WIDTH, 47*BILIY)];
        telButton.backgroundColor = [UIColor whiteColor];
        [telButton addTarget:self action:@selector(editTel) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:telButton];
        
        UIImageView * telImageView = [[UIImageView alloc] initWithFrame:CGRectMake(18*BILI, (47*BILIY-20*BILI)/2, 20*BILI, 20*BILI)];
        telImageView.image = [UIImage imageNamed:@"owner_tel"];
        [telButton addSubview:telImageView];
        
        UILabel * telLable = [[UILabel alloc] initWithFrame:CGRectMake(63*BILI, 0, 100, 47*BILIY)];
        telLable.font = [UIFont systemFontOfSize:16*BILI];
        telLable.textColor = UIColorFromRGB(0x787878);
        telLable.text = @"电话";
        [telButton addSubview:telLable];
        
        self.telLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH-23*BILI, 47*BILIY)];
        self.telLable.font = [UIFont systemFontOfSize:13*BILI];
        self.telLable.text =[self.userInfo objectForKey:@"tel"];
        self.telLable.textAlignment = NSTextAlignmentRight;
        self.telLable.textColor = UIColorFromRGB(0x4A4A4A);
        [telButton addSubview:self.telLable];
        
        
        UIView * telLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 47*BILIY-1, VIEW_WIDTH, 1)];
        telLineView.backgroundColor = UIColorFromRGB(0xD8D8D8);
        [telButton addSubview:telLineView];
        
        ///////////////////////////////////修改密码button
        
        UIButton * changePWButton = [[UIButton alloc] initWithFrame:CGRectMake(0, telButton.frame.origin.y+telButton.frame.size.height, VIEW_WIDTH, 47*BILIY)];
        changePWButton.backgroundColor = [UIColor whiteColor];
        [changePWButton addTarget:self action:@selector(editPassWorld) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:changePWButton];
        
        UIImageView * changePWImageView = [[UIImageView alloc] initWithFrame:CGRectMake(18*BILI, (47*BILIY-16*BILI*62/50)/2, 16*BILI, 16*BILI*62/50)];
        changePWImageView.image = [UIImage imageNamed:@"owner_changePassworld"];
        [changePWButton addSubview:changePWImageView];
        
        UILabel * changePWLable = [[UILabel alloc] initWithFrame:CGRectMake(63*BILI, 0, 100, 47*BILIY)];
        changePWLable.font = [UIFont systemFontOfSize:16*BILI];
        changePWLable.textColor = UIColorFromRGB(0x787878);
        changePWLable.text = @"修改密码";
        [changePWButton addSubview:changePWLable];
        
        UIImageView * changePWJianTouImageView = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_WIDTH-16*BILI*24/44-7*BILI, (47*BILIY-16*BILIY)/2, 16*BILI*24/44, 16*BILI)];
        changePWJianTouImageView.image = [UIImage imageNamed:@"owner_leftJianTou"];
        [changePWButton addSubview:changePWJianTouImageView];
        
        UIView * changePWLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 47*BILIY-1, VIEW_WIDTH, 1)];
        changePWLineView.backgroundColor = UIColorFromRGB(0xD8D8D8);
        [changePWButton addSubview:changePWLineView];
        
        ///////////////////////////////////退出登录button
        
        UIButton * exitButton = [[UIButton alloc] initWithFrame:CGRectMake(0, changePWButton.frame.origin.y+changePWButton.frame.size.height+19*BILIY, VIEW_WIDTH, 47*BILIY)];
        exitButton.backgroundColor = [UIColor whiteColor];
        [exitButton setTitle:@"退出登录" forState:UIControlStateNormal];
        [exitButton setTitleColor:UIColorFromRGB(0x787878) forState:UIControlStateNormal];
        exitButton.titleLabel.font = [UIFont systemFontOfSize:16*BILI];
        [exitButton addTarget:self action:@selector(exitButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:exitButton];
        
    }
    else if (typeNumber.intValue==3||typeNumber.intValue==6)//兼职网格员和民众
    {
        
        ///////////////////////////////////消息button
        
        UIButton * xiaoXiButton = [[UIButton alloc] initWithFrame:CGRectMake(0, topMessageView.frame.origin.y+topMessageView.frame.size.height+10*BILI, VIEW_WIDTH, 47*BILIY)];
        xiaoXiButton.backgroundColor = [UIColor whiteColor];
        [xiaoXiButton addTarget:self action:@selector(xiaoXiButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:xiaoXiButton];
        
        UIImageView * xiaoXiImageView = [[UIImageView alloc] initWithFrame:CGRectMake(18*BILI, (47*BILIY-20*BILI*81/99)/2, 20*BILI, 20*BILI*81/99)];
        xiaoXiImageView.image = [UIImage imageNamed:@"xinFeng"];
        [xiaoXiButton addSubview:xiaoXiImageView];
        
        UILabel * xiaoXiLable = [[UILabel alloc] initWithFrame:CGRectMake(63*BILI, 0, 100, 47*BILIY)];
        xiaoXiLable.font = [UIFont systemFontOfSize:16*BILI];
        xiaoXiLable.textColor = UIColorFromRGB(0x787878);
        xiaoXiLable.text = @"消息";
        [xiaoXiButton addSubview:xiaoXiLable];
        
        UIImageView * xiaoXiJianTouImageView = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_WIDTH-16*BILI*24/44-7*BILI, (47*BILIY-16*BILIY)/2, 16*BILI*24/44, 16*BILI)];
        xiaoXiJianTouImageView.image = [UIImage imageNamed:@"owner_leftJianTou"];
        [xiaoXiButton addSubview:xiaoXiJianTouImageView];
        
        UIView * xiaoXiLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 47*BILIY-1, VIEW_WIDTH, 1)];
        xiaoXiLineView.backgroundColor = UIColorFromRGB(0xD8D8D8);
        [xiaoXiButton addSubview:xiaoXiLineView];
        
        ///////////////////////////////////电话button
        
        UIButton * telButton = [[UIButton alloc] initWithFrame:CGRectMake(0, xiaoXiButton.frame.origin.y+xiaoXiButton.frame.size.height, VIEW_WIDTH, 47*BILIY)];
        telButton.backgroundColor = [UIColor whiteColor];
        [telButton addTarget:self action:@selector(editTel) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:telButton];
        
        UIImageView * telImageView = [[UIImageView alloc] initWithFrame:CGRectMake(18*BILI, (47*BILIY-20*BILI)/2, 20*BILI, 20*BILI)];
        telImageView.image = [UIImage imageNamed:@"owner_tel"];
        [telButton addSubview:telImageView];
        
        UILabel * telLable = [[UILabel alloc] initWithFrame:CGRectMake(63*BILI, 0, 100, 47*BILIY)];
        telLable.font = [UIFont systemFontOfSize:16*BILI];
        telLable.textColor = UIColorFromRGB(0x787878);
        telLable.text = @"电话";
        [telButton addSubview:telLable];
        
        self.telLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH-23*BILI, 47*BILIY)];
        self.telLable.font = [UIFont systemFontOfSize:13*BILI];
        self.telLable.text =[self.userInfo objectForKey:@"tel"];
        self.telLable.textAlignment = NSTextAlignmentRight;
        self.telLable.textColor = UIColorFromRGB(0x4A4A4A);
        [telButton addSubview:self.telLable];
        
        
        UIView * telLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 47*BILIY-1, VIEW_WIDTH, 1)];
        telLineView.backgroundColor = UIColorFromRGB(0xD8D8D8);
        [telButton addSubview:telLineView];
        
        ///////////////////////////////////修改密码button
        
        UIButton * changePWButton = [[UIButton alloc] initWithFrame:CGRectMake(0, telButton.frame.origin.y+telButton.frame.size.height, VIEW_WIDTH, 47*BILIY)];
        changePWButton.backgroundColor = [UIColor whiteColor];
        [changePWButton addTarget:self action:@selector(editPassWorld) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:changePWButton];
        
        UIImageView * changePWImageView = [[UIImageView alloc] initWithFrame:CGRectMake(18*BILI, (47*BILIY-16*BILI*62/50)/2, 16*BILI, 16*BILI*62/50)];
        changePWImageView.image = [UIImage imageNamed:@"owner_changePassworld"];
        [changePWButton addSubview:changePWImageView];
        
        UILabel * changePWLable = [[UILabel alloc] initWithFrame:CGRectMake(63*BILI, 0, 100, 47*BILIY)];
        changePWLable.font = [UIFont systemFontOfSize:16*BILI];
        changePWLable.textColor = UIColorFromRGB(0x787878);
        changePWLable.text = @"修改密码";
        [changePWButton addSubview:changePWLable];
        
        UIImageView * changePWJianTouImageView = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_WIDTH-16*BILI*24/44-7*BILI, (47*BILIY-16*BILIY)/2, 16*BILI*24/44, 16*BILI)];
        changePWJianTouImageView.image = [UIImage imageNamed:@"owner_leftJianTou"];
        [changePWButton addSubview:changePWJianTouImageView];
        
        UIView * changePWLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 47*BILIY-1, VIEW_WIDTH, 1)];
        changePWLineView.backgroundColor = UIColorFromRGB(0xD8D8D8);
        [changePWButton addSubview:changePWLineView];
        
        ///////////////////////////////////退出登录button
        
        UIButton * exitButton = [[UIButton alloc] initWithFrame:CGRectMake(0, changePWButton.frame.origin.y+changePWButton.frame.size.height+19*BILIY, VIEW_WIDTH, 47*BILIY)];
        exitButton.backgroundColor = [UIColor whiteColor];
        [exitButton setTitle:@"退出登录" forState:UIControlStateNormal];
        [exitButton setTitleColor:UIColorFromRGB(0x787878) forState:UIControlStateNormal];
        exitButton.titleLabel.font = [UIFont systemFontOfSize:16*BILI];
        [exitButton addTarget:self action:@selector(exitButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:exitButton];
    }
    else if (typeNumber.intValue==4)//综治
    {
      
        ///////////////////////////////////电话button
        
        UIButton * telButton = [[UIButton alloc] initWithFrame:CGRectMake(0, topMessageView.frame.origin.y+topMessageView.frame.size.height+10*BILI, VIEW_WIDTH, 47*BILIY)];
        telButton.backgroundColor = [UIColor whiteColor];
        [telButton addTarget:self action:@selector(editTel) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:telButton];
        
        UIImageView * telImageView = [[UIImageView alloc] initWithFrame:CGRectMake(18*BILI, (47*BILIY-20*BILI)/2, 20*BILI, 20*BILI)];
        telImageView.image = [UIImage imageNamed:@"owner_tel"];
        [telButton addSubview:telImageView];
        
        UILabel * telLable = [[UILabel alloc] initWithFrame:CGRectMake(63*BILI, 0, 100, 47*BILIY)];
        telLable.font = [UIFont systemFontOfSize:16*BILI];
        telLable.textColor = UIColorFromRGB(0x787878);
        telLable.text = @"电话";
        [telButton addSubview:telLable];
        
        self.telLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH-23*BILI, 47*BILIY)];
        self.telLable.font = [UIFont systemFontOfSize:13*BILI];
        self.telLable.text =[self.userInfo objectForKey:@"tel"];
        self.telLable.textAlignment = NSTextAlignmentRight;
        self.telLable.textColor = UIColorFromRGB(0x4A4A4A);
        [telButton addSubview:self.telLable];
        
        
        UIView * telLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 47*BILIY-1, VIEW_WIDTH, 1)];
        telLineView.backgroundColor = UIColorFromRGB(0xD8D8D8);
        [telButton addSubview:telLineView];
        
        ///////////////////////////////////修改密码button
        
        UIButton * changePWButton = [[UIButton alloc] initWithFrame:CGRectMake(0, telButton.frame.origin.y+telButton.frame.size.height, VIEW_WIDTH, 47*BILIY)];
        changePWButton.backgroundColor = [UIColor whiteColor];
        [changePWButton addTarget:self action:@selector(editPassWorld) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:changePWButton];
        
        UIImageView * changePWImageView = [[UIImageView alloc] initWithFrame:CGRectMake(18*BILI, (47*BILIY-16*BILI*62/50)/2, 16*BILI, 16*BILI*62/50)];
        changePWImageView.image = [UIImage imageNamed:@"owner_changePassworld"];
        [changePWButton addSubview:changePWImageView];
        
        UILabel * changePWLable = [[UILabel alloc] initWithFrame:CGRectMake(63*BILI, 0, 100, 47*BILIY)];
        changePWLable.font = [UIFont systemFontOfSize:16*BILI];
        changePWLable.textColor = UIColorFromRGB(0x787878);
        changePWLable.text = @"修改密码";
        [changePWButton addSubview:changePWLable];
        
        UIImageView * changePWJianTouImageView = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_WIDTH-16*BILI*24/44-7*BILI, (47*BILIY-16*BILIY)/2, 16*BILI*24/44, 16*BILI)];
        changePWJianTouImageView.image = [UIImage imageNamed:@"owner_leftJianTou"];
        [changePWButton addSubview:changePWJianTouImageView];
        
        UIView * changePWLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 47*BILIY-1, VIEW_WIDTH, 1)];
        changePWLineView.backgroundColor = UIColorFromRGB(0xD8D8D8);
        [changePWButton addSubview:changePWLineView];
        ////////////////////////////////////////////关于
        UIButton * aboutButton = [[UIButton alloc] initWithFrame:CGRectMake(0, changePWButton.frame.origin.y+changePWButton.frame.size.height, VIEW_WIDTH, 47*BILIY)];
        aboutButton.backgroundColor = [UIColor whiteColor];
        [aboutButton addTarget:self action:@selector(aboutButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:aboutButton];
        
        UIImageView * aboutImageView = [[UIImageView alloc] initWithFrame:CGRectMake(18*BILI, (47*BILIY-16*BILI)/2, 16*BILI, 16*BILI)];
        aboutImageView.image = [UIImage imageNamed:@"jingShi"];
        [aboutButton addSubview:aboutImageView];
        
        UILabel * aboutLable = [[UILabel alloc] initWithFrame:CGRectMake(63*BILI, 0, 100, 47*BILIY)];
        aboutLable.font = [UIFont systemFontOfSize:16*BILI];
        aboutLable.textColor = UIColorFromRGB(0x787878);
        aboutLable.text = @"关于";
        [aboutButton addSubview:aboutLable];
        
        UIImageView * aboutJianTouImageView = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_WIDTH-16*BILI*24/44-7*BILI, (47*BILIY-16*BILIY)/2, 16*BILI*24/44, 16*BILI)];
        aboutJianTouImageView.image = [UIImage imageNamed:@"owner_leftJianTou"];
        [aboutButton addSubview:aboutJianTouImageView];
        
        UIView * aboutLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 47*BILIY-1, VIEW_WIDTH, 1)];
        aboutLineView.backgroundColor = UIColorFromRGB(0xD8D8D8);
        [aboutButton addSubview:aboutLineView];
        ///////////////////////////////////退出登录button
        
        UIButton * exitButton = [[UIButton alloc] initWithFrame:CGRectMake(0, aboutButton.frame.origin.y+aboutButton.frame.size.height+19*BILIY, VIEW_WIDTH, 47*BILIY)];
        exitButton.backgroundColor = [UIColor whiteColor];
        [exitButton setTitle:@"退出登录" forState:UIControlStateNormal];
        [exitButton setTitleColor:UIColorFromRGB(0x787878) forState:UIControlStateNormal];
        exitButton.titleLabel.font = [UIFont systemFontOfSize:16*BILI];
        [exitButton addTarget:self action:@selector(exitButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:exitButton];
    }
    
   
    
}
-(void)aboutButtonClick
{
    AboutUsViewController * vc = [[AboutUsViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)guiJiButtonClick
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * userInfo = [defaults objectForKey:USERINFO];

    GuiJiHuiFangDetailViewController * vc = [[GuiJiHuiFangDetailViewController alloc] init];
    vc.info = [[NSDictionary alloc] initWithObjectsAndKeys:[userInfo objectForKey:@"userid"],@"memberid", nil];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)editTel
{
    EditTelViewController * vc = [[EditTelViewController alloc] init];
    vc.telStr = self.telLable.text;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)editPassWorld
{
    EditPassWorldViewController * vc = [[EditPassWorldViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)eaditPhoto
{
    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    
    [actionSheet showInView:self.view.window];
    
}
#pragma UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if(buttonIndex == 0)
    {
        //拍照
        [self showImagePicker:UIImagePickerControllerSourceTypeCamera];
        
        
    }
    else if (buttonIndex == 1)
    {
        //从相册选取
        
        [self showImagePicker:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    else
    {
        
    }
}
- (void)showImagePicker:(UIImagePickerControllerSourceType)sourceType
{
    
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        self.imagePickerController = [[UIImagePickerController alloc] init] ;
        self.imagePickerController.delegate = self;
        self.imagePickerController.sourceType = sourceType;
        self.imagePickerController.allowsEditing = YES;
        
        [self presentModalViewController:self.imagePickerController animated:YES];
    } else {
        [Common showAlert:nil message:@"您的设备不支持此种方式上传照片"];
    }
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{   //判断是否设置头像
    UIImage *image = [info valueForKey:UIImagePickerControllerEditedImage];
    [self dismissModalViewControllerAnimated:YES];
    
    self.headerImage = image;
    UIImage * uploadImage = [Common scaleToSize:image size:CGSizeMake(400, 400*(image.size.height/image.size.width))];
    
    NSData *data = UIImagePNGRepresentation(uploadImage);
    
    
    
    [self showLoginLoadingView:@"正在提交..." view:nil];
    
    [self.cloudClient editHeaderPhoto:@"loginUser!updatePhoto.do"
                                 file:data
                             delegate:self
                             selector:@selector(editPhotoSuccess:)
                        errorSelector:@selector(editPhotoError:)];
    
    
}
-(void)editPhotoSuccess:(NSDictionary *)info
{
    [self hideNewLoadingView];
    
    [[ImageCache sharedImageCache]removeImageForKey:[self.userInfo objectForKey:@"photourl"]];
    self.headerImageView.image = self.headerImage;
    [Common showToastView:@"头像修改成功" view:self.view];
    
}
-(void)editPhotoError:(NSDictionary *)info
{
   
    [self hideNewLoadingView];
    [Common showToastView:[info objectForKey:@"message"] view:self.view];
}
-(void)kaoHeButtonClick
{
    KaoHePingBiListViewController * vc = [[KaoHePingBiListViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)xiaoXiButtonClick
{
    XiaoXiListViewController * vc = [[XiaoXiListViewController alloc] init];
    vc.titleStr = @"我的消息";
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)exitButtonClick
{
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:@"确认退出登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"退出", nil];
    [alertView show];
    [self.view addSubview:alertView];

}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        
    }
    else
    {
         [[NSNotificationCenter defaultCenter]postNotificationName:@"stopUploadLocation" object:nil];
        
        [self.cloudClient exitLogin:@"logoutApp.do"
                           username:[self.userInfo objectForKey:@"realname"]
                           delegate:self
                           selector:@selector(exitSuccess:)
                      errorSelector:@selector(exitError:)];
       
        
    }
    
}
-(void)exitSuccess:(NSDictionary *)info
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:USERINFO];
    [defaults synchronize];
    
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate resetNotLoginTabBar];
}
-(void)exitError:(NSDictionary *)info
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:USERINFO];
    [defaults synchronize];
    
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate resetNotLoginTabBar];
}
-(void)leftClick
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * userInfo = [userDefaults objectForKey:USERINFO];
    NSNumber * typeNumber = [userInfo objectForKey:@"logintype"];
    if (typeNumber.intValue==1)//网格长
    {
        XiaoXiClassifyViewController * vc = [[XiaoXiClassifyViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    else if (typeNumber.intValue==4||typeNumber.intValue==3||typeNumber.intValue==6)//综治
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
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
