//
//  YiBAnChangSuoViewController.m
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/11.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "YiBAnChangSuoViewController.h"

@interface YiBAnChangSuoViewController ()

@end

@implementation YiBAnChangSuoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    
    self.titleLale.textColor = [UIColor whiteColor];
    self.titleLale.text = @"一般场所";
    
    NSArray * gridArray = [Common getGridlist];
    if (gridArray.count>0) {
        
        NSDictionary * info = [gridArray objectAtIndex:0];
        self.grid = [info objectForKey:@"netGridId"];
    }
    

    [self setTabBarHidden];
    maxImageSelected = 5;
    [self getCurrentLocation];
    
    self.cloudClient = [CloudClient getInstance];
    
    imageIndex = 0;
    self.manYiType = @"01";
    self.shiFouJieJue = @"0";
    self.risktype = @"01";
    
    self.imageArray = [NSMutableArray array];
    
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
    mingChengLable.text = @"场所名称:";
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
    
    UILabel * fuZeRenLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, mingChengLineView.frame.origin.y+1, 75*BILI, 50*BILI)];
    fuZeRenLable.text = @"负 责 人:";
    fuZeRenLable.textColor = UIColorFromRGB(0x787878);
    fuZeRenLable.font = [UIFont systemFontOfSize:15*BILI];
    [self.mainScrollView addSubview:fuZeRenLable];
    
    self.fuZeRenTextField = [[UITextField alloc] initWithFrame:CGRectMake(mingChengLable.frame.origin.x+mingChengLable.frame.size.width, fuZeRenLable.frame.origin.y, VIEW_WIDTH-(mingChengLable.frame.origin.x+mingChengLable.frame.size.width)-13*BILI, mingChengLable.frame.size.height)];
    self.fuZeRenTextField.font = [UIFont systemFontOfSize:15*BILI];
    self.fuZeRenTextField.textColor = UIColorFromRGB(0x787878);
    self.fuZeRenTextField.adjustsFontSizeToFitWidth = YES;
    self.fuZeRenTextField.delegate = self;
    [self.mainScrollView addSubview:self.fuZeRenTextField];
    
    UIView * fuZeRenLineView  = [[UIView alloc] initWithFrame:CGRectMake(0, fuZeRenLable.frame.origin.y+fuZeRenLable.frame.size.height, VIEW_WIDTH, 1)];
    fuZeRenLineView.backgroundColor = UIColorFromRGB(0xdddddd);
    [self.mainScrollView addSubview:fuZeRenLineView];
    
    
    UILabel * telLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI,fuZeRenLineView.frame.origin.y+1, 75*BILI, 50*BILI)];
    telLable.text = @"联系电话:";
    telLable.textColor = UIColorFromRGB(0x787878);
    telLable.font = [UIFont systemFontOfSize:15*BILI];
    [self.mainScrollView addSubview:telLable];
    
    self.telTextField = [[UITextField alloc] initWithFrame:CGRectMake(mingChengLable.frame.origin.x+mingChengLable.frame.size.width, telLable.frame.origin.y, VIEW_WIDTH-(mingChengLable.frame.origin.x+mingChengLable.frame.size.width)-13*BILI, mingChengLable.frame.size.height)];
    self.telTextField.font = [UIFont systemFontOfSize:15*BILI];
    self.telTextField.textColor = UIColorFromRGB(0x787878);
    self.telTextField.adjustsFontSizeToFitWidth = YES;
    self.telTextField.delegate = self;
    [self.mainScrollView addSubview:self.telTextField];
    
    UIView * telLineView  = [[UIView alloc] initWithFrame:CGRectMake(0, telLable.frame.origin.y+telLable.frame.size.height, VIEW_WIDTH, 1)];
    telLineView.backgroundColor = UIColorFromRGB(0xdddddd);
    [self.mainScrollView addSubview:telLineView];
    
    if (self.info) {
        
        self.mingChengTextField.text = [self.info objectForKey:@"placename"];
        self.fuZeRenTextField.text = [self.info objectForKey:@"placeheader"];
        self.telTextField.text = [self.info objectForKey:@"headertel"];
        
            self.titleLale.text = @"重点场所";
       
        self.mingChengTextField.enabled = NO;
        self.fenLeiLable.enabled = NO;
        self.mingChengTextField.enabled = NO;
    }
    
    
    UILabel * suoShuWangGeLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, telLineView.frame.origin.y+1, 75*BILI, 50*BILI)];
    suoShuWangGeLable.text = @"所属网格: ";
    suoShuWangGeLable.textColor = UIColorFromRGB(0x787878);
    suoShuWangGeLable.font = [UIFont systemFontOfSize:16*BILI];
    [self.mainScrollView addSubview:suoShuWangGeLable];
    
    self.suoShuWangGeLable = [[UILabel alloc] initWithFrame:CGRectMake(suoShuWangGeLable.frame.origin.x+suoShuWangGeLable.frame.size.width, suoShuWangGeLable.frame.origin.y, VIEW_WIDTH-26*BILI, 50*BILI)];
    self.suoShuWangGeLable.text = @"无";
    self.suoShuWangGeLable.textColor = UIColorFromRGB(0x787878);
    self.suoShuWangGeLable.font = [UIFont systemFontOfSize:16*BILI];
    [self.mainScrollView addSubview:self.suoShuWangGeLable];
    
    if (gridArray.count>0) {
        
        NSDictionary * info = [gridArray objectAtIndex:0];
        self.suoShuWangGeLable.text  = [info objectForKey:@"netGridName"];
    }
    
    
    UIButton * wangGeButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-50, self.suoShuWangGeLable.frame.origin.y, 50, 50*BILI)];
    [wangGeButton addTarget:self action:@selector(wangGeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:wangGeButton];
    
    UIImageView * wanGeJianTouImageView = [[UIImageView alloc] initWithFrame:CGRectMake(50-27*BILI/2-5*BILI, (50-15/2)*BILI/2, 27*BILI/2, 15*BILI/2)];
    wanGeJianTouImageView.userInteractionEnabled = YES;
    wanGeJianTouImageView.image = [UIImage imageNamed:@"xia_jiantou"];
    [wangGeButton addSubview:wanGeJianTouImageView];
    
    
    UIView * wangGeLineView  = [[UIView alloc] initWithFrame:CGRectMake(0, self.suoShuWangGeLable.frame.origin.y+self.suoShuWangGeLable.frame.size.height, VIEW_WIDTH, 1)];
    wangGeLineView.backgroundColor = UIColorFromRGB(0xdddddd);
    [self.mainScrollView addSubview:wangGeLineView];
    
    UILabel * addressLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI,wangGeLineView.frame.origin.y+1, 75*BILI, 60*BILI)];
    addressLable.text = @"位    置:";
    addressLable.textColor = UIColorFromRGB(0x787878);
    addressLable.font = [UIFont systemFontOfSize:15*BILI];
    addressLable.backgroundColor = [UIColor whiteColor];
    [self.mainScrollView addSubview:addressLable];
    
    if (self.info) {
        addressLable.frame = CGRectMake(13*BILI,telLineView.frame.origin.y+1, 75*BILI, 60*BILI);
        wangGeButton.hidden = YES;
    }
    
    self.addressTextView = [[UITextView alloc] initWithFrame:CGRectMake(addressLable.frame.origin.x+addressLable.frame.size.width, addressLable.frame.origin.y, VIEW_WIDTH-(mingChengLable.frame.origin.x+mingChengLable.frame.size.width)-13*BILI, 60*BILI)];
    self.addressTextView.font = [UIFont systemFontOfSize:16*BILI];
    self.addressTextView.textColor = UIColorFromRGB(0x787878);
    self.addressTextView.text = self.detailAddress;
    self.addressTextView.delegate = self;
    self.addressTextView.backgroundColor = [UIColor whiteColor];
    [self.mainScrollView addSubview:self.addressTextView];
    
    if (self.info) {
        self.addressTextView.editable = NO;
  }
    
    UIView * addressineView  = [[UIView alloc] initWithFrame:CGRectMake(0, addressLable.frame.origin.y+addressLable.frame.size.height, VIEW_WIDTH, 1)];
    addressineView.backgroundColor = UIColorFromRGB(0xdddddd);
    [self.mainScrollView addSubview:addressineView];
    
    UILabel * riQiLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, addressineView.frame.origin.y+1, 75*BILI, 50*BILI)];
    riQiLable.textColor =UIColorFromRGB(0x787878);
    riQiLable.font = [UIFont systemFontOfSize:16*BILI];
    riQiLable.text = @"走访日期:";
    [self.mainScrollView addSubview:riQiLable];
    
    NSDictionary * dataDic = [Common getNowDateAndWeek];
    self.riQiLable = [[UILabel alloc] initWithFrame:CGRectMake(riQiLable.frame.origin.x+riQiLable.frame.size.width, riQiLable.frame.origin.y, self.addressTextView.frame.size.width, 50*BILI)];
    self.riQiLable.textColor =UIColorFromRGB(0x787878);
    self.riQiLable.font = [UIFont systemFontOfSize:16*BILI];
    self.riQiLable.text = [NSString stringWithFormat:@"%@-%@-%@",[dataDic objectForKey:@"year"],[dataDic objectForKey:@"month"],[dataDic objectForKey:@"day"]];
    [self.mainScrollView addSubview:self.riQiLable];
    
    UIView * riQiLableLineView = [[UIView alloc] initWithFrame:CGRectMake(0, riQiLable.frame.origin.y+riQiLable.frame.size.height, VIEW_WIDTH, 1)];
    riQiLableLineView.backgroundColor = UIColorFromRGB(0xEEF1F5);
    [self.mainScrollView addSubview:riQiLableLineView];
    
    UILabel * fenLeiLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, riQiLableLineView.frame.origin.y+1, 75*BILI, 50*BILI)];
    fenLeiLable.textColor =UIColorFromRGB(0x787878);
    fenLeiLable.font = [UIFont systemFontOfSize:16*BILI];
    fenLeiLable.text = @"隐患分类:";
    [self.mainScrollView addSubview:fenLeiLable];
    
    self.fenLeiLable = [[UILabel alloc] initWithFrame:CGRectMake(fenLeiLable.frame.origin.x+fenLeiLable.frame.size.width, fenLeiLable.frame.origin.y, self.addressTextView.frame.size.width, 50*BILI)];
    self.fenLeiLable.textColor =UIColorFromRGB(0x787878);
    self.fenLeiLable.font = [UIFont systemFontOfSize:16*BILI];
    self.fenLeiLable.text = @"无";
    [self.mainScrollView addSubview:self.fenLeiLable];
    
    UIButton * fenLeiButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-50, self.fenLeiLable.frame.origin.y, 50, 50*BILI)];
    [fenLeiButton setImage:[UIImage imageNamed:@"xia_jiantou"] forState:UIControlStateNormal];
    [fenLeiButton addTarget:self action:@selector(yinHuanFenLeiButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:fenLeiButton];
    
    
    UIView * fenLeiLableLineView = [[UIView alloc] initWithFrame:CGRectMake(0, fenLeiLable.frame.origin.y+fenLeiLable.frame.size.height, VIEW_WIDTH, 1)];
    fenLeiLableLineView.backgroundColor = UIColorFromRGB(0xEEF1F5);
    [self.mainScrollView addSubview:fenLeiLableLineView];
    
    UILabel * neiRongLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, fenLeiLableLineView.frame.origin.y+1, 75*BILI, 100*BILI)];
    neiRongLable.textColor =UIColorFromRGB(0x787878);
    neiRongLable.font = [UIFont systemFontOfSize:16*BILI];
    neiRongLable.text = @"巡查内容:";
    [self.mainScrollView addSubview:neiRongLable];
    
    self.neiRongTextView = [[UITextView alloc] initWithFrame:CGRectMake(neiRongLable.frame.origin.x+neiRongLable.frame.size.width, neiRongLable.frame.origin.y, self.addressTextView.frame.size.width, 100*BILIY)];
    self.neiRongTextView.font = [UIFont systemFontOfSize:16*BILI];
    self.neiRongTextView.zw_placeHolder = @"巡查内容...";
    self.neiRongTextView.textColor = UIColorFromRGB(0x787878);
    self.neiRongTextView.delegate = self;
    self.neiRongTextView.tag = 101;
    [self.mainScrollView addSubview:self.neiRongTextView];
    
    UIButton * startButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-50*BILI-13*BILI, self.neiRongTextView.frame.origin.y+self.neiRongTextView.frame.size.height+10*BILIY, 50*BILI, 50*BILI)];
    [startButton addTarget:self action:@selector(startBtnHandler) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:startButton];
    
    UIImageView * huaTongImageView = [[UIImageView alloc] initWithFrame:CGRectMake((50-21/1.5)*BILI/2, (50-32/1.5)*BILI/2, 21*BILI/1.5, 32*BILI/1.5)];
    huaTongImageView.image = [UIImage imageNamed:@"huatong_gray"];
    [startButton addSubview:huaTongImageView];
    
    UIView * neiRongLineView = [[UIView alloc] initWithFrame:CGRectMake(0, startButton.frame.origin.y+startButton.frame.size.height+5*BILI, VIEW_WIDTH, 1)];
    neiRongLineView.backgroundColor = UIColorFromRGB(0xEEF1F5);
    [self.mainScrollView addSubview:neiRongLineView];
    
    UILabel * shiFouJieJueLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, neiRongLineView.frame.origin.y+1, 75*BILI, 50*BILI)];
    shiFouJieJueLable.textColor =UIColorFromRGB(0x787878);
    shiFouJieJueLable.font = [UIFont systemFontOfSize:16*BILI];
    shiFouJieJueLable.text = @"是否解决:";
    [self.mainScrollView addSubview:shiFouJieJueLable];
    
    UISwitch *switchButton = [[UISwitch alloc] initWithFrame:CGRectMake(VIEW_WIDTH-53*BILI, neiRongLineView.frame.origin.y+12*BILI, 20*BILI, 10*BILI)];
    [switchButton setOn:NO];
    [switchButton addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    [self.mainScrollView addSubview:switchButton];
    
    UIView * shiFouChuLiLineView = [[UIView alloc] initWithFrame:CGRectMake(0, shiFouJieJueLable.frame.origin.y+shiFouJieJueLable.frame.size.height, VIEW_WIDTH, 1)];
    shiFouChuLiLineView.backgroundColor = UIColorFromRGB(0xEEF1F5);
    [self.mainScrollView addSubview:shiFouChuLiLineView];
    
    UILabel * pingGuLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, shiFouChuLiLineView.frame.origin.y+shiFouChuLiLineView.frame.size.height, 75*BILI, 50*BILI)];
    pingGuLable.textColor =UIColorFromRGB(0x787878);
    pingGuLable.font = [UIFont systemFontOfSize:16*BILI];
    pingGuLable.text = @"效果评估:";
    [self.mainScrollView addSubview:pingGuLable];
    
    self.tipButtonArray = [NSMutableArray array];
    
    float buttonWidth = (self.mainScrollView.frame.size.width-(pingGuLable.frame.origin.x+120*BILI)-30*BILI)/4;
    
    for (int i=0; i<4; i++) {
        
        UIButton * tipButton = [[UIButton alloc] initWithFrame:CGRectMake(pingGuLable.frame.origin.x+90*BILI+(buttonWidth+10*BILI)*i, shiFouChuLiLineView.frame.origin.y+15*BILI, buttonWidth, 20*BILI)];
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
        [self.mainScrollView addSubview:tipButton];
        
    }
    
    
    UIView * pingGULable1LineView = [[UIView alloc] initWithFrame:CGRectMake(0, pingGuLable.frame.origin.y+pingGuLable.frame.size.height, VIEW_WIDTH, 1)];
    pingGULable1LineView.backgroundColor = UIColorFromRGB(0xEEF1F5);
    [self.mainScrollView addSubview:pingGULable1LineView];
    
    self.imageContentView = [[UIView alloc] initWithFrame:CGRectMake(13*BILI, pingGULable1LineView.frame.origin.y+5*BILI, VIEW_WIDTH-26*BILI, 0)];
    self.imageContentView.backgroundColor = [UIColor whiteColor];
    [self.mainScrollView addSubview:self.imageContentView];
    
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
    
    
    [self.mainScrollView setContentSize: CGSizeMake(VIEW_WIDTH, self.imageContentView.frame.origin.y+self.imageContentView.frame.size.height+50*BILI)];
    
    if (alsoScroll) {
        
        CGPoint bottomOffset = CGPointMake(0, self.mainScrollView.contentSize.height - self.mainScrollView.bounds.size.height);
        [self.mainScrollView setContentOffset:bottomOffset animated:YES];

    }
    else
    {
        alsoScroll = YES;
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
    
    if (selectButton.tag==0) {

        self.manYiType = @"01";
        
    }else if (selectButton.tag==1)
    {
        self.manYiType = @"02";
    }
    else if (selectButton.tag==2)
    {
        self.manYiType = @"03";
    }
    else if (selectButton.tag==3)
    {
        self.manYiType = @"04";
    }
}
-(void)switchAction:(id)sender
{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        self.shiFouJieJue = @"1";
    }else {
        self.shiFouJieJue = @"0";
    }
}
-(void)wangGeButtonClick
{
    NSArray * array = [Common getGridlist];
    if (array.count>0)
    {
        [self initFenLei:@"wangGe"];
    }
    
}
-(void)yinHuanFenLeiButtonClick
{
    [self initFenLei:@"yinHuan"];
}
-(void)initFenLei:(NSString *)type
{
    self.shiJianType = type;
   
    [self.mingChengTextField resignFirstResponder];
    [self.fuZeRenTextField resignFirstResponder];
    [self.telTextField resignFirstResponder];
    [self.addressTextView resignFirstResponder];
    [self.neiRongTextView resignFirstResponder];
    [self.fenLeiView removeFromSuperview];
    
    [self.mainScrollView setContentOffset:CGPointMake(0, 0)];
    
    if (alsoShouFeiLei)
    {
        alsoShouFeiLei = NO;
        [self.fenLeiView removeFromSuperview];
    }
    else
    {
        alsoShouFeiLei = YES;
        
        if ([@"wangGe" isEqualToString:type])
        {
            self.fenLeiArray = [Common getGridlist];
            
            self.fenLeiView = [[UIView alloc] initWithFrame:CGRectMake(VIEW_WIDTH-113*BILI, self.suoShuWangGeLable.frame.origin.y+self.suoShuWangGeLable.frame.size.height, 100*BILI, self.fenLeiArray.count*35*BILI)];
            self.fenLeiView.backgroundColor = UIColorFromRGB(0x787878);
            self.fenLeiView.layer.cornerRadius = 4*BILI;
            self.fenLeiView.layer.borderWidth = 1;
            self.fenLeiView.layer.borderColor = [[UIColor whiteColor] CGColor];
            [self.mainScrollView addSubview:self.fenLeiView];
            
        }
        else
        {
            self.fenLeiView = [[UIView alloc] initWithFrame:CGRectMake(VIEW_WIDTH-113*BILI, self.fenLeiLable.frame.origin.y+self.fenLeiLable.frame.size.height, 100*BILI, 7*35*BILI)];
            self.fenLeiView.backgroundColor = UIColorFromRGB(0x787878);
            self.fenLeiView.layer.cornerRadius = 4*BILI;
            self.fenLeiView.layer.borderWidth = 1;
            self.fenLeiView.layer.borderColor = [[UIColor whiteColor] CGColor];
            [self.mainScrollView addSubview:self.fenLeiView];
            self.fenLeiArray = [[NSArray alloc] initWithObjects:@"无",@"火灾隐患",@"治安隐患",@"矛盾纠纷隐患",@"危化品隐患",@"疾病传染隐患",@"其他", nil];
        }
        
       
        
        
        for (int i=0; i<self.fenLeiArray.count; i++) {
            
            UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 35*BILI*i, self.fenLeiView.frame.size.width, 35*BILI)];
            if ([@"wangGe" isEqualToString:self.shiJianType])
            {
                NSDictionary * info = [self.fenLeiArray objectAtIndex:i];
                 [button setTitle:[info objectForKey:@"netGridName"] forState:UIControlStateNormal];
            }
            else
            {
            [button setTitle:[self.fenLeiArray objectAtIndex:i] forState:UIControlStateNormal];
            }
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:14*BILI];
            [button addTarget:self action:@selector(fenLeiButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = i;
            [self.fenLeiView addSubview:button];
            
            if (i!=self.fenLeiArray.count-1)
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
    [self.fenLeiView removeFromSuperview];
    UIButton * button = (UIButton *)sender;
    if([@"wangGe" isEqualToString:self.shiJianType])
    {
        NSDictionary * info = [self.fenLeiArray objectAtIndex:button.tag];
        
        self.suoShuWangGeLable.text = [info objectForKey:@"netGridName"];
        self.grid = [info objectForKey:@"netGridId"];
    }
    else
    {
        self.fenLeiLable.text = [self.fenLeiArray objectAtIndex:button.tag];
        if (button.tag==0) {
            
            self.risktype = @"01";
        }
        else if (button.tag==1)
        {
            self.risktype = @"02";
        }
        else if (button.tag==2)
        {
            self.risktype = @"03";
        }
        else if (button.tag==3)
        {
            self.risktype = @"04";
        }
        else if (button.tag==4)
        {
            self.risktype = @"05";
        }
        else if (button.tag==5)
        {
            self.risktype = @"06";
        }
        else if (button.tag==6)
        {
            self.risktype = @"99";
        }
    }
    
}
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [self.fenLeiView removeFromSuperview];
    return YES;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.tag==100) {
        
        [self.mingChengTextField resignFirstResponder];
        [self.fuZeRenTextField resignFirstResponder];
        [self.telTextField resignFirstResponder];
        [self.addressTextView resignFirstResponder];
        [self.neiRongTextView resignFirstResponder];

    }
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
     [self.fenLeiView removeFromSuperview];
    return YES;
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
-(void)deleteImageButtonClick:(id)sender
{
    
    UIButton * button = (UIButton *)sender;
    [self.imageArray removeObjectAtIndex:button.tag];
    [self initImageContentView];
}
-(void)addMediaButtonClick
{
    [self.mingChengTextField resignFirstResponder];
    [self.fuZeRenTextField resignFirstResponder];
    [self.telTextField resignFirstResponder];
    [self.addressTextView resignFirstResponder];
    [self.neiRongTextView resignFirstResponder];
    
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

-(void)tiJiaoButtonClick
{
    if (self.mingChengTextField.text.length==0) {
        
        [Common showToastView:@"请填写场所名称" view:self.view];
        return;
    }
    if (self.fuZeRenTextField.text.length==0) {
        
        [Common showToastView:@"请填写负责人" view:self.view];
        return;
    }
    if (self.telTextField.text.length==0) {
        
        [Common showToastView:@"请填联系电话" view:self.view];
        return;
    }
    if (self.neiRongTextView.text.length == 0) {
        
        [Common showToastView:@"请填写巡查内容" view:self.view];
        return;
    }
    if (self.detailAddress==nil) {
        
        [Common showToastView:@"无法获取到当前位置信息,不能进行提交" view:self.view];
        return;
    }
    
    [self showNewLoadingView:nil view:nil];
    
    if (self.imageArray.count>0) {
        
        [self uploadImage];
    }
    else
    {
        
        NSDictionary * dataDic = [Common getNowDateAndWeek];
        if (self.info)
        {
           
            [self.cloudClient zhongDianChangSuoXunChaShangBao:@"patrolVisits!patrolAdd.do"
                                                       dataid:[self.info objectForKey:@"dataid"]
                                                 locataddress:self.detailAddress
                                                   patroldate:[NSString stringWithFormat:@"%@-%@-%@",[dataDic objectForKey:@"year"],[dataDic objectForKey:@"month"],[dataDic objectForKey:@"day"]]
                                                patrolcontent:self.neiRongTextView.text
                                                  resolveflag:self.shiFouJieJue
                                                     risktype:self.risktype
                                                     xgpgcode:self.manYiType
                                                          lot:[NSString stringWithFormat:@"%f",oldCoordinate.longitude]
                                                          lat:[NSString stringWithFormat:@"%f",oldCoordinate.latitude]
                                                       imgids:@""
                                                     delegate:self
                                                     selector:@selector(tiJiaoSuccess:)
                                                errorSelector:@selector(tiJiaoError:)];
        }
        else
        {

            
            [self.cloudClient yiBanChangSuoXunChaShangBao:@"patrolVisits!ybPatrolAdd.do"
                                                   gridid:self.grid
                                                placename:self.mingChengTextField.text
                                              placeheader:self.fuZeRenTextField.text
                                                headertel:self.telTextField.text
                                             placeaddress:self.detailAddress
                                             locataddress:self.detailAddress
                                               patroldate:[NSString stringWithFormat:@"%@-%@-%@",[dataDic objectForKey:@"year"],[dataDic objectForKey:@"month"],[dataDic objectForKey:@"day"]]
                                            patrolcontent:self.neiRongTextView.text
                                              resolveflag:self.shiFouJieJue
                                                 risktype:self.risktype
                                                 xgpgcode:self.manYiType
                                                      lot:[NSString stringWithFormat:@"%f",oldCoordinate.longitude]
                                                      lat:[NSString stringWithFormat:@"%f",oldCoordinate.latitude]
                                                   imgids:@""
                                                 delegate:self
                                                 selector:@selector(tiJiaoSuccess:)
                                            errorSelector:@selector(tiJiaoError:)];
        }
        
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
        if (self.info)
        {
            
            [self.cloudClient zhongDianChangSuoXunChaShangBao:@"patrolVisits!patrolAdd.do"
                                                       dataid:[self.info objectForKey:@"dataid"]
                                                 locataddress:self.detailAddress
                                                   patroldate:[NSString stringWithFormat:@"%@-%@-%@",[dataDic objectForKey:@"year"],[dataDic objectForKey:@"month"],[dataDic objectForKey:@"day"]]
                                                patrolcontent:self.neiRongTextView.text
                                                  resolveflag:self.shiFouJieJue
                                                     risktype:self.risktype
                                                     xgpgcode:self.manYiType
                                                          lot:[NSString stringWithFormat:@"%f",oldCoordinate.longitude]
                                                          lat:[NSString stringWithFormat:@"%f",oldCoordinate.latitude]
                                                       imgids:self.imageIdStr
                                                     delegate:self
                                                     selector:@selector(tiJiaoSuccess:)
                                                errorSelector:@selector(tiJiaoError:)];
        }
        else
        {

            [self.cloudClient yiBanChangSuoXunChaShangBao:@"patrolVisits!ybPatrolAdd.do"
                                                   gridid:self.grid
                                                placename:self.mingChengTextField.text
                                              placeheader:self.fuZeRenTextField.text
                                                headertel:self.telTextField.text
                                             placeaddress:self.detailAddress
                                             locataddress:self.detailAddress
                                               patroldate:[NSString stringWithFormat:@"%@-%@-%@",[dataDic objectForKey:@"year"],[dataDic objectForKey:@"month"],[dataDic objectForKey:@"day"]]
                                            patrolcontent:self.neiRongTextView.text
                                              resolveflag:self.shiFouJieJue
                                                 risktype:self.risktype
                                                 xgpgcode:self.manYiType
                                                      lot:[NSString stringWithFormat:@"%f",oldCoordinate.longitude]
                                                      lat:[NSString stringWithFormat:@"%f",oldCoordinate.latitude]
                                                   imgids:self.imageIdStr
                                                 delegate:self
                                                 selector:@selector(tiJiaoSuccess:)
                                            errorSelector:@selector(tiJiaoError:)];
        }
       
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
    
    _neiRongTextView.text = [NSString stringWithFormat:@"%@%@", _neiRongTextView.text,resultFromJson];
    
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
