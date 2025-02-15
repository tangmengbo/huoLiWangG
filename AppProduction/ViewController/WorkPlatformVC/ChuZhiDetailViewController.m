//
//  ChuZhiDetailViewController.m
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/11.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ChuZhiDetailViewController.h"

@interface ChuZhiDetailViewController ()

@end

@implementation ChuZhiDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTabBarHidden];
    maxImageSelected = 5;
    self.imageArray = [NSMutableArray array];
    
    self.cloudClient = [CloudClient getInstance];
    imageIndex = 0;
    
    NSArray * gridArray = [Common getGridlist];
    if (gridArray.count>0) {
        
        NSDictionary * info = [gridArray objectAtIndex:0];
        self.grid = [info objectForKey:@"netGridId"];
    }
    self.shiJianFenLeiStr = @"00";
    self.shiJianGuiMoStr = @"01";
    self.shiJianJiBieStr = @"04";
    self.shiJianXingZhiStr = @"99";
    self.manYiType = @"01";
    self.chuLiFangShi = @"01";
    
    [self getCurrentLocation];
    
    UIButton * rightButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-50*BILI, 0, 50*BILI, self.navView.frame.size.height)];
    [rightButton addTarget:self action:@selector(tiJiaoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setTitle:@"提交" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:16*BILI];
    [self.navView addSubview:rightButton];
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT-(self.navView.frame.origin.y+self.navView.frame.size.height))];
    self.mainScrollView.delegate = self;
    self.mainScrollView.tag = 100;
    [self.view addSubview:self.mainScrollView];
    
    self.voiceHeightBottomView = [[UIView alloc] initWithFrame:CGRectMake((VIEW_WIDTH-200*BILI)/2, (VIEW_HEIGHT-200*BILI)/2, 200*BILI, 200*BILI)];
    self.voiceHeightBottomView.hidden = YES;
    self.voiceHeightBottomView.alpha = 0.5;
    self.voiceHeightBottomView.layer.cornerRadius = 8*BILI;
    self.voiceHeightBottomView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.voiceHeightBottomView];
    
    self.voiceHeightImageView = [[UIImageView alloc] initWithFrame:CGRectMake((VIEW_WIDTH-100*BILI)/2, (VIEW_HEIGHT-100*BILI)/2, 100*BILI, 100*BILI)];
    self.voiceHeightImageView.hidden = YES;
    self.voiceHeightImageView.image = [UIImage imageNamed:@"voice_1"];
    [self.view addSubview:self.voiceHeightImageView];
    
    
    UILabel * mingChengLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, 0, 75*BILI, 50*BILI)];
    mingChengLable.text = @"事件名称:";
    mingChengLable.textColor = UIColorFromRGB(0x787878);
    mingChengLable.font = [UIFont systemFontOfSize:15*BILI];
    [self.mainScrollView addSubview:mingChengLable];
    
    self.mingChengTextField = [[UITextField alloc] initWithFrame:CGRectMake(mingChengLable.frame.origin.x+mingChengLable.frame.size.width, mingChengLable.frame.origin.y, VIEW_WIDTH-(mingChengLable.frame.origin.x+mingChengLable.frame.size.width)-13*BILI, mingChengLable.frame.size.height)];
    self.mingChengTextField.font = [UIFont systemFontOfSize:15*BILI];
    self.mingChengTextField.textColor = UIColorFromRGB(0x787878);
    self.mingChengTextField.adjustsFontSizeToFitWidth = YES;
    self.mingChengTextField.delegate = self;
    [self.mainScrollView addSubview:self.mingChengTextField];
    
    UIView * mingChengLineView  = [[UIView alloc] initWithFrame:CGRectMake(0, mingChengLable.frame.origin.y+mingChengLable.frame.size.height, VIEW_WIDTH, 1)];
    mingChengLineView.backgroundColor = UIColorFromRGB(0xdddddd);
    [self.mainScrollView addSubview:mingChengLineView];
    
    self.gengDuoView = [[UIView alloc] initWithFrame:CGRectMake(0, mingChengLineView.frame.origin.y+1, VIEW_WIDTH, 4*50*BILI)];
    self.gengDuoView.backgroundColor = [UIColor whiteColor];
    [self.mainScrollView addSubview:self.gengDuoView];
    
    
    ///////事件分类
    self.fenLeiButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 50*BILI)];
    [self.fenLeiButton addTarget:self action:@selector(fenLeiButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.gengDuoView addSubview:self.fenLeiButton];
    
    
    UILabel * fenLeiLable = [[UILabel alloc] initWithFrame:CGRectMake(5*BILI, 0, 75*BILI, 50*BILI)];
    fenLeiLable.text = @"事件分类:";
    fenLeiLable.font = [UIFont systemFontOfSize:16*BILI];
    fenLeiLable.textColor = UIColorFromRGB(0x787878);
    [self.fenLeiButton addSubview:fenLeiLable];
    
    self.fenLeiLable = [[UILabel alloc] initWithFrame:CGRectMake(fenLeiLable.frame.origin.x+fenLeiLable.frame.size.width, 0, VIEW_WIDTH-(fenLeiLable.frame.origin.x+fenLeiLable.frame.size.width)-27*BILI/2-5*BILI, 50*BILI)];
    self.fenLeiLable.textAlignment = NSTextAlignmentCenter;
    self.fenLeiLable.font = [UIFont systemFontOfSize:16*BILI];
    self.fenLeiLable.textColor = UIColorFromRGB(0x787878);
    self.fenLeiLable.text = @"无";
    [self.fenLeiButton addSubview:self.fenLeiLable];
    
    UIImageView * fenLeiJianTouImageView = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_WIDTH-27*BILI/2-5*BILI, (50-15/2)*BILI/2, 27*BILI/2, 15*BILI/2)];
    fenLeiJianTouImageView.image = [UIImage imageNamed:@"xia_jiantou"];
    [self.fenLeiButton addSubview:fenLeiJianTouImageView];
    
    UIView * fenLeiLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50*BILI-1, VIEW_WIDTH, 1)];
    fenLeiLineView.backgroundColor = UIColorFromRGB(0xdddddd);
    [self.fenLeiButton addSubview:fenLeiLineView];
    
    ///////事件规模
    self.guiMoButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 50*BILI, VIEW_WIDTH, 50*BILI)];
    [self.guiMoButton addTarget:self action:@selector(guiMoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.gengDuoView addSubview:self.guiMoButton];
    
    
    UILabel * guiMoLable = [[UILabel alloc] initWithFrame:CGRectMake(5*BILI, 0, 75*BILI, 50*BILI)];
    guiMoLable.text = @"事件规模:";
    guiMoLable.font = [UIFont systemFontOfSize:16*BILI];
    guiMoLable.textColor = UIColorFromRGB(0x787878);
    [self.guiMoButton addSubview:guiMoLable];
    
    self.guiMoLable = [[UILabel alloc] initWithFrame:CGRectMake(fenLeiLable.frame.origin.x+fenLeiLable.frame.size.width, 0, VIEW_WIDTH-(fenLeiLable.frame.origin.x+fenLeiLable.frame.size.width)-27*BILI/2-5*BILI, 50*BILI)];
    self.guiMoLable.textAlignment = NSTextAlignmentCenter;
    self.guiMoLable.font = [UIFont systemFontOfSize:16*BILI];
    self.guiMoLable.textColor = UIColorFromRGB(0x787878);
    self.guiMoLable.text = @"个体性事件";
    [self.guiMoButton addSubview:self.guiMoLable];
    
    UIImageView * guiMoJianTouImageView = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_WIDTH-27*BILI/2-5*BILI, (50-15/2)*BILI/2, 27*BILI/2, 15*BILI/2)];
    guiMoJianTouImageView.image = [UIImage imageNamed:@"xia_jiantou"];
    [self.guiMoButton addSubview:guiMoJianTouImageView];
    
    UIView * guiMoLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50*BILI-1, VIEW_WIDTH, 1)];
    guiMoLineView.backgroundColor = UIColorFromRGB(0xdddddd);
    [self.guiMoButton addSubview:guiMoLineView];
    
    
    ///////事件分类
    self.jiBieButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 100*BILI, VIEW_WIDTH, 50*BILI)];
    [self.jiBieButton addTarget:self action:@selector(jiBieButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.gengDuoView addSubview:self.jiBieButton];
    
    
    UILabel * jiBieLable = [[UILabel alloc] initWithFrame:CGRectMake(5*BILI, 0, 75*BILI, 50*BILI)];
    jiBieLable.text = @"事件级别:";
    jiBieLable.font = [UIFont systemFontOfSize:16*BILI];
    jiBieLable.textColor = UIColorFromRGB(0x787878);
    [self.jiBieButton addSubview:jiBieLable];
    
    self.jiBieLable = [[UILabel alloc] initWithFrame:CGRectMake(fenLeiLable.frame.origin.x+fenLeiLable.frame.size.width, 0, VIEW_WIDTH-(fenLeiLable.frame.origin.x+fenLeiLable.frame.size.width)-27*BILI/2-5*BILI, 50*BILI)];
    self.jiBieLable.textAlignment = NSTextAlignmentCenter;
    self.jiBieLable.font = [UIFont systemFontOfSize:16*BILI];
    self.jiBieLable.textColor = UIColorFromRGB(0x787878);
    self.jiBieLable.text = @"一般";
    [self.jiBieButton addSubview:self.jiBieLable];
    
    UIImageView * jiBieJianTouImageView = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_WIDTH-27*BILI/2-5*BILI, (50-15/2)*BILI/2, 27*BILI/2, 15*BILI/2)];
    jiBieJianTouImageView.image = [UIImage imageNamed:@"xia_jiantou"];
    [self.jiBieButton addSubview:jiBieJianTouImageView];
    
    UIView * jiBieLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50*BILI-1, VIEW_WIDTH, 1)];
    jiBieLineView.backgroundColor = UIColorFromRGB(0xdddddd);
    [self.jiBieButton addSubview:jiBieLineView];
    
    
    ///////事件分类
    self.xingZhiButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 150*BILI, VIEW_WIDTH, 50*BILI)];
    [self.xingZhiButton addTarget:self action:@selector(xingZhiButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.gengDuoView addSubview:self.xingZhiButton];
    
    
    UILabel * zingZhiLable = [[UILabel alloc] initWithFrame:CGRectMake(5*BILI, 0, 75*BILI, 50*BILI)];
    zingZhiLable.text = @"事件性质:";
    zingZhiLable.font = [UIFont systemFontOfSize:16*BILI];
    zingZhiLable.textColor = UIColorFromRGB(0x787878);
    [self.xingZhiButton addSubview:zingZhiLable];
    
    self.xingZhiLable = [[UILabel alloc] initWithFrame:CGRectMake(fenLeiLable.frame.origin.x+fenLeiLable.frame.size.width, 0, VIEW_WIDTH-(fenLeiLable.frame.origin.x+fenLeiLable.frame.size.width)-27*BILI/2-5*BILI, 50*BILI)];
    self.xingZhiLable.textAlignment = NSTextAlignmentCenter;
    self.xingZhiLable.font = [UIFont systemFontOfSize:16*BILI];
    self.xingZhiLable.textColor = UIColorFromRGB(0x787878);
    self.xingZhiLable.text = @"其他";
    [self.xingZhiButton addSubview:self.xingZhiLable];

    
    UIImageView * xingZhiJianTouImageView = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_WIDTH-27*BILI/2-5*BILI, (50-15/2)*BILI/2, 27*BILI/2, 15*BILI/2)];
    xingZhiJianTouImageView.image = [UIImage imageNamed:@"xia_jiantou"];
    [self.xingZhiButton addSubview:xingZhiJianTouImageView];
    
    UIView * xingZhiLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50*BILI-1, VIEW_WIDTH, 1)];
    xingZhiLineView.backgroundColor = UIColorFromRGB(0xdddddd);
    [self.xingZhiButton addSubview:xingZhiLineView];

    
    
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, self.gengDuoView.frame.origin.y, VIEW_WIDTH, 300*BILI)];
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.mainScrollView addSubview:self.contentView];
    
    self.zhanKaiShouQiButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 30*BILI)];
    self.zhanKaiShouQiButton.backgroundColor = UIColorFromRGB(0xdddddd);
    self.zhanKaiShouQiButton.tag = 0;
    [self.zhanKaiShouQiButton addTarget:self action:@selector(zhanKaiButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.zhanKaiShouQiButton];
    
    self.zhanKaiShouQiImageView = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_WIDTH-27*BILI/2-13*BILI, (30-15/2)*BILI/2, 27*BILI/2, 15*BILI/2)];
    self.zhanKaiShouQiImageView.image = [UIImage imageNamed:@"xia_jiantou"];
    [self.zhanKaiShouQiButton addSubview:self.zhanKaiShouQiImageView];
    
    self.zhanKaiShouQiLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH-(27*BILI/2+13*BILI)-5*BILI, 30*BILI)];
    self.zhanKaiShouQiLable.textAlignment = NSTextAlignmentRight;
    self.zhanKaiShouQiLable.font = [UIFont systemFontOfSize:15*BILI];
    self.zhanKaiShouQiLable.textColor =UIColorFromRGB(0x787878);
    self.zhanKaiShouQiLable.text = @"选择更多";
    [self.zhanKaiShouQiButton addSubview:self.zhanKaiShouQiLable];
    
    UILabel * suoShuWangGeLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, self.zhanKaiShouQiButton .frame.origin.y+self.zhanKaiShouQiButton .frame.size.height, 75*BILI, 50*BILI)];
    suoShuWangGeLable.text = @"所属网格: ";
    suoShuWangGeLable.textColor = UIColorFromRGB(0x787878);
    suoShuWangGeLable.font = [UIFont systemFontOfSize:16*BILI];
    [self.contentView addSubview:suoShuWangGeLable];
    
    self.suoShuWangGeLable = [[UILabel alloc] initWithFrame:CGRectMake(suoShuWangGeLable.frame.origin.x+suoShuWangGeLable.frame.size.width, suoShuWangGeLable.frame.origin.y, VIEW_WIDTH-26*BILI, 50*BILI)];
    self.suoShuWangGeLable.text = @"无";
    self.suoShuWangGeLable.textColor = UIColorFromRGB(0x787878);
    self.suoShuWangGeLable.font = [UIFont systemFontOfSize:16*BILI];
    [self.contentView addSubview:self.suoShuWangGeLable];
    
    if (gridArray.count>0) {
        
        NSDictionary * info = [gridArray objectAtIndex:0];
        self.suoShuWangGeLable.text = [info objectForKey:@"netGridName"];
    }
    
    UIButton * wangGeButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-50, self.suoShuWangGeLable.frame.origin.y, 50, 50*BILI)];
    [wangGeButton addTarget:self action:@selector(wangGeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:wangGeButton];
    
    UIImageView * wanGeJianTouImageView = [[UIImageView alloc] initWithFrame:CGRectMake(50-27*BILI/2-5*BILI, (50-15/2)*BILI/2, 27*BILI/2, 15*BILI/2)];
    wanGeJianTouImageView.userInteractionEnabled = YES;
    wanGeJianTouImageView.image = [UIImage imageNamed:@"xia_jiantou"];
    [wangGeButton addSubview:wanGeJianTouImageView];
    
    
    UIView * wangGeLineView  = [[UIView alloc] initWithFrame:CGRectMake(0, self.suoShuWangGeLable.frame.origin.y+self.suoShuWangGeLable.frame.size.height, VIEW_WIDTH, 1)];
    wangGeLineView.backgroundColor = UIColorFromRGB(0xdddddd);
    [self.contentView addSubview:wangGeLineView];
    
    NSDictionary * dataDic = [Common getNowDateAndWeek];
    UILabel * riQiLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, wangGeLineView.frame.origin.y+1, VIEW_WIDTH-26*BILI, 50*BILI)];
    riQiLable.textColor =UIColorFromRGB(0x787878);
    riQiLable.font = [UIFont systemFontOfSize:16*BILI];
    riQiLable.text = [NSString stringWithFormat:@"发生时间: %@-%@-%@",[dataDic objectForKey:@"year"],[dataDic objectForKey:@"month"],[dataDic objectForKey:@"day"]];
    [self.contentView addSubview:riQiLable];
    
    UIView * riQiLableLineView = [[UIView alloc] initWithFrame:CGRectMake(0, riQiLable.frame.origin.y+riQiLable.frame.size.height, VIEW_WIDTH, 1)];
    riQiLableLineView.backgroundColor = UIColorFromRGB(0xEEF1F5);
    [self.contentView addSubview:riQiLableLineView];
    
    UILabel * faShengWeiZhiLabel  = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, riQiLable.frame.origin.y+riQiLable.frame.size.height+1, 75*BILI, 50*BILI)];
    faShengWeiZhiLabel.text = @"发生地点:";
    faShengWeiZhiLabel.textColor = UIColorFromRGB(0x787878);
    faShengWeiZhiLabel.font = [UIFont systemFontOfSize:15*BILI];
    [self.contentView addSubview:faShengWeiZhiLabel];

    self.faShengWeiZhiTextField = [[UITextView alloc] initWithFrame:CGRectMake(faShengWeiZhiLabel.frame.origin.x+faShengWeiZhiLabel.frame.size.width, faShengWeiZhiLabel.frame.origin.y, VIEW_WIDTH-(faShengWeiZhiLabel.frame.origin.x+faShengWeiZhiLabel.frame.size.width)-13*BILI, faShengWeiZhiLabel.frame.size.height)];
    self.faShengWeiZhiTextField.font = [UIFont systemFontOfSize:13*BILI];
    self.faShengWeiZhiTextField.textColor = UIColorFromRGB(0x787878);
    self.faShengWeiZhiTextField.delegate = self;
    [self.contentView addSubview:self.faShengWeiZhiTextField];

    UIView * faShengWeiZhiTextFieldLineView  = [[UIView alloc] initWithFrame:CGRectMake(0, faShengWeiZhiLabel.frame.origin.y+faShengWeiZhiLabel.frame.size.height, VIEW_WIDTH, 1)];
    faShengWeiZhiTextFieldLineView.backgroundColor = UIColorFromRGB(0xdddddd);
    [self.contentView addSubview:faShengWeiZhiTextFieldLineView];
    
    UILabel * neiRongLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, faShengWeiZhiTextFieldLineView.frame.origin.y+1, 75*BILI, 100*BILI)];
    neiRongLable.textColor =UIColorFromRGB(0x787878);
    neiRongLable.font = [UIFont systemFontOfSize:16*BILI];
    neiRongLable.text = @"走访内容:";
    [self.contentView addSubview:neiRongLable];
    
    self.neiRongTextView = [[UITextView alloc] initWithFrame:CGRectMake(neiRongLable.frame.origin.x+neiRongLable.frame.size.width, neiRongLable.frame.origin.y, VIEW_WIDTH-(neiRongLable.frame.origin.x+neiRongLable.frame.size.width-13*BILI), 100*BILIY)];
    self.neiRongTextView.font = [UIFont systemFontOfSize:16*BILI];
    self.neiRongTextView.zw_placeHolder = @"描述走访内容...";
    self.neiRongTextView.textColor = UIColorFromRGB(0x787878);
    self.neiRongTextView.delegate = self;
    self.neiRongTextView.tag = 101;
    [self.contentView addSubview:self.neiRongTextView];
    
    UIButton * startButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-50*BILI-13*BILI, self.neiRongTextView.frame.origin.y+self.neiRongTextView.frame.size.height+10*BILIY, 50*BILI, 50*BILI)];
    [startButton addTarget:self action:@selector(neiRongBtnHandler) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:startButton];
    
    UIImageView * huaTongImageView = [[UIImageView alloc] initWithFrame:CGRectMake((50-21/1.5)*BILI/2, (50-32/1.5)*BILI/2, 21*BILI/1.5, 32*BILI/1.5)];
    huaTongImageView.image = [UIImage imageNamed:@"huatong_gray"];
    [startButton addSubview:huaTongImageView];
    
    
    UIView * neiRongLineView = [[UIView alloc] initWithFrame:CGRectMake(0, startButton.frame.origin.y+startButton.frame.size.height+5*BILI, VIEW_WIDTH, 1)];
    neiRongLineView.backgroundColor = UIColorFromRGB(0xEEF1F5);
    [self.contentView addSubview:neiRongLineView];
    
    UILabel * chuLiFangShiLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, neiRongLineView .frame.origin.y+neiRongLineView .frame.size.height, 75*BILI, 50*BILI)];
    chuLiFangShiLable.text = @"处理方式: ";
    chuLiFangShiLable.textColor = UIColorFromRGB(0x787878);
    chuLiFangShiLable.font = [UIFont systemFontOfSize:16*BILI];
    [self.contentView addSubview:chuLiFangShiLable];
    
    self.chuLiFangShiLable = [[UILabel alloc] initWithFrame:CGRectMake(chuLiFangShiLable.frame.origin.x+chuLiFangShiLable.frame.size.width, chuLiFangShiLable.frame.origin.y, VIEW_WIDTH-26*BILI, 50*BILI)];
    self.chuLiFangShiLable.text = @"调节";
    self.chuLiFangShiLable.textColor = UIColorFromRGB(0x787878);
    self.chuLiFangShiLable.font = [UIFont systemFontOfSize:16*BILI];
    [self.contentView addSubview:self.chuLiFangShiLable];
    
    UIButton * chuLiFangShiButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-50, self.chuLiFangShiLable.frame.origin.y, 50, 50*BILI)];
    [chuLiFangShiButton addTarget:self action:@selector(chuLiFangShiButtonclick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:chuLiFangShiButton];
    
    UIImageView * chuLiFangShiJianTouImageView = [[UIImageView alloc] initWithFrame:CGRectMake(50-27*BILI/2-5*BILI, (50-15/2)*BILI/2, 27*BILI/2, 15*BILI/2)];
    chuLiFangShiJianTouImageView.userInteractionEnabled = YES;
    chuLiFangShiJianTouImageView.image = [UIImage imageNamed:@"xia_jiantou"];
    [chuLiFangShiButton addSubview:chuLiFangShiJianTouImageView];
    
    
    UIView * chuLiFangShiLineView  = [[UIView alloc] initWithFrame:CGRectMake(0, self.chuLiFangShiLable.frame.origin.y+self.chuLiFangShiLable.frame.size.height, VIEW_WIDTH, 1)];
    chuLiFangShiLineView.backgroundColor = UIColorFromRGB(0xdddddd);
    [self.contentView addSubview:chuLiFangShiLineView];
    
    UILabel * jieGuoLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, chuLiFangShiLineView.frame.origin.y+1, 75*BILI, 100*BILI)];
    jieGuoLable.textColor =UIColorFromRGB(0x787878);
    jieGuoLable.font = [UIFont systemFontOfSize:16*BILI];
    jieGuoLable.text = @"处理结果:";
    [self.contentView addSubview:jieGuoLable];
    
    self.jieGuoTextView = [[UITextView alloc] initWithFrame:CGRectMake(jieGuoLable.frame.origin.x+jieGuoLable.frame.size.width, jieGuoLable.frame.origin.y, VIEW_WIDTH-(jieGuoLable.frame.origin.x+jieGuoLable.frame.size.width-13*BILI), 100*BILIY)];
    self.jieGuoTextView.font = [UIFont systemFontOfSize:16*BILI];
    self.jieGuoTextView.zw_placeHolder = @"处理结果描述...";
    self.jieGuoTextView.textColor = UIColorFromRGB(0x787878);
    self.jieGuoTextView.delegate = self;
    self.jieGuoTextView.tag = 101;
    [self.contentView addSubview:self.jieGuoTextView];
    
    UIButton * jieGuoStartButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-50*BILI-13*BILI, self.jieGuoTextView.frame.origin.y+self.jieGuoTextView.frame.size.height+10*BILIY, 50*BILI, 50*BILI)];
    [jieGuoStartButton addTarget:self action:@selector(jieGuoBtnHandler) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:jieGuoStartButton];
    
    UIImageView * jieGuoImageView = [[UIImageView alloc] initWithFrame:CGRectMake((50-21/1.5)*BILI/2, (50-32/1.5)*BILI/2, 21*BILI/1.5, 32*BILI/1.5)];
    jieGuoImageView.image = [UIImage imageNamed:@"huatong_gray"];
    [jieGuoStartButton addSubview:jieGuoImageView];
    
    
    UIView * jieGuoLineView = [[UIView alloc] initWithFrame:CGRectMake(0, jieGuoStartButton.frame.origin.y+jieGuoStartButton.frame.size.height+5*BILI, VIEW_WIDTH, 1)];
    jieGuoLineView.backgroundColor = UIColorFromRGB(0xEEF1F5);
    [self.contentView addSubview:jieGuoLineView];
    
    UILabel * pingGuLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, jieGuoLineView.frame.origin.y+jieGuoLineView.frame.size.height, 75*BILI, 50*BILI)];
    pingGuLable.textColor =UIColorFromRGB(0x787878);
    pingGuLable.font = [UIFont systemFontOfSize:16*BILI];
    pingGuLable.text = @"效果评估:";
    [self.contentView addSubview:pingGuLable];
    
    self.tipButtonArray = [NSMutableArray array];
    
    float buttonWidth = (self.mainScrollView.frame.size.width-(pingGuLable.frame.origin.x+120*BILI)-30*BILI)/4;
    
    for (int i=0; i<4; i++) {
        
        UIButton * tipButton = [[UIButton alloc] initWithFrame:CGRectMake(pingGuLable.frame.origin.x+90*BILI+(buttonWidth+10*BILI)*i, jieGuoLineView.frame.origin.y+15*BILI, buttonWidth, 20*BILI)];
        tipButton.layer.cornerRadius = 10*BILI;
        [tipButton setTitleColor:UIColorFromRGB(0x787878) forState:UIControlStateNormal];
        tipButton.titleLabel.font = [UIFont systemFontOfSize:16*BILI];
        tipButton.layer.borderWidth =1;
        tipButton.layer.borderColor = [UIColorFromRGB(0x787878) CGColor];
        tipButton.tag = i;
        [tipButton addTarget:self action:@selector(tipButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.tipButtonArray addObject:tipButton];
        if (i==selectTipIndex) {
            
            tipButton.layer.borderColor = [UIColorFromRGB(0xFE986C) CGColor];
            [tipButton setTitleColor:UIColorFromRGB(0xFE986C) forState:UIControlStateNormal];
        }
        if (i==0) {
            
            [tipButton setTitle:@"好" forState:UIControlStateNormal];
        }else if (i==1)
        {
            [tipButton setTitle:@"较好" forState:UIControlStateNormal];
        }
        else if (i==2)
        {
            [tipButton setTitle:@"一般" forState:UIControlStateNormal];
        }
        else if (i==3)
        {
            [tipButton setTitle:@"差" forState:UIControlStateNormal];
        }
        [self.contentView addSubview:tipButton];
        
    }
    
    
    UIView * pingGULable1LineView = [[UIView alloc] initWithFrame:CGRectMake(0, pingGuLable.frame.origin.y+pingGuLable.frame.size.height, VIEW_WIDTH, 1)];
    pingGULable1LineView.backgroundColor = UIColorFromRGB(0xEEF1F5);
    [self.contentView addSubview:pingGULable1LineView];
    
    UILabel * addressLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI,pingGULable1LineView.frame.origin.y+1, 75*BILI, 60*BILI)];
    addressLable.text = @"所在位置:";
    addressLable.textColor = UIColorFromRGB(0x787878);
    addressLable.font = [UIFont systemFontOfSize:15*BILI];
    [self.contentView addSubview:addressLable];
    
    self.addressTextView = [[UITextView alloc] initWithFrame:CGRectMake(addressLable.frame.origin.x+addressLable.frame.size.width, addressLable.frame.origin.y, VIEW_WIDTH-(addressLable.frame.origin.x+addressLable.frame.size.width)-13*BILI, 60*BILI)];
    self.addressTextView.font = [UIFont systemFontOfSize:16*BILI];
    self.addressTextView.textColor = UIColorFromRGB(0x787878);
    self.addressTextView.text = self.detailAddress;
    self.addressTextView.delegate = self;
    self.addressTextView.editable = NO;
    [self.contentView addSubview:self.addressTextView];
    
    UIView * addressineView  = [[UIView alloc] initWithFrame:CGRectMake(0, addressLable.frame.origin.y+addressLable.frame.size.height, VIEW_WIDTH, 1)];
    addressineView.backgroundColor = UIColorFromRGB(0xdddddd);
    [self.contentView addSubview:addressineView];
    
    self.imageContentView = [[UIView alloc] initWithFrame:CGRectMake(13*BILI, addressineView.frame.origin.y+5*BILI, VIEW_WIDTH-26*BILI, 0)];
    self.imageContentView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.imageContentView];
    
    [self initImageContentView];
    
   
}
-(void)initImageContentView
{
    [self.imageContentView removeAllSubviews];
    float imageHeight = (VIEW_WIDTH-30*BILI-15*BILI)/4;
    
    for (int i=0; i<self.imageArray.count; i++) {
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake((i%4)*(imageHeight+5*BILI), (imageHeight+5*BILI)*(i/4), imageHeight, imageHeight)];
        imageView.userInteractionEnabled = YES;
        imageView.clipsToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.image = [self.imageArray objectAtIndex:i];
        [self.imageContentView addSubview:imageView];
        
        UIImageView * imageDelete = [[UIImageView alloc] initWithFrame:CGRectMake(imageView.frame.size.width-21*BILI, 0, 21*BILI, 21*BILI)];
        imageDelete.image = [UIImage imageNamed:@"create_dongtai_shanchu"];
        [imageView addSubview:imageDelete];
        
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(imageView.frame.size.width-30*BILI, 0, 30*BILI, 30*BILI)];
        button.tag = i;
        [button addTarget:self action:@selector(deleteImageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [imageView addSubview:button];
    }
    if(self.imageArray.count==maxImageSelected)
    {
        
    }
    else
    {
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake((self.imageArray.count%4)*(imageHeight+5*BILI), (imageHeight+5*BILI)*(self.imageArray.count/4), imageHeight, imageHeight)];
        [button setImage:[UIImage imageNamed:@"checkPhoto"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(addMediaButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.imageContentView addSubview:button];
    }
    float nowHeight;
    if (self.imageArray.count<=3)
    {
        
        nowHeight = imageHeight+5*BILI;
    }
    else
    {
        nowHeight = (imageHeight+5*BILI)*2;
    }
    self.imageContentView.frame = CGRectMake(self.imageContentView.frame.origin.x, self.imageContentView.frame.origin.y, VIEW_WIDTH-26*BILI, nowHeight);
    
    self.contentView.frame = CGRectMake(self.contentView.frame.origin.x, self.contentView.frame.origin.y, self.contentView.frame.size.width, self.imageContentView.frame.origin.y+self.imageContentView.frame.size.height);
    
    [self.mainScrollView setContentSize: CGSizeMake(VIEW_WIDTH, self.contentView.frame.origin.y+self.contentView.frame.size.height+100*BILI)];
    
    
    
    
}
-(void)deleteImageButtonClick:(id)sender
{
    
    UIButton * button = (UIButton *)sender;
    [self.imageArray removeObjectAtIndex:button.tag];
    [self initImageContentView];
}
-(void)addMediaButtonClick
{
    [self.neiRongTextView resignFirstResponder];
    [self.mingChengTextField resignFirstResponder];
    [self.jieGuoTextView resignFirstResponder];
    [self.faShengWeiZhiTextField resignFirstResponder];
    
    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    
    [actionSheet showInView:self.view.window];
    
    
}
#pragma UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if(buttonIndex == 0)
    {
        //拍摄照片或者视频
        [self addMeidFromCamera];
        
        
    }
    else if (buttonIndex == 1)
    {
        //从手机选取视频或者照片
        [self addMediaFromLibaray];
    }
    
}
- (void)addMeidFromCamera
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerController = [[UIImagePickerController alloc] init] ;
        self.imagePickerController.delegate = self;
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        self.imagePickerController.allowsEditing = YES;
        
        [self presentModalViewController:self.imagePickerController animated:YES];
    } else {
        [Common showAlert:nil message:@"您的设备不支持此种方式上传照片"];
    }
    
}
-(void)addMediaFromLibaray
{
    TZImagePickerController *imagePickController;
    
    NSInteger count = 0;
    count = maxImageSelected - self.imageArray.count;
    imagePickController = [[TZImagePickerController alloc] initWithMaxImagesCount:count delegate:self];
    //是否 在相册中显示拍照按钮
    imagePickController.allowTakePicture = NO;
    //是否可以选择显示原图
    imagePickController.allowPickingOriginalPhoto = NO;
    
    //是否 在相册中可以选择照片
    imagePickController.allowPickingImage= YES;
    //是否 在相册中可以选择视频
    imagePickController.allowPickingVideo = NO;
    
    
    [self.navigationController presentViewController:imagePickController animated:YES completion:nil];
    
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{   //判断是否设置头像
    UIImage *image = [info valueForKey:UIImagePickerControllerEditedImage];
    [self dismissModalViewControllerAnimated:YES];
    
    [self.imageArray addObject:image];
    [self initImageContentView];
}

#pragma mark - TZImagePickerController Delegate
//处理从相册单选或多选的照片
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    
    
    [[LLImagePickerManager manager] getMediaInfoFromAsset:[assets objectAtIndex:0] completion:^(NSString *name, id pathData) {
        
        LLImagePickerModel *model = [[LLImagePickerModel alloc] init];
        model.name = name;
        model.uploadType = pathData;
        model.image = photos[0];
        for (UIImage * image in photos) {
            
            [self.imageArray addObject:image];
        }
        [self initImageContentView];
    }];
    
    
}

