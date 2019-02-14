//
//  BaoGaoDetailViewController.m
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/14.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BaoGaoDetailViewController.h"

@interface BaoGaoDetailViewController ()

@end

@implementation BaoGaoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLale.textColor = [UIColor whiteColor];
    self.titleLale.text = @"报告详情";
    self.cloudClient = [CloudClient getInstance];
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT-(self.navView.frame.origin.y+self.navView.frame.size.height))];
    self.mainScrollView.showsVerticalScrollIndicator = NO;
    self.mainScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.mainScrollView];
    
    if (![@"baoGaoList" isEqualToString:self.fromWhere])
    {
        
        UIButton * ruHuZouFangButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-64*BILI-20*BILI, VIEW_HEIGHT-64*BILI-30*BILI, 64*BILI, 64*BILI)];
        [ruHuZouFangButton setBackgroundImage:[UIImage imageNamed:@"ruHuZouFang"] forState:UIControlStateNormal];
        [ruHuZouFangButton addTarget:self action:@selector(chuLiButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:ruHuZouFangButton];
        
        UILabel * ruHuZouFangLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 36*BILI, 64*BILI, 14*BILI)];
        ruHuZouFangLable.font = [UIFont systemFontOfSize:6*BILI];
        ruHuZouFangLable.textAlignment = NSTextAlignmentCenter;
        ruHuZouFangLable.text = @"处理";
        ruHuZouFangLable.textColor = [UIColor whiteColor];
        [ruHuZouFangButton addSubview:ruHuZouFangLable];
    }

   
        [self showNewLoadingView:nil view:self.view];
        [self.cloudClient baoGaoDeetailMes:@"eventInfo!view.do"
                                   eventid:self.eventid
                                  delegate:self
                                  selector:@selector(getMesSuccess:)
                             errorSelector:@selector(getMesError:)];
    
    
    
    
    
    
    
    
}
-(void)getMesSuccess:(NSDictionary *)info
{
    [self hideNewLoadingView];
    self.info = info;
    [self initView:info];
}
-(void)initView:(NSDictionary *)info
{
    ///////////////////////事件名称
    UILabel * nameLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, 0, VIEW_WIDTH, 50*BILI)];
    nameLable.textColor = UIColorFromRGB(0x4A4A4A);
    nameLable.font = [UIFont systemFontOfSize:18*BILI];
    nameLable.text = @"事件名称:  无";
    nameLable.text = [NSString stringWithFormat:@"事件名称:  %@",[info objectForKey:@"title"]];
    [self.mainScrollView addSubview:nameLable];
    
    UIView * nameLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50*BILI-1, VIEW_WIDTH-26*BILI, 1)];
    nameLineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [nameLable addSubview:nameLineView];
    
    //////////////////////网格名称
    
    UILabel * wangGeTipLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, nameLable.frame.origin.y+nameLable.frame.size.height, 200, 50*BILI)];
    wangGeTipLable.textColor = UIColorFromRGB(0x4A4A4A);
    wangGeTipLable.font = [UIFont systemFontOfSize:18*BILI];
    wangGeTipLable.text = @"网格名称: ";
    [self.mainScrollView addSubview:wangGeTipLable];

    
    UILabel * sexLable = [[UILabel alloc] initWithFrame:CGRectMake(100*BILI, nameLable.frame.origin.y+nameLable.frame.size.height, VIEW_WIDTH-113*BILI, 50*BILI)];
    sexLable.textColor = UIColorFromRGB(0x4A4A4A);
    sexLable.font = [UIFont systemFontOfSize:18*BILI];
    sexLable.numberOfLines = 2;
    sexLable.text = [NSString stringWithFormat:@"%@",[info objectForKey:@"gridname"]];
    [self.mainScrollView addSubview:sexLable];
    
    UIView * sexLineView = [[UIView alloc] initWithFrame:CGRectMake(-97, 50*BILI-1, VIEW_WIDTH-26*BILI, 1)];
    sexLineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [sexLable addSubview:sexLineView];
    
    
    //////////////////////网格员姓名[15]    (null)    @"membername" : @"刘春花"
    UILabel * telLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, sexLable.frame.origin.y+sexLable.frame.size.height, VIEW_WIDTH, 50*BILI)];
    telLable.textColor = UIColorFromRGB(0x4A4A4A);
    telLable.font = [UIFont systemFontOfSize:18*BILI];
    telLable.text = [NSString stringWithFormat:@"网格员姓名:  %@",[info objectForKey:@"membername"]];
    [self.mainScrollView addSubview:telLable];
    
    self.membertel = [info objectForKey:@"membertel"];
    
    UIButton * telButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-60*BILI, telLable.frame.origin.y, 50*BILI, 50*BILI)];
    [telButton addTarget:self action:@selector(telButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:telButton];
    
    UIImageView * telImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15*BILI, 15*BILI, 20*BILI, 20*BILI)];
    telImageView.image = [UIImage imageNamed:@"dianhua"];
    [telButton addSubview:telImageView];

    
    UIView * telLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50*BILI-1, VIEW_WIDTH-26*BILI, 1)];
    telLineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [telLable addSubview:telLineView];
    
    //////////////////////事件分类
    UILabel * sfzLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, telLable.frame.origin.y+telLable.frame.size.height, VIEW_WIDTH, 50*BILI)];
    sfzLable.textColor = UIColorFromRGB(0x4A4A4A);
    sfzLable.font = [UIFont systemFontOfSize:18*BILI];
    sfzLable.text = @"事件分类:  农村集体土地征用流转";
    sfzLable.text = [NSString stringWithFormat:@"事件分类:  %@",[info objectForKey:@"eventtype"]];
    [self.mainScrollView addSubview:sfzLable];
    
    UIView * sfzLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50*BILI-1, VIEW_WIDTH-26*BILI, 1)];
    sfzLineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [sfzLable addSubview:sfzLineView];
    
    
    //////////////////////时间规模
    UILabel * shengRiLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, sfzLable.frame.origin.y+sfzLable.frame.size.height, VIEW_WIDTH, 50*BILI)];
    shengRiLable.textColor = UIColorFromRGB(0x4A4A4A);
    shengRiLable.font = [UIFont systemFontOfSize:18*BILI];
    shengRiLable.text = @"时间规模:  一般群体性事件";
    shengRiLable.text = [NSString stringWithFormat:@"时间规模:  %@",[info objectForKey:@"eventscope"]];

    [self.mainScrollView addSubview:shengRiLable];
    
    UIView * shengRiLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50*BILI-1, VIEW_WIDTH-26*BILI, 1)];
    shengRiLineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [shengRiLable addSubview:shengRiLineView];
    
    
    //////////////////////事件级别
    UILabel * minZuLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, shengRiLable.frame.origin.y+shengRiLable.frame.size.height, VIEW_WIDTH, 50*BILI)];
    minZuLable.textColor = UIColorFromRGB(0x4A4A4A);
    minZuLable.font = [UIFont systemFontOfSize:18*BILI];
    minZuLable.text = @"事件级别:  重大";
    minZuLable.text = [NSString stringWithFormat:@"事件级别:  %@",[info objectForKey:@"eventlevel"]];

    [self.mainScrollView addSubview:minZuLable];
    
    UIView * mianZuLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50*BILI-1, VIEW_WIDTH-26*BILI, 1)];
    mianZuLineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [minZuLable addSubview:mianZuLineView];
    
    
    //////////////////////事件性质
    UILabel * jiGuanLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, minZuLable.frame.origin.y+minZuLable.frame.size.height, VIEW_WIDTH, 50*BILI)];
    jiGuanLable.textColor = UIColorFromRGB(0x4A4A4A);
    jiGuanLable.font = [UIFont systemFontOfSize:18*BILI];
    jiGuanLable.text = @"事件性质:  治安";
    jiGuanLable.text = [NSString stringWithFormat:@"事件性质:  %@",[info objectForKey:@"eventnature"]];
    [self.mainScrollView addSubview:jiGuanLable];
    
    UIView * jiGuanLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50*BILI-1, VIEW_WIDTH-26*BILI, 1)];
    jiGuanLineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [jiGuanLable addSubview:jiGuanLineView];
    
    
    //////////////////////所在位置
    UILabel * xiangQingLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI,jiGuanLable.frame.origin.y+jiGuanLable.frame.size.height, 75*BILI, 70*BILI)];
    xiangQingLable.text = @"所在位置:";
    xiangQingLable.textColor = UIColorFromRGB(0x4A4A4A);
    xiangQingLable.font = [UIFont systemFontOfSize:16*BILI];
    [self.mainScrollView addSubview:xiangQingLable];
    
    UILabel * xiangQingDetailLable = [[UILabel alloc] initWithFrame:CGRectMake(xiangQingLable.frame.origin.x+xiangQingLable.frame.size.width, xiangQingLable.frame.origin.y, VIEW_WIDTH-(xiangQingLable.frame.origin.x+xiangQingLable.frame.size.width)-13*BILI, 70*BILI)];
    xiangQingDetailLable.font = [UIFont systemFontOfSize:16*BILI];
    xiangQingDetailLable.textColor = UIColorFromRGB(0x4A4A4A);
    xiangQingDetailLable.text = [info objectForKey:@"eventaddress"];
    xiangQingDetailLable.numberOfLines = 2;
    xiangQingDetailLable.adjustsFontSizeToFitWidth = YES;
    [self.mainScrollView addSubview:xiangQingDetailLable];
    
    UIView * huiYinLineView = [[UIView alloc] initWithFrame:CGRectMake(13*BILI, xiangQingDetailLable.frame.origin.y+xiangQingDetailLable.frame.size.height, VIEW_WIDTH-26*BILI, 1)];
    huiYinLineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [self.mainScrollView addSubview:huiYinLineView];
    
    
    //////////////////////发生时间
    UILabel * zhengZhiMianMaoLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, xiangQingDetailLable.frame.origin.y+xiangQingDetailLable.frame.size.height, VIEW_WIDTH, 50*BILI)];
    zhengZhiMianMaoLable.textColor = UIColorFromRGB(0x4A4A4A);
    zhengZhiMianMaoLable.font = [UIFont systemFontOfSize:18*BILI];
    zhengZhiMianMaoLable.text = @"发生时间:  2018-05-29 10:50";
    zhengZhiMianMaoLable.text = [NSString stringWithFormat:@"发生时间:  %@",[info objectForKey:@"happenddate"]];
    [self.mainScrollView addSubview:zhengZhiMianMaoLable];
    
    UIView * zhengZhiMianMaLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50*BILI-1, VIEW_WIDTH-26*BILI, 1)];
    zhengZhiMianMaLineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [zhengZhiMianMaoLable addSubview:zhengZhiMianMaLineView];
    
    //////////////////////事件内容
    UILabel * shiJianLeirongLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, zhengZhiMianMaoLable.frame.origin.y+zhengZhiMianMaoLable.frame.size.height, VIEW_WIDTH, 50*BILI)];
    shiJianLeirongLable.textColor = UIColorFromRGB(0x4A4A4A);
    shiJianLeirongLable.font = [UIFont systemFontOfSize:18*BILI];
    shiJianLeirongLable.text = @"事件内容:  没事转转";
    shiJianLeirongLable.numberOfLines = 0;
    NSString * messageStr =  [NSString stringWithFormat:@"事件内容:  %@",[info objectForKey:@"content"]];
    
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:messageStr];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:3];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [messageStr length])];
    [shiJianLeirongLable setAttributedText:attributedString1];
    [shiJianLeirongLable sizeToFit];
    shiJianLeirongLable.lineBreakMode = NSLineBreakByTruncatingTail;
    
    if (shiJianLeirongLable.frame.size.height<50*BILI) {
        
        shiJianLeirongLable.frame = CGRectMake(13*BILI, zhengZhiMianMaoLable.frame.origin.y+zhengZhiMianMaoLable.frame.size.height, VIEW_WIDTH, 50*BILI);
    }
    
    [self.mainScrollView addSubview:shiJianLeirongLable];

    UIView * shiJianLeirongLineView = [[UIView alloc] initWithFrame:CGRectMake(0, shiJianLeirongLable.frame.size.height-1, VIEW_WIDTH-26*BILI, 1)];
    shiJianLeirongLineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [shiJianLeirongLable addSubview:shiJianLeirongLineView];
    
    float imageWidth = (VIEW_WIDTH-56*BILI)/4;
    
    
    
    self.imageArray = [info objectForKey:@"imglist"];//@"1",@"1",@"1",@"1",@"1"
    for (int i=0; i<self.imageArray.count; i++) {
        CustomImageView * imageView = [[CustomImageView alloc] initWithFrame:CGRectMake(13*BILI+(imageWidth+10*BILI)*(i%4), shiJianLeirongLable.frame.origin.y+shiJianLeirongLable.frame.size.height+3*BILI+(imageWidth+5*BILI)*(i/4), imageWidth, imageWidth)];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.autoresizingMask = UIViewAutoresizingNone;
        imageView.clipsToBounds = YES;
        NSDictionary * info = [self.imageArray objectAtIndex:i];
        imageView.urlPath = [info objectForKey:@"imgurl"];
        imageView.tag = i;
        imageView.userInteractionEnabled = YES;
        [self.mainScrollView addSubview:imageView];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTap:)];
        [imageView addGestureRecognizer:tap];
    }
    int imageLines;
    if (self.imageArray.count%4==0)
    {
        imageLines = (int)self.imageArray.count/4;
    }
    else
    {
        imageLines = (int)self.imageArray.count/4+1;
    }
    UIView * imageLineView = [[UIView alloc] initWithFrame:CGRectMake(13*BILI, shiJianLeirongLable.frame.origin.y+shiJianLeirongLable.frame.size.height+(5*BILI+imageWidth)*imageLines+3*BILI, VIEW_WIDTH-26*BILI, 1)];
    imageLineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [self.mainScrollView addSubview:imageLineView];
    [self.mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH, imageLineView.frame.origin.y+1)];
    
    float y ;
    if (self.imageArray.count==0)
    {
        imageLineView.hidden = YES;
        y = shiJianLeirongLable.frame.origin.y+shiJianLeirongLable.frame.size.height+3*BILI;
    }
    else
    {
        y = imageLineView.frame.origin.y+imageLineView.frame.size.height+3*BILI;
    }
    
    NSArray * sysList = [info objectForKey:@"sylist"];
    
    for (NSDictionary * info in sysList) {
        
        UILabel * jiBieLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, y, VIEW_WIDTH-26*BILI, 30*BILI)];
        jiBieLable.textColor = UIColorFromRGB(0x4A4A4A);
        jiBieLable.font = [UIFont systemFontOfSize:18*BILI];
        jiBieLable.text = [NSString stringWithFormat:@"审阅网格级别: %@",[info objectForKey:@"sylevel"]];
        [self.mainScrollView addSubview:jiBieLable];
        
        UILabel * shenYueRenLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, jiBieLable.frame.origin.y+jiBieLable.frame.size.height, VIEW_WIDTH-26*BILI, 30*BILI)];
        shenYueRenLable.textColor = UIColorFromRGB(0x4A4A4A);
        shenYueRenLable.font = [UIFont systemFontOfSize:18*BILI];
        shenYueRenLable.text = [NSString stringWithFormat:@"审阅人: %@",[info objectForKey:@"syuser"]];;
        [self.mainScrollView addSubview:shenYueRenLable];
        
        UILabel * timeLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, shenYueRenLable.frame.origin.y+shenYueRenLable.frame.size.height, VIEW_WIDTH-26*BILI, 30*BILI)];
        timeLable.textColor = UIColorFromRGB(0x4A4A4A);
        timeLable.font = [UIFont systemFontOfSize:18*BILI];
        timeLable.text = [NSString stringWithFormat:@"审阅日期: %@",[info objectForKey:@"sydate"]];
        [self.mainScrollView addSubview:timeLable];
        
        UILabel * yiJianLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, timeLable.frame.origin.y+timeLable.frame.size.height, VIEW_WIDTH-26*BILI, 30*BILI)];
        yiJianLable.textColor = UIColorFromRGB(0x4A4A4A);
        yiJianLable.font = [UIFont systemFontOfSize:18*BILI];
        yiJianLable.numberOfLines = 0;
        [self.mainScrollView addSubview:yiJianLable];
        
        NSString * messageStr = [NSString stringWithFormat:@"审阅意见: %@",[info objectForKey:@"syidea"]];
        
        NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:messageStr];
        NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle1 setLineSpacing:6];
        [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [messageStr length])];
        [yiJianLable setAttributedText:attributedString1];
        [yiJianLable sizeToFit];
        yiJianLable.lineBreakMode = NSLineBreakByTruncatingTail;

        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(13*BILI, yiJianLable.frame.origin.y+yiJianLable.frame.size.height+3*BILI, VIEW_WIDTH-26*BILI, 1)];
        lineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
        [self.mainScrollView addSubview:lineView];

        y = lineView.frame.origin.y+lineView.frame.size.height;
        
    }
    NSArray * tracklist = [info objectForKey:@"tracklist"];
    
    for (NSDictionary * info in tracklist) {
        
        UILabel * leiXingLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, y, VIEW_WIDTH-26*BILI, 30*BILI)];
        leiXingLable.textColor = UIColorFromRGB(0x4A4A4A);
        leiXingLable.font = [UIFont systemFontOfSize:18*BILI];
        leiXingLable.text = @"类型:  上报";
        leiXingLable.text = [NSString stringWithFormat:@"类型:  %@",[info objectForKey:@"nodename"]];
        [self.mainScrollView addSubview:leiXingLable];
        
        UILabel * neiRongLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, leiXingLable.frame.origin.y+leiXingLable.frame.size.height, VIEW_WIDTH-26*BILI, 50*BILI)];
        neiRongLable.textColor = UIColorFromRGB(0x4A4A4A);
        neiRongLable.font = [UIFont systemFontOfSize:18*BILI];
        //[neiRongLable sizeToFit];
        neiRongLable.numberOfLines = 0;
        [self.mainScrollView addSubview:neiRongLable];
        
        NSString * messageStr = [NSString stringWithFormat:@"内容:  %@",[info objectForKey:@"nodecontent"]];
        
        
        NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:messageStr];
        NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle1 setLineSpacing:6];
        [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [messageStr length])];
        [neiRongLable setAttributedText:attributedString1];
        [neiRongLable sizeToFit];
        neiRongLable.lineBreakMode = NSLineBreakByTruncatingTail;

        
        
        UILabel * timeLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, neiRongLable.frame.origin.y+neiRongLable.frame.size.height, VIEW_WIDTH-26*BILI, 30*BILI)];
        timeLable.textColor = UIColorFromRGB(0x4A4A4A);
        timeLable.font = [UIFont systemFontOfSize:18*BILI];
        timeLable.text = @"日期:  2018-05-29 10:50";
        timeLable.text = [NSString stringWithFormat:@"日期:  %@",[info objectForKey:@"nodetime"]];
        [self.mainScrollView addSubview:timeLable];
        
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(13*BILI, timeLable.frame.origin.y+timeLable.frame.size.height+3*BILI, VIEW_WIDTH-26*BILI, 1)];
        lineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
        [self.mainScrollView addSubview:lineView];
        
        y = lineView.frame.origin.y+lineView.frame.size.height;


    }
    
    [self.mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH, y)];

}
-(void)telButtonClick
{
    NSMutableString* str;
    str = [[NSMutableString alloc]initWithFormat:@"telprompt://%@",[Common getobjectForKey:self.membertel]];
    
    
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:str]];

}
-(void)getMesError:(NSDictionary *)info
{
    [self hideNewLoadingView];
    [Common showToastView:[info objectForKey:@"message"] view:self.view];
}
-(void)chuLiButtonClick
{
    BaoGaoChuLiViewController * vc = [[BaoGaoChuLiViewController alloc] init];
    vc.info = self.info;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)imageViewTap:(UITapGestureRecognizer *)tap
{
    CustomImageView * imageView = (CustomImageView *)tap.view;
    NSMutableArray * photos = [NSMutableArray array];
    for (int i=0; i<self.imageArray.count; i++) {
        
        NSDictionary * info = [self.imageArray objectAtIndex:i];
        MWPhoto * photo = [MWPhoto photoWithURL:[NSURL URLWithString:[info objectForKey:@"imgurl"]]];
        [photos addObject:photo];
    }
    
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithPhotos:photos];
    browser.displayActionButton = NO;
    browser.alwaysShowControls = NO;
    browser.displaySelectionButtons = NO;
    browser.zoomPhotosToFill = YES;
    browser.displayNavArrows = NO;
    browser.startOnGrid = NO;
    browser.enableGrid = YES;
    [browser setCurrentPhotoIndex:imageView.tag];
    [self .navigationController pushViewController:browser animated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
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
