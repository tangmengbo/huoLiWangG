//
//  BaoGaoChuLiViewController.m
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/14.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BaoGaoChuLiViewController.h"

@interface BaoGaoChuLiViewController ()

@end

@implementation BaoGaoChuLiViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.cloudClient = [CloudClient getInstance];
    
    self.titleLale.textColor = [UIColor whiteColor];
    self.titleLale.text = @"报告处置";
    
    self.shiJianFenLeiStr = @"00";
    self.shiJianGuiMoStr = @"01";
    self.shiJianJiBieStr = @"04";
    self.shiJianXingZhiStr = @"99";
    
    selectTipIndex = 0;

    NSMutableArray * feiLeiArray = [Common getFenLeiList];
    
    for (NSDictionary * info in feiLeiArray) {
        
        if ([[self.info objectForKey:@"eventtype"] isEqualToString:[info objectForKey:@"name"]]){
            
            self.shiJianFenLeiStr = [info objectForKey:@"id"];
            break;
        }
    }
    if ([@"个体性事件" isEqualToString:[self.info objectForKey:@"eventscope"]]) {
        
        self.shiJianGuiMoStr = @"01";
    }
    else if ([@"一般群体性事件" isEqualToString:[self.info objectForKey:@"eventscope"]])
    {
        self.shiJianGuiMoStr = @"02";
    }
    else if ([@"重大群体性事件" isEqualToString:[self.info objectForKey:@"eventscope"]])
    {
        self.shiJianGuiMoStr = @"03";
    }
    
    
    if ([@"特别重大" isEqualToString:[self.info objectForKey:@"eventlevel"]]) {
        self.shiJianJiBieStr = @"01";
    }
    else if ([@"重大" isEqualToString:[self.info objectForKey:@"eventlevel"]])
    {
        self.shiJianJiBieStr = @"02";
    }
    else if ([@"较大" isEqualToString:[self.info objectForKey:@"eventlevel"]])
    {
        self.shiJianJiBieStr = @"03";
    }
    else if ([@"一般" isEqualToString:[self.info objectForKey:@"eventlevel"]])
    {
        self.shiJianJiBieStr = @"04";
    }
    
    if ([@"其他" isEqualToString:[self.info objectForKey:@"eventnature"]]) {
        
        self.shiJianXingZhiStr = @"99";
    }
    else if ([@"治安" isEqualToString:[self.info objectForKey:@"eventnature"]])
    {
        self.shiJianXingZhiStr = @"01";
    }
    else if ([@"刑事" isEqualToString:[self.info objectForKey:@"eventnature"]])
    {
        self.shiJianXingZhiStr = @"02";
    }
    else if ([@"民商事" isEqualToString:[self.info objectForKey:@"eventnature"]])
    {
        self.shiJianXingZhiStr = @"03";
    }
    else if ([@"行政" isEqualToString:[self.info objectForKey:@"eventnature"]])
    {
        self.shiJianXingZhiStr = @"04";
    }
    
    
    UIButton * rightButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-50*BILI, 0, 50*BILI, self.navView.frame.size.height)];
    [rightButton addTarget:self action:@selector(tiJiaoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setTitle:@"提交" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:16*BILI];
    [self.navView addSubview:rightButton];
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT-(self.navView.frame.origin.y+self.navView.frame.size.height))];
    self.mainScrollView.delegate = self;
    [self.mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH, self.mainScrollView.frame.size.height+10)];
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

    ///////事件分类
    self.fenLeiButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 50*BILI)];
    [self.fenLeiButton addTarget:self action:@selector(fenLeiButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:self.fenLeiButton];
    
    
    UILabel * fenLeiLable = [[UILabel alloc] initWithFrame:CGRectMake(5*BILI, 0, 75*BILI, 50*BILI)];
    fenLeiLable.text = @"事件分类:";
    fenLeiLable.font = [UIFont systemFontOfSize:16*BILI];
    fenLeiLable.textColor = UIColorFromRGB(0x787878);
    [self.fenLeiButton addSubview:fenLeiLable];
    
    self.fenLeiLable = [[UILabel alloc] initWithFrame:CGRectMake(fenLeiLable.frame.origin.x+fenLeiLable.frame.size.width, 0, VIEW_WIDTH-(fenLeiLable.frame.origin.x+fenLeiLable.frame.size.width)-27*BILI/2-5*BILI, 50*BILI)];
    self.fenLeiLable.textAlignment = NSTextAlignmentCenter;
    self.fenLeiLable.font = [UIFont systemFontOfSize:16*BILI];
    self.fenLeiLable.textColor = UIColorFromRGB(0x787878);
    self.fenLeiLable.text = [self.info objectForKey:@"eventtype"];
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
    [self.mainScrollView addSubview:self.guiMoButton];
    
    
    UILabel * guiMoLable = [[UILabel alloc] initWithFrame:CGRectMake(5*BILI, 0, 75*BILI, 50*BILI)];
    guiMoLable.text = @"事件规模:";
    guiMoLable.font = [UIFont systemFontOfSize:16*BILI];
    guiMoLable.textColor = UIColorFromRGB(0x787878);
    [self.guiMoButton addSubview:guiMoLable];
    
    self.guiMoLable = [[UILabel alloc] initWithFrame:CGRectMake(fenLeiLable.frame.origin.x+fenLeiLable.frame.size.width, 0, VIEW_WIDTH-(fenLeiLable.frame.origin.x+fenLeiLable.frame.size.width)-27*BILI/2-5*BILI, 50*BILI)];
    self.guiMoLable.textAlignment = NSTextAlignmentCenter;
    self.guiMoLable.font = [UIFont systemFontOfSize:16*BILI];
    self.guiMoLable.textColor = UIColorFromRGB(0x787878);
    self.guiMoLable.text = [self.info objectForKey:@"eventscope"];
    [self.guiMoButton addSubview:self.guiMoLable];
    
    UIImageView * guiMoJianTouImageView = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_WIDTH-27*BILI/2-5*BILI, (50-15/2)*BILI/2, 27*BILI/2, 15*BILI/2)];
    guiMoJianTouImageView.image = [UIImage imageNamed:@"xia_jiantou"];
    [self.guiMoButton addSubview:guiMoJianTouImageView];
    
    UIView * guiMoLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50*BILI-1, VIEW_WIDTH, 1)];
    guiMoLineView.backgroundColor = UIColorFromRGB(0xdddddd);
    [self.guiMoButton addSubview:guiMoLineView];
    
    
    ///////事件级别
    self.jiBieButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 100*BILI, VIEW_WIDTH, 50*BILI)];
    [self.jiBieButton addTarget:self action:@selector(jiBieButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:self.jiBieButton];
    
    
    UILabel * jiBieLable = [[UILabel alloc] initWithFrame:CGRectMake(5*BILI, 0, 75*BILI, 50*BILI)];
    jiBieLable.text = @"事件级别:";
    jiBieLable.font = [UIFont systemFontOfSize:16*BILI];
    jiBieLable.textColor = UIColorFromRGB(0x787878);
    [self.jiBieButton addSubview:jiBieLable];
    
    self.jiBieLable = [[UILabel alloc] initWithFrame:CGRectMake(fenLeiLable.frame.origin.x+fenLeiLable.frame.size.width, 0, VIEW_WIDTH-(fenLeiLable.frame.origin.x+fenLeiLable.frame.size.width)-27*BILI/2-5*BILI, 50*BILI)];
    self.jiBieLable.textAlignment = NSTextAlignmentCenter;
    self.jiBieLable.font = [UIFont systemFontOfSize:16*BILI];
    self.jiBieLable.textColor = UIColorFromRGB(0x787878);
    self.jiBieLable.text = [self.info objectForKey:@"eventlevel"];
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
    [self.mainScrollView addSubview:self.xingZhiButton];
    
    
    UILabel * zingZhiLable = [[UILabel alloc] initWithFrame:CGRectMake(5*BILI, 0, 75*BILI, 50*BILI)];
    zingZhiLable.text = @"事件性质:";
    zingZhiLable.font = [UIFont systemFontOfSize:16*BILI];
    zingZhiLable.textColor = UIColorFromRGB(0x787878);
    [self.xingZhiButton addSubview:zingZhiLable];
    
    self.xingZhiLable = [[UILabel alloc] initWithFrame:CGRectMake(fenLeiLable.frame.origin.x+fenLeiLable.frame.size.width, 0, VIEW_WIDTH-(fenLeiLable.frame.origin.x+fenLeiLable.frame.size.width)-27*BILI/2-5*BILI, 50*BILI)];
    self.xingZhiLable.textAlignment = NSTextAlignmentCenter;
    self.xingZhiLable.font = [UIFont systemFontOfSize:16*BILI];
    self.xingZhiLable.textColor = UIColorFromRGB(0x787878);
    self.xingZhiLable.text = [self.info objectForKey:@"eventnature"];
    [self.xingZhiButton addSubview:self.xingZhiLable];
    
    
    UIImageView * xingZhiJianTouImageView = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_WIDTH-27*BILI/2-5*BILI, (50-15/2)*BILI/2, 27*BILI/2, 15*BILI/2)];
    xingZhiJianTouImageView.image = [UIImage imageNamed:@"xia_jiantou"];
    [self.xingZhiButton addSubview:xingZhiJianTouImageView];
    
    UIView * xingZhiLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50*BILI-1, VIEW_WIDTH, 1)];
    xingZhiLineView.backgroundColor = UIColorFromRGB(0xdddddd);
    [self.xingZhiButton addSubview:xingZhiLineView];
    
    UILabel * pingGuLable = [[UILabel alloc] initWithFrame:CGRectMake(5*BILI, self.xingZhiButton.frame.origin.y+self.xingZhiButton.frame.size.height, 75*BILI, 50*BILI)];
    pingGuLable.textColor =UIColorFromRGB(0x787878);
    pingGuLable.font = [UIFont systemFontOfSize:16*BILI];
    pingGuLable.text = @"处    置:";
    [self.mainScrollView addSubview:pingGuLable];
    
    self.tipButtonArray = [NSMutableArray array];
    
    float buttonWidth = (self.view.frame.size.width-(pingGuLable.frame.origin.x+120*BILI)-30*BILI)/2;
    
    for (int i=0; i<2; i++) {
        
        UIButton * tipButton = [[UIButton alloc] initWithFrame:CGRectMake(pingGuLable.frame.origin.x+90*BILI+(buttonWidth+10*BILI)*i, self.xingZhiButton.frame.origin.y+self.xingZhiButton.frame.size.height+15*BILI, buttonWidth, 20*BILI)];
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
            
            [tipButton setTitle:@"本级处理" forState:UIControlStateNormal];
        }else if (i==1)
        {
            [tipButton setTitle:@"上报事件" forState:UIControlStateNormal];
        }
        
        [self.mainScrollView addSubview:tipButton];
        
    }
    
    UIView * pingGULable1LineView = [[UIView alloc] initWithFrame:CGRectMake(0, pingGuLable.frame.origin.y+pingGuLable.frame.size.height, VIEW_WIDTH, 1)];
    pingGULable1LineView.backgroundColor = UIColorFromRGB(0xEEF1F5);
    [self.mainScrollView addSubview:pingGULable1LineView];
    
    UILabel * neiRongLable = [[UILabel alloc] initWithFrame:CGRectMake(5*BILI, pingGULable1LineView.frame.origin.y+1, 75*BILI, 100*BILI)];
    neiRongLable.textColor =UIColorFromRGB(0x787878);
    neiRongLable.font = [UIFont systemFontOfSize:16*BILI];
    neiRongLable.text = @"审批意见:";
    [self.mainScrollView addSubview:neiRongLable];
    
    self.neiRongTextView = [[UITextView alloc] initWithFrame:CGRectMake(neiRongLable.frame.origin.x+neiRongLable.frame.size.width, neiRongLable.frame.origin.y, VIEW_WIDTH-80*BILI-13*BILI, 100*BILIY)];
    self.neiRongTextView.font = [UIFont systemFontOfSize:16*BILI];
    self.neiRongTextView.zw_placeHolder = @"审批意见...";
    self.neiRongTextView.textColor = UIColorFromRGB(0x787878);
    self.neiRongTextView.tag = 101;
    [self.mainScrollView addSubview:self.neiRongTextView];
    
    UIButton * startButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-50*BILI-13*BILI, self.neiRongTextView.frame.origin.y+self.neiRongTextView.frame.size.height+10*BILIY, 50*BILI, 50*BILI)];
    [startButton addTarget:self action:@selector(startBtnHandler) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startButton];
    
    UIImageView * huaTongImageView = [[UIImageView alloc] initWithFrame:CGRectMake((50-21/1.5)*BILI/2, (50-32/1.5)*BILI/2, 21*BILI/1.5, 32*BILI/1.5)];
    huaTongImageView.image = [UIImage imageNamed:@"huatong_gray"];
    [startButton addSubview:huaTongImageView];
    
    UIView * neiRongLineView = [[UIView alloc] initWithFrame:CGRectMake(0, startButton.frame.origin.y+startButton.frame.size.height+5*BILI, VIEW_WIDTH, 1)];
    neiRongLineView.backgroundColor = UIColorFromRGB(0xEEF1F5);
    [self.mainScrollView addSubview:neiRongLineView];
    

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
            
            self.sourceArray = [[NSMutableArray alloc] initWithObjects:@"无",@"农村集体土地征用、流转",@"国有土地拆迁",@"城乡建设管理",@"土地、山林、水利资源权属",@"环境保护",@"计划生育",@"村务管理",@"劳动社保",@"医疗卫生",@"交通事故",@"学校教育",@"房产物业",@"消费者维权、产品质量安全",@"经济合同、金融借贷",@"人身伤害",@"婚姻家庭",@"邻里关系",@"边界管理",@" 民族宗教",@"企业改制",@"移民安置",@"行政执法",@"涉法涉诉",@"损害赔偿", nil];
            self.fenLeiView = [[UIScrollView alloc] initWithFrame:CGRectMake(VIEW_WIDTH-213*BILI, self.fenLeiButton.frame.origin.y+self.fenLeiButton.frame.size.height, 200*BILI, 9*35*BILI)];
            [self.fenLeiView setContentSize:CGSizeMake(self.fenLeiView.frame.size.width, self.sourceArray.count*35*BILI)];
            
        }
        else if ([@"guiMo" isEqualToString:type])
        {
            self.sourceArray = [[NSMutableArray alloc] initWithObjects:@"个体性事件",@"一般群体性事件",@"重大群体性事件", nil];
            self.fenLeiView = [[UIScrollView alloc] initWithFrame:CGRectMake(VIEW_WIDTH-213*BILI, self.guiMoButton.frame.origin.y+self.guiMoButton.frame.size.height, 200*BILI, self.sourceArray.count*35*BILI)];
            
            [self.fenLeiView setContentSize:CGSizeMake(self.fenLeiView.frame.size.width, self.sourceArray.count*35*BILI)];
            
        }
        else if ([@"jiBie" isEqualToString:type])
        {
            self.sourceArray = [[NSMutableArray alloc] initWithObjects:@"特别重大",@"重大",@"较大",@"一般", nil];
            self.fenLeiView = [[UIScrollView alloc] initWithFrame:CGRectMake(VIEW_WIDTH-213*BILI, self.jiBieButton.frame.origin.y+self.jiBieButton.frame.size.height, 200*BILI, self.sourceArray.count*35*BILI)];
            
            [self.fenLeiView setContentSize:CGSizeMake(self.fenLeiView.frame.size.width, self.sourceArray.count*35*BILI)];
        }
        else if ([@"xingZhi" isEqualToString:type])
        {
            self.sourceArray = [[NSMutableArray alloc] initWithObjects:@"其他",@"治安",@"刑事",@"民商事",@"行政", nil];
            self.fenLeiView = [[UIScrollView alloc] initWithFrame:CGRectMake(VIEW_WIDTH-213*BILI, self.xingZhiButton.frame.origin.y+self.xingZhiButton.frame.size.height, 200*BILI, self.sourceArray.count*35*BILI)];
            [self.fenLeiView setContentSize:CGSizeMake(self.fenLeiView.frame.size.width, self.sourceArray.count*35*BILI)];
        }
        
        self.fenLeiView.backgroundColor = UIColorFromRGB(0x787878);
        self.fenLeiView.layer.cornerRadius = 4*BILI;
        self.fenLeiView.layer.borderWidth = 1;
        self.fenLeiView.layer.borderColor = [[UIColor whiteColor] CGColor];
        [self.mainScrollView addSubview:self.fenLeiView];
        
        
        for (int i=0; i<self.sourceArray.count; i++) {
            
            UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 35*BILI*i, self.fenLeiView.frame.size.width, 35*BILI)];
            [button setTitle:[self.sourceArray objectAtIndex:i] forState:UIControlStateNormal];
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
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.neiRongTextView resignFirstResponder];
}
-(void)tiJiaoButtonClick
{
    if (self.neiRongTextView.text.length==0) {
        
        [Common showToastView:@"请填写审批意见" view:self.view];
        return;
    }
    [self showNewLoadingView:@"上传中..." view:self.view];
    [self.cloudClient baoGaoShenYueChuLi:@"eventInfo!reviewEventEdit.do"
                                 eventid:[self.info objectForKey:@"eventid"]
                                    idea:self.neiRongTextView.text
                                  sbflag:[NSString stringWithFormat:@"%d",selectTipIndex+1]
                            eventbigtype:self.shiJianFenLeiStr
                              eventscope:self.shiJianGuiMoStr
                             eventnature:self.shiJianXingZhiStr
                              eventlevel:self.shiJianJiBieStr
                                delegate:self
                                selector:@selector(tiJiaoSuccess:)
                           errorSelector:@selector(tiJiaoError:)];
}
-(void)tiJiaoSuccess:(NSDictionary *)info
{
    [self hideNewLoadingView];
    
    [Common showToastView:@"处理成功" view:self.view];
    [self performSelector:@selector(successPop) withObject:nil afterDelay:0.5];
    
   
}
-(void)successPop
{
    NSMutableArray *vcArray = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    for (int i=0;i<vcArray.count;i++ )
    {
        UIViewController *vc = [vcArray objectAtIndex:i];
        if ([vc isKindOfClass:[BaoGaoShenYueViewController class]])
        {
            [self.navigationController popToViewController:vc animated:YES];
            break;
        }
    }
}
-(void)tiJiaoError:(NSDictionary *)info
{
    [self hideNewLoadingView];
    [Common showToastView:[info objectForKey:@"message"] view:self.view];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    _iFlySpeechRecognizer = nil;
    NSMutableString *resultString = [[NSMutableString alloc] init];
    NSDictionary *dic = results[0];
    
    for (NSString *key in dic) {
        [resultString appendFormat:@"%@",key];
    }
    
    //_result =[NSString stringWithFormat:@"%@%@", _textView.text,resultString];
    
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
    
    self.neiRongTextView.text = [NSString stringWithFormat:@"%@%@", self.neiRongTextView.text,resultFromJson];
    
    self.voiceHeightImageView.image = [UIImage imageNamed:@"voice_1"];
    self.voiceHeightImageView.hidden = YES;
    self.voiceHeightBottomView.hidden = YES;
    
}




@end