-(void)chuLiFangShiButtonclick
{
     [self initFenLei:@"chuLiFangShi"];
}
-(void)wangGeButtonClick
{
    NSArray * array = [Common getGridlist];
    if (array.count>0)
    {
        [self initFenLei:@"wangGe"];
    }
    
}
-(void)fenLeiButtonClick
{
    [self initFenLei:@"fenLei"];
}
-(void)guiMoButtonClick
{
    [self initFenLei:@"guiMo"];
}
-(void)jiBieButtonClick
{
    [self initFenLei:@"jiBie"];
}
-(void)xingZhiButtonClick
{
    [self initFenLei:@"xingZhi"];
}
-(void)initFenLei:(NSString *)type
{
    self.shiJianType = type;
    [self.fenLeiView removeFromSuperview];
    
    [self.fenLeiView setContentSize:CGSizeMake(self.fenLeiView.frame.size.width, 0)];

    
    if (alsoShouFeiLei)
    {
        alsoShouFeiLei = NO;
        [self.fenLeiView removeFromSuperview];
    }
    else
    {
        alsoShouFeiLei = YES;
        if ([@"fenLei" isEqualToString:type])
        {
            //[self.mainScrollView setContentOffset:CGPointMake(0, 0)];
            
            self.sourceArray = [[NSMutableArray alloc] initWithObjects:@"无",@"农村集体土地征用、流转",@"国有土地拆迁",@"城乡建设管理",@"土地、山林、水利资源权属",@"环境保护",@"计划生育",@"村务管理",@"劳动社保",@"医疗卫生",@"交通事故",@"学校教育",@"房产物业",@"消费者维权、产品质量安全",@"经济合同、金融借贷",@"人身伤害",@"婚姻家庭",@"邻里关系",@"边界管理",@" 民族宗教",@"企业改制",@"移民安置",@"行政执法",@"涉法涉诉",@"损害赔偿", nil];
            
            self.fenLeiView = [[UIScrollView alloc] initWithFrame:CGRectMake(VIEW_WIDTH-213*BILI, self.gengDuoView.frame.origin.y+self.fenLeiButton.frame.origin.y+self.fenLeiButton.frame.size.height, 200*BILI, 9*35*BILI)];
            [self.fenLeiView setContentSize:CGSizeMake(self.fenLeiView.frame.size.width, self.sourceArray.count*35*BILI)];

        }
        else if ([@"guiMo" isEqualToString:type])
        {
            //[self.mainScrollView setContentOffset:CGPointMake(0, 0)];
            self.sourceArray = [[NSMutableArray alloc] initWithObjects:@"个体性事件",@"一般群体性事件",@"重大群体性事件", nil];
            self.fenLeiView = [[UIScrollView alloc] initWithFrame:CGRectMake(VIEW_WIDTH-213*BILI, self.gengDuoView.frame.origin.y+self.guiMoButton.frame.origin.y+self.guiMoButton.frame.size.height, 200*BILI, self.sourceArray.count*35*BILI)];
            [self.fenLeiView setContentSize:CGSizeMake(self.fenLeiView.frame.size.width, self.sourceArray.count*35*BILI)];

        }
        else if ([@"jiBie" isEqualToString:type])
        {
           // [self.mainScrollView setContentOffset:CGPointMake(0, 0)];
            self.sourceArray = [[NSMutableArray alloc] initWithObjects:@"特别重大",@"重大",@"较大",@"一般", nil];
            self.fenLeiView = [[UIScrollView alloc] initWithFrame:CGRectMake(VIEW_WIDTH-213*BILI, self.gengDuoView.frame.origin.y+self.jiBieButton.frame.origin.y+self.jiBieButton.frame.size.height, 200*BILI, self.sourceArray.count*35*BILI)];
            [self.fenLeiView setContentSize:CGSizeMake(self.fenLeiView.frame.size.width, self.sourceArray.count*35*BILI)];
        }
        else if ([@"xingZhi" isEqualToString:type])
        {
            //[self.mainScrollView setContentOffset:CGPointMake(0, 0)];
            self.sourceArray = [[NSMutableArray alloc] initWithObjects:@"其他",@"治安",@"刑事",@"民商事",@"行政", nil];
            self.fenLeiView = [[UIScrollView alloc] initWithFrame:CGRectMake(VIEW_WIDTH-213*BILI, self.gengDuoView.frame.origin.y+self.xingZhiButton.frame.origin.y+self.xingZhiButton.frame.size.height, 200*BILI, self.sourceArray.count*35*BILI)];
            [self.fenLeiView setContentSize:CGSizeMake(self.fenLeiView.frame.size.width, self.sourceArray.count*35*BILI)];
        }
        else if ([@"wangGe" isEqualToString:type])
        {
            
            
            
            self.sourceArray = [[NSMutableArray alloc] initWithArray:[Common getGridlist]];
            
            self.fenLeiView = [[UIScrollView alloc] initWithFrame:CGRectMake(VIEW_WIDTH-213*BILI, self.contentView.frame.origin.y+self.suoShuWangGeLable.frame.origin.y+self.suoShuWangGeLable.frame.size.height, 200*BILI, self.sourceArray.count*35*BILI)];
            [self.fenLeiView setContentSize:CGSizeMake(self.fenLeiView.frame.size.width, self.sourceArray.count*35*BILI)];
            
        }
        else if([@"chuLiFangShi" isEqualToString:type])
        {
            
            
            self.sourceArray = [[NSMutableArray alloc] initWithObjects:@"调节",@"仲裁",@"行政复议",@"行政裁决",@"诉讼",@"协商",@"其他", nil];
            self.fenLeiView = [[UIScrollView alloc] initWithFrame:CGRectMake(VIEW_WIDTH-213*BILI, self.contentView.frame.origin.y+self.chuLiFangShiLable.frame.origin.y+self.chuLiFangShiLable.frame.size.height, 200*BILI, self.sourceArray.count*35*BILI)];
            if([@"收起" isEqualToString:self.zhanKaiShouQiLable.text])
            {
                [self.mainScrollView setContentOffset:CGPointMake(0, 300*BILI)];
            }
            else
            {
                [self.mainScrollView setContentOffset:CGPointMake(0, 100*BILI)];
            }
            [self.fenLeiView setContentSize:CGSizeMake(self.fenLeiView.frame.size.width, self.sourceArray.count*35*BILI)];
            
        }
        
        self.fenLeiView.backgroundColor = UIColorFromRGB(0x787878);
        self.fenLeiView.layer.cornerRadius = 4*BILI;
        self.fenLeiView.layer.borderWidth = 1;
        self.fenLeiView.layer.borderColor = [[UIColor whiteColor] CGColor];
        [self.mainScrollView addSubview:self.fenLeiView];
        
        
        for (int i=0; i<self.sourceArray.count; i++) {
            
            UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 35*BILI*i, self.fenLeiView.frame.size.width, 35*BILI)];
            if ([@"wangGe" isEqualToString:self.shiJianType])
            {
                NSDictionary * info = [self.sourceArray objectAtIndex:button.tag];
                [button setTitle:[info objectForKey:@"netGridName"] forState:UIControlStateNormal];
            }
            else
            {
                [button setTitle:[self.sourceArray objectAtIndex:i] forState:UIControlStateNormal];
            }
            
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:14*BILI];
            [button addTarget:self action:@selector(fenLeiButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = i;
            [self.fenLeiView addSubview:button];
            
            if (i!=self.sourceArray.count-1)
            {
                UIView * fenGeLineView = [[UIView alloc] initWithFrame:CGRectMake(0, button.frame.origin.y+button.frame.size.height-1, self.fenLeiView.frame.size.width, 1)];
                fenGeLineView.backgroundColor = [UIColor whiteColor];
                [self.fenLeiView addSubview:fenGeLineView];
                
            }
        }
    }
    
    
}
-(void)fenLeiButtonClick:(id)sender
{
    alsoShouFeiLei = NO;
    [self.fenLeiView removeFromSuperview];
    UIButton * button = (UIButton *)sender;
    if ([@"fenLei" isEqualToString:self.shiJianType])
    {
        self.fenLeiLable.text = [self.sourceArray objectAtIndex:button.tag];
        if (button.tag==0)
        {
            self.shiJianFenLeiStr = @"00";
        }
        else if (button.tag==1)
        {
            self.shiJianFenLeiStr = @"01";
        }
        else if (button.tag==2)
        {
            self.shiJianFenLeiStr = @"02";
        }
        else if (button.tag==3)
        {
            self.shiJianFenLeiStr = @"03";
        }
        else if (button.tag==4)
        {
            self.shiJianFenLeiStr = @"04";
        }
        else if (button.tag==5)
        {
            self.shiJianFenLeiStr = @"05";
        }
        else if (button.tag==6)
        {
            self.shiJianFenLeiStr = @"06";
        }
        else if (button.tag==7)
        {
            self.shiJianFenLeiStr = @"07";
        }
        else if (button.tag==8)
        {
            self.shiJianFenLeiStr = @"08";
        }
        else if (button.tag==9)
        {
            self.shiJianFenLeiStr = @"09";
        }
        else if (button.tag==10)
        {
            self.shiJianFenLeiStr = @"10";
        }
        else if (button.tag==11)
        {
            self.shiJianFenLeiStr = @"11";
        }
        else if (button.tag==12)
        {
            self.shiJianFenLeiStr = @"12";
        }
        else if (button.tag==13)
        {
            self.shiJianFenLeiStr = @"13";
        }
        else if (button.tag==14)
        {
            self.shiJianFenLeiStr = @"14";
        }
        else if (button.tag==15)
        {
            self.shiJianFenLeiStr = @"15";
        }
        else if (button.tag==16)
        {
            self.shiJianFenLeiStr = @"16";
        }
        else if (button.tag==17)
        {
            self.shiJianFenLeiStr = @"17";
        }
        else if (button.tag==18)
        {
            self.shiJianFenLeiStr = @"18";
        }
        else if (button.tag==19)
        {
            self.shiJianFenLeiStr = @"19";
        }
        else if (button.tag==20)
        {
            self.shiJianFenLeiStr = @"20";
        }
        else if (button.tag==21)
        {
            self.shiJianFenLeiStr = @"21";
        }
        else if (button.tag==22)
        {
            self.shiJianFenLeiStr = @"22";
        }
        else if (button.tag==23)
        {
            self.shiJianFenLeiStr = @"23";
        }
        else if (button.tag==24)
        {
            self.shiJianFenLeiStr = @"24";
        }
    }
    else if ([@"guiMo" isEqualToString:self.shiJianType])
    {
         self.guiMoLable.text = [self.sourceArray objectAtIndex:button.tag];
        if (button.tag==0) {
            
            self.shiJianGuiMoStr = @"01";
        }
        else if (button.tag==1)
        {
            self.shiJianGuiMoStr = @"02";
        }
        else if (button.tag==2)
        {
            self.shiJianGuiMoStr = @"03";
        }
       
    }
    else if ([@"jiBie" isEqualToString:self.shiJianType])
    {
         self.jiBieLable.text = [self.sourceArray objectAtIndex:button.tag];
        if (button.tag==0) {
            
            self.shiJianJiBieStr = @"01";
        }
        else if (button.tag==1)
        {
            self.shiJianJiBieStr = @"02";
        }
        else if (button.tag==2)
        {
            self.shiJianJiBieStr = @"03";
        }
        else if (button.tag==3)
        {
            self.shiJianJiBieStr = @"04";
        }
       
    }
    else if ([@"xingZhi" isEqualToString:self.shiJianType])
    {
         self.xingZhiLable.text = [self.sourceArray objectAtIndex:button.tag];
        if (button.tag==0) {
            
            self.shiJianXingZhiStr = @"99";
        }
        else if (button.tag==1)
        {
             self.shiJianXingZhiStr = @"01";
        }
        else if (button.tag==2)
        {
             self.shiJianXingZhiStr = @"02";
        }
        else if (button.tag==3)
        {
             self.shiJianXingZhiStr = @"03";
        }
        else if (button.tag==4)
        {
             self.shiJianXingZhiStr = @"04";
        }
       
    }
    else if ([@"wangGe" isEqualToString:self.shiJianType])
    {
        NSDictionary * info = [self.sourceArray objectAtIndex:button.tag];
        self.suoShuWangGeLable.text = [info objectForKey:@"netGridName"];
        self.grid = [info objectForKey:@"netGridId"];
    }
    else
    {
        self.chuLiFangShiLable.text = [self.sourceArray objectAtIndex:button.tag];
        if (button.tag==0) {
            
            self.chuLiFangShi = @"01";
        }
        else if (button.tag==1)
        {
            self.chuLiFangShi = @"02";
        }
        else if (button.tag==2)
        {
            self.chuLiFangShi = @"03";
        }
        else if (button.tag==3)
        {
            self.chuLiFangShi = @"04";
        }
        else if (button.tag==4)
        {
            self.chuLiFangShi = @"05";
        }
        else if (button.tag==5)
        {
            self.chuLiFangShi = @"06";
        }
        else if (button.tag==6)
        {
            self.chuLiFangShi = @"07";
        }
    }
    
}
-(void)zhanKaiButtonClick
{
    if (self.zhanKaiShouQiButton.tag==0) {
        
        self.zhanKaiShouQiImageView.image = [UIImage imageNamed:@"shang_jiantou"];
        self.zhanKaiShouQiLable.text = @"收起";
        self.zhanKaiShouQiButton.tag = 1;
        [UIView beginAnimations:nil context:nil];
        self.contentView.frame = CGRectMake(0, self.gengDuoView.frame.origin.y+self.gengDuoView.frame.size.height, VIEW_WIDTH, self.contentView.frame.size.height);
        [UIView setAnimationDuration:0.5];
        [UIView commitAnimations];
        
        [self.mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH, self.contentView.frame.origin.y+self.contentView.frame.size.height)];
    }
    else
    {
        
        self.zhanKaiShouQiImageView.image = [UIImage imageNamed:@"xia_jiantou"];
        self.zhanKaiShouQiLable.text = @"选择更多";
        
        self.zhanKaiShouQiButton.tag = 0;
        [UIView beginAnimations:nil context:nil];
        self.contentView.frame = CGRectMake(0, self.gengDuoView.frame.origin.y, VIEW_WIDTH, self.contentView.frame.size.height);
        [UIView setAnimationDuration:0.5];
        [UIView commitAnimations];
        
         [self.mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH, self.contentView.frame.origin.y+self.contentView.frame.size.height)];
    }
   
}
-(void)tipButtonClick:(id)sender
{
    UIButton * selectButton =(UIButton *)sender;
    selectTipIndex = (int)selectButton.tag;
    for (int i=0; i<self.tipButtonArray.count; i++) {
        
        UIButton * button = [self.tipButtonArray objectAtIndex:i];
        [button setTitleColor:UIColorFromRGB(0x787878) forState:UIControlStateNormal];
        button.layer.borderColor = [UIColorFromRGB(0x787878) CGColor];
        
    }
    selectButton.layer.borderColor = [UIColorFromRGB(0xFE986C) CGColor];
    [selectButton setTitleColor:UIColorFromRGB(0xFE986C) forState:UIControlStateNormal];
}
-(void)tiJiaoButtonClick
{
    if (self.mingChengTextField.text.length == 0) {
        
        [Common showToastView:@"请填写场所名称" view:self.view];
        return;
    }
    if (self.faShengWeiZhiTextField.text.length == 0) {
        
        [Common showToastView:@"请填发生位置" view:self.view];
        return;
    }
    [self.faShengWeiZhiTextField resignFirstResponder];
    if (self.neiRongTextView.text.length == 0) {
        
        [Common showToastView:@"请填走访内容" view:self.view];
        return;
    }
    if (self.jieGuoTextView.text.length == 0) {
        
        [Common showToastView:@"请填处理结果" view:self.view];
        return;
    }
    
    [self showNewLoadingView:nil view:nil];
    
    if (self.imageArray.count>0) {
        
        [self uploadImage];
    }
    else
    {
        NSDictionary * dataDic = [Common getNowDateAndWeek];
        
        [self.cloudClient wangeGeShiJianChuZhi:@"eventInfo!eventSiteDisposalAdd.do"
                                        gridid:self.grid
                                  eventbigtype:self.shiJianFenLeiStr
                                    eventscope:self.shiJianGuiMoStr
                                   eventnature:self.shiJianXingZhiStr
                                    eventlevel:self.shiJianJiBieStr
                                         title:self.mingChengTextField.text
                                       content:self.neiRongTextView.text
                                   happenddate:[NSString stringWithFormat:@"%@-%@-%@",[dataDic objectForKey:@"year"],[dataDic objectForKey:@"month"],[dataDic objectForKey:@"day"]]
                                  eventaddress:self.faShengWeiZhiTextField.text
                                   resolvetype:self.chuLiFangShi
                                       results:self.jieGuoTextView.text
                                      xgpgcode:self.manYiType
                                           lot:[NSString stringWithFormat:@"%f",oldCoordinate.longitude]
                                           lat:[NSString stringWithFormat:@"%f",oldCoordinate.latitude]
                                       address:self.detailAddress
                                        imgids:@""
                                      delegate:self
                                      selector:@selector(tiJiaoSuccess:)
                                 errorSelector:@selector(tiJiaoError:)];
        
     
    }
}




-(void)uploadImage
{
    if (imageIndex<self.imageArray.count) {
        
        UIImage * image = [self .imageArray objectAtIndex:imageIndex];
        NSData* data = UIImageJPEGRepresentation(image, 0.85f);
        [self.cloudClient imageUpload:@"eventInfo!addImg.do"
                                 file:data
                           targettype:@"1"
                             delegate:self
                             selector:@selector(uploadImageSuccess:)
                        errorSelector:@selector(uploadImageError:)];
    }
    else
    {
        NSDictionary * dataDic = [Common getNowDateAndWeek];
        
        [self.cloudClient wangeGeShiJianChuZhi:@"eventInfo!eventSiteDisposalAdd.do"
                                        gridid:self.grid
                                  eventbigtype:self.shiJianFenLeiStr
                                    eventscope:self.shiJianGuiMoStr
                                   eventnature:self.shiJianXingZhiStr
                                    eventlevel:self.shiJianJiBieStr
                                         title:self.mingChengTextField.text
                                       content:self.neiRongTextView.text
                                   happenddate:[NSString stringWithFormat:@"%@-%@-%@",[dataDic objectForKey:@"year"],[dataDic objectForKey:@"month"],[dataDic objectForKey:@"day"]]
                                  eventaddress:self.faShengWeiZhiTextField.text
                                   resolvetype:self.chuLiFangShi
                                       results:self.jieGuoTextView.text
                                      xgpgcode:self.manYiType
                                           lot:[NSString stringWithFormat:@"%f",oldCoordinate.longitude]
                                           lat:[NSString stringWithFormat:@"%f",oldCoordinate.latitude]
                                       address:self.detailAddress
                                        imgids:self.imageIdStr
                                      delegate:self
                                      selector:@selector(tiJiaoSuccess:)
                                 errorSelector:@selector(tiJiaoError:)];
    }
    
}
-(void)uploadImageSuccess:(NSDictionary *)info
{
    if (imageIndex ==0) {
        
        self.imageIdStr = [info objectForKey:@"imgid"];
    }
    else
    {
        self.imageIdStr = [self.imageIdStr stringByAppendingString:[NSString stringWithFormat:@",%@",[info objectForKey:@"imgid"]]];
    }
    imageIndex++;
    [self uploadImage];
}
-(void)uploadImageError:(NSDictionary *)info
{
    imageIndex++;
    [self uploadImage];
}
-(void)tiJiaoSuccess:(NSDictionary *)info
{
    [self hideNewLoadingView];
    [Common showToastView:@"提交成功" view:self.view];
    [self performSelector:@selector(tiJiaoSuccessPop) withObject:nil afterDelay:0.5];
}
-(void)tiJiaoSuccessPop
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)tiJiaoError:(NSDictionary *)info
{
    [self hideNewLoadingView];
    [Common showToastView:[info objectForKey:@"message"] view:self.view];
}
- (void)getCurrentLocation
{
    self.myLocation = [[CLLocationManager alloc]init];
    self.myLocation.delegate = self;
    if ([self.myLocation respondsToSelector:@selector(requestWhenInUseAuthorization)])
    {
        [self.myLocation requestWhenInUseAuthorization];
    }
    self.myLocation.desiredAccuracy = kCLLocationAccuracyBest;
    self.myLocation.distanceFilter = kCLDistanceFilterNone;
    [self.myLocation startUpdatingLocation];
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    CLLocation *currlocation = [locations objectAtIndex:0];
    CLLocation *location = [[CLLocation alloc] initWithLatitude:currlocation.coordinate.latitude longitude:currlocation.coordinate.longitude];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray * placemarks, NSError * error)
     {
         
         CLLocation *newLocation = locations[0];
         oldCoordinate = newLocation.coordinate;
         NSLog(@"旧的经度：%f,旧的纬度：%f",oldCoordinate.longitude,oldCoordinate.latitude);
         
         if (placemarks.count > 0) {
             CLPlacemark *plmark = [placemarks objectAtIndex:0];
             self.detailAddress = [NSString stringWithFormat:@"%@%@%@%@ ",plmark.administrativeArea,plmark.locality,plmark.subLocality,plmark.thoroughfare];
             self.addressTextView.text = self.detailAddress;
         }
     }];
    [manager stopUpdatingLocation];
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.tag==100) {
        
        [self.neiRongTextView resignFirstResponder];
        [self.mingChengTextField resignFirstResponder];
        [self.jieGuoTextView resignFirstResponder];
        [self.faShengWeiZhiTextField resignFirstResponder];
        
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)neiRongBtnHandler
{
    self.neiRongOrJieGuo = @"content";
    [self startBtnHandler];
}
-(void)jieGuoBtnHandler
{
    self.neiRongOrJieGuo = @"result";
    [self startBtnHandler];
}
//////////////////////////////////讯飞录音
- (void)startBtnHandler{
    
    NSLog(@"%s[IN]",__func__);
    
    self.voiceHeightImageView.hidden = NO;
    self.voiceHeightBottomView.hidden = NO;
    
    
    if ([IATConfig sharedInstance].haveView == NO) {
        
        [self.neiRongTextView resignFirstResponder];
        
        if(_iFlySpeechRecognizer == nil)
        {
            [self initRecognizer];
        }
        
        [_iFlySpeechRecognizer cancel];
        
        [_iFlySpeechRecognizer setParameter:IFLY_AUDIO_SOURCE_MIC forKey:@"audio_source"];
        
        [_iFlySpeechRecognizer setParameter:@"json" forKey:[IFlySpeechConstant RESULT_TYPE]];
        
        [_iFlySpeechRecognizer setParameter:@"asr.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
        
        [_iFlySpeechRecognizer setDelegate:self];
        
        BOOL ret = [_iFlySpeechRecognizer startListening];
        
        if (ret) {
            
        }
        else
        {
            [Common showToastView:NSLocalizedString(@"M_ISR_Fail", nil) view:self.view];
        }
    }
    
}

/**
 stop recording
 **/
-(void)stopBtnHandler{
    
    NSLog(@"%s",__func__);
    
    
    [_pcmRecorder stop];
    [_iFlySpeechRecognizer stopListening];
    [self.neiRongTextView resignFirstResponder];
}
- (void) onVolumeChanged: (int)volume
{
    if (volume<=5)
    {
        self.voiceHeightImageView.image = [UIImage imageNamed:@"voice_1"];
    }
    if (volume>5&&volume<10) {
        
        self.voiceHeightImageView.image = [UIImage imageNamed:@"voice_2"];
    }
    else if(volume>=10&&volume<18)
    {
        self.voiceHeightImageView.image = [UIImage imageNamed:@"voice_3"];
    }
    else if(volume>=18&&volume<25)
    {
        self.voiceHeightImageView.image = [UIImage imageNamed:@"voice_4"];
    }
    else
    {
        self.voiceHeightImageView.image = [UIImage imageNamed:@"voice_4"];
    }
}
-(void)refreshUIWithVoicePower : (NSInteger)voicePower
{
    
}
-(void)initRecognizer
{
    NSLog(@"%s",__func__);
    
    if ([IATConfig sharedInstance].haveView == NO) {
        
        //recognition singleton without view
        if (_iFlySpeechRecognizer == nil) {
            _iFlySpeechRecognizer = [IFlySpeechRecognizer sharedInstance];
        }
        
        [_iFlySpeechRecognizer setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
        
        //set recognition domain
        [_iFlySpeechRecognizer setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
        
        _iFlySpeechRecognizer.delegate = self;
        
        if (_iFlySpeechRecognizer != nil) {
            IATConfig *instance = [IATConfig sharedInstance];
            
            //set timeout of recording
            [_iFlySpeechRecognizer setParameter:instance.speechTimeout forKey:[IFlySpeechConstant SPEECH_TIMEOUT]];
            //set VAD timeout of end of speech(EOS)
            [_iFlySpeechRecognizer setParameter:instance.vadEos forKey:[IFlySpeechConstant VAD_EOS]];
            //set VAD timeout of beginning of speech(BOS)
            [_iFlySpeechRecognizer setParameter:instance.vadBos forKey:[IFlySpeechConstant VAD_BOS]];
            //set network timeout
            [_iFlySpeechRecognizer setParameter:@"20000" forKey:[IFlySpeechConstant NET_TIMEOUT]];
            
            //set sample rate, 16K as a recommended option
            [_iFlySpeechRecognizer setParameter:instance.sampleRate forKey:[IFlySpeechConstant SAMPLE_RATE]];
            
            //set language
            [_iFlySpeechRecognizer setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
            //set accent
            [_iFlySpeechRecognizer setParameter:instance.accent forKey:[IFlySpeechConstant ACCENT]];
            
            //set whether or not to show punctuation in recognition results
            [_iFlySpeechRecognizer setParameter:instance.dot forKey:[IFlySpeechConstant ASR_PTT]];
            
        }
        
        //Initialize recorder
        if (_pcmRecorder == nil)
        {
            _pcmRecorder = [IFlyPcmRecorder sharedInstance];
        }
        
        _pcmRecorder.delegate = self;
        
        [_pcmRecorder setSample:[IATConfig sharedInstance].sampleRate];
        
        [_pcmRecorder setSaveAudioPath:nil];    //not save the audio file
    }
    
    
    if([[IATConfig sharedInstance].language isEqualToString:@"en_us"]){
        if([IATConfig sharedInstance].isTranslate){
            [self translation:NO];
        }
    }
    else{
        if([IATConfig sharedInstance].isTranslate){
            [self translation:YES];
        }
    }
    
}
-(void)translation:(BOOL) langIsZh
{
    
    if ([IATConfig sharedInstance].haveView == NO) {
        [_iFlySpeechRecognizer setParameter:@"1" forKey:[IFlySpeechConstant ASR_SCH]];
        
        if(langIsZh){
            [_iFlySpeechRecognizer setParameter:@"cn" forKey:@"orilang"];
            [_iFlySpeechRecognizer setParameter:@"en" forKey:@"translang"];
        }
        else{
            [_iFlySpeechRecognizer setParameter:@"en" forKey:@"orilang"];
            [_iFlySpeechRecognizer setParameter:@"cn" forKey:@"translang"];
        }
        
        [_iFlySpeechRecognizer setParameter:@"translate" forKey:@"addcap"];
        
        [_iFlySpeechRecognizer setParameter:@"its" forKey:@"trssrc"];
    }
    
    
}
- (void)onResults:(NSArray *) results isLast:(BOOL)isLast
{
    
    [self stopBtnHandler];
    NSMutableString *resultString = [[NSMutableString alloc] init];
    NSDictionary *dic = results[0];
    
    for (NSString *key in dic) {
        [resultString appendFormat:@"%@",key];
    }
    
    _result =[NSString stringWithFormat:@"%@%@", _neiRongTextView.text,resultString];
    
    NSString * resultFromJson =  nil;
    
    if([IATConfig sharedInstance].isTranslate){
        
        NSDictionary *resultDic  = [NSJSONSerialization JSONObjectWithData:    //The result type must be utf8, otherwise an unknown error will happen.
                                    [resultString dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
        if(resultDic != nil){
            NSDictionary *trans_result = [resultDic objectForKey:@"trans_result"];
            
            if([[IATConfig sharedInstance].language isEqualToString:@"en_us"]){
                NSString *dst = [trans_result objectForKey:@"dst"];
                NSLog(@"dst=%@",dst);
                resultFromJson = [NSString stringWithFormat:@"%@\ndst:%@",resultString,dst];
            }
            else{
                NSString *src = [trans_result objectForKey:@"src"];
                NSLog(@"src=%@",src);
                resultFromJson = [NSString stringWithFormat:@"%@\nsrc:%@",resultString,src];
            }
        }
    }
    else{
        resultFromJson = [ISRDataHelper stringFromJson:resultString];
    }
    if ([@"content" isEqualToString:self.neiRongOrJieGuo]) {
     
        _neiRongTextView.text = [NSString stringWithFormat:@"%@%@", _neiRongTextView.text,resultFromJson];
    }
    else
    {
         _jieGuoTextView.text = [NSString stringWithFormat:@"%@%@", _jieGuoTextView.text,resultFromJson];
    }
    
    
    if (isLast){
        NSLog(@"ISR Results(json)：%@",  self.result);
    }
    self.voiceHeightImageView.image = [UIImage imageNamed:@"voice_1"];
    self.voiceHeightImageView.hidden = YES;
    self.voiceHeightBottomView.hidden = YES;
    
    NSLog(@"_result=%@",_result);
    NSLog(@"resultFromJson=%@",resultFromJson);
    NSLog(@"isLast=%d,_textView.text=%@",isLast,_neiRongTextView.text);
}



@end
