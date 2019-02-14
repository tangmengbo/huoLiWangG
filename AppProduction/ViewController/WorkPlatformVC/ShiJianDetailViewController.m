//
//  ShiJianDetailViewController.m
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/12.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ShiJianDetailViewController.h"

@interface ShiJianDetailViewController ()

@end

@implementation ShiJianDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLale.textColor = [UIColor whiteColor];
    self.titleLale.text = @"事件跟踪";
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT-(self.navView.frame.origin.y+self.navView.frame.size.height))];
    [self.view addSubview:self.mainScrollView];
    
    self.cloudClient = [CloudClient getInstance];
    
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
    
    CustomImageView * imageView = [[CustomImageView alloc] initWithFrame:CGRectMake(13*BILI, 10*BILI, 60*BILI, 60*BILI)];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.autoresizingMask = UIViewAutoresizingNone;
    imageView.clipsToBounds = YES;
    [self.mainScrollView addSubview:imageView];
    
    UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(imageView.frame.origin.x+imageView.frame.size.width+10*BILI, 20*BILI, VIEW_WIDTH-(imageView.frame.origin.x+imageView.frame.size.width+10*BILI+13*BILI), 17*BILI)];
    titleLable.font = [UIFont systemFontOfSize:16*BILI];
    titleLable.textColor = UIColorFromRGB(0x4A4A4A);
    [self.mainScrollView addSubview:titleLable];
    
    UIButton * detailButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-83*BILI, titleLable.frame.origin.y+titleLable.frame.size.height+9*BILI, 70*BILI, 25*BILI)];
    detailButton.backgroundColor = [UIColor whiteColor];
    detailButton.layer.borderWidth = 1;

    detailButton.layer.borderColor = [UIColorFromRGB(0x5077AA) CGColor];
    detailButton.layer.cornerRadius = 4*BILI;
    [detailButton setTitle:@"详情" forState:UIControlStateNormal];
    [detailButton setTitleColor:UIColorFromRGB(0x5077AA) forState:UIControlStateNormal];
    detailButton.titleLabel.font = [UIFont systemFontOfSize:14*BILI];
    [detailButton addTarget:self action:@selector(zhanKaiButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:detailButton];
    
    titleLable.text = [NSString stringWithFormat:@"事件名称:%@",[info objectForKey:@"title"]];
    
    self.imageArray = [info objectForKey:@"imglist"];
    if (self.imageArray.count>0) {
        
        NSDictionary * info = [self.imageArray objectAtIndex:0];
        imageView.urlPath = [info objectForKey:@"imgurl"];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTap)];
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:tap];
    }
    
    
    self.shiJianContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 80*BILI, VIEW_WIDTH, 100)];
    self.shiJianContentView.backgroundColor = UIColorFromRGB(0xEEF1F5);
    [self.mainScrollView addSubview:self.shiJianContentView];
    
    UILabel * nameTipLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI,0, 75*BILI, 60*BILI)];
    nameTipLable.text = @"网格名称:";
    nameTipLable.textColor = UIColorFromRGB(0x787878);
    nameTipLable.font = [UIFont systemFontOfSize:16*BILI];
    [self.shiJianContentView addSubview:nameTipLable];
    
    UILabel * nameLable = [[UILabel alloc] initWithFrame:CGRectMake(nameTipLable.frame.origin.x+nameTipLable.frame.size.width, nameTipLable.frame.origin.y, VIEW_WIDTH-(nameTipLable.frame.origin.x+nameTipLable.frame.size.width)-13*BILI, 60*BILI)];
    nameLable.font = [UIFont systemFontOfSize:16*BILI];
    nameLable.textColor = UIColorFromRGB(0x787878);
    nameLable.text = [info objectForKey:@"gridname"];
    nameLable.numberOfLines = 2;
    nameLable.adjustsFontSizeToFitWidth = YES;
    [self.shiJianContentView addSubview:nameLable];
    
    UILabel * wangGeYuanNameLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI,nameLable.frame.origin.y+nameLable.frame.size.height, VIEW_WIDTH-26*BILI, 40*BILI)];
    wangGeYuanNameLable.text = @"网格员姓名:  高玉芬";
    wangGeYuanNameLable.text = [NSString stringWithFormat:@"网格员姓名:  %@",[info objectForKey:@"membername"]];
    wangGeYuanNameLable.textColor = UIColorFromRGB(0x787878);
    wangGeYuanNameLable.font = [UIFont systemFontOfSize:16*BILI];
    [self.shiJianContentView addSubview:wangGeYuanNameLable];
    
    self.membertel = [info objectForKey:@"membertel"];
    UIButton * telButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-60*BILI, wangGeYuanNameLable.frame.origin.y, 40*BILI, 40*BILI)];
    [telButton addTarget:self action:@selector(telButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.shiJianContentView addSubview:telButton];
    
    UIImageView * telImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15*BILI, 10*BILI, 20*BILI, 20*BILI)];
    telImageView.image = [UIImage imageNamed:@"dianhua"];
    [telButton addSubview:telImageView];
    
    UILabel * fenLeiLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI,wangGeYuanNameLable.frame.origin.y+wangGeYuanNameLable.frame.size.height, VIEW_WIDTH-26*BILI, 40*BILI)];
    fenLeiLable.text = @"事件分类:  边界管理";
    fenLeiLable.text = [NSString stringWithFormat:@"事件分类:  %@",[info objectForKey:@"eventtype"]];

    fenLeiLable.textColor = UIColorFromRGB(0x787878);
    fenLeiLable.font = [UIFont systemFontOfSize:16*BILI];
    [self.shiJianContentView addSubview:fenLeiLable];
    
    UILabel * timeLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI,fenLeiLable.frame.origin.y+fenLeiLable.frame.size.height, VIEW_WIDTH-26*BILI, 40*BILI)];
    timeLable.text = @"发生时间:  1990-08-20 12:11";
    timeLable.text = [NSString stringWithFormat:@"发生时间:  %@",[info objectForKey:@"happenddate"]];

    timeLable.textColor = UIColorFromRGB(0x787878);
    timeLable.font = [UIFont systemFontOfSize:16*BILI];
    [self.shiJianContentView addSubview:timeLable];
    
    UILabel * guiMoLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI,timeLable.frame.origin.y+timeLable.frame.size.height, VIEW_WIDTH-26*BILI, 40*BILI)];
    guiMoLable.text = @"事件规模: 一般群体性事件";
    guiMoLable.text = [NSString stringWithFormat:@"事件规模:  %@",[info objectForKey:@"eventscope"]];
    guiMoLable.textColor = UIColorFromRGB(0x787878);
    guiMoLable.font = [UIFont systemFontOfSize:16*BILI];
    [self.shiJianContentView addSubview:guiMoLable];
    
    UILabel * jiBieLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI,guiMoLable.frame.origin.y+guiMoLable.frame.size.height, VIEW_WIDTH-26*BILI, 40*BILI)];
    jiBieLable.text = @"事件级别: 重大";
    jiBieLable.text = [NSString stringWithFormat:@"事件级别: %@",[info objectForKey:@"eventlevel"]];
    jiBieLable.textColor = UIColorFromRGB(0x787878);
    jiBieLable.font = [UIFont systemFontOfSize:16*BILI];
    [self.shiJianContentView addSubview:jiBieLable];
    
    UILabel * xingZhiLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI,jiBieLable.frame.origin.y+jiBieLable.frame.size.height, VIEW_WIDTH-26*BILI, 40*BILI)];
    xingZhiLable.text = @"事件级别: 重大";
    xingZhiLable.text = [NSString stringWithFormat:@"事件性质: %@",[info objectForKey:@"eventnature"]];
    xingZhiLable.textColor = UIColorFromRGB(0x787878);
    xingZhiLable.font = [UIFont systemFontOfSize:16*BILI];
    [self.shiJianContentView addSubview:xingZhiLable];
    
    UILabel * addressLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI,xingZhiLable.frame.origin.y+xingZhiLable.frame.size.height, 75*BILI, 60*BILI)];
    addressLable.text = @"发生位置:";
    addressLable.textColor = UIColorFromRGB(0x787878);
    addressLable.font = [UIFont systemFontOfSize:16*BILI];
    [self.shiJianContentView addSubview:addressLable];
    
    UILabel * addressDetailLable = [[UILabel alloc] initWithFrame:CGRectMake(addressLable.frame.origin.x+addressLable.frame.size.width, addressLable.frame.origin.y, VIEW_WIDTH-(nameTipLable.frame.origin.x+nameTipLable.frame.size.width)-13*BILI, 60*BILI)];
    addressDetailLable.font = [UIFont systemFontOfSize:16*BILI];
    addressDetailLable.textColor = UIColorFromRGB(0x787878);
    addressDetailLable.text = [info objectForKey:@"eventaddress"];
    addressDetailLable.numberOfLines = 2;
    addressDetailLable.adjustsFontSizeToFitWidth = YES;
    [self.shiJianContentView addSubview:addressDetailLable];
    
    UILabel * chuLiFangShiLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI,addressDetailLable.frame.origin.y+addressDetailLable.frame.size.height, VIEW_WIDTH-26*BILI, 40*BILI)];
    chuLiFangShiLable.text = @"处理方式:  ";
    chuLiFangShiLable.text = [NSString stringWithFormat:@"处理方式:  %@",[info objectForKey:@"resolvetype"]];
    chuLiFangShiLable.textColor = UIColorFromRGB(0x787878);
    chuLiFangShiLable.font = [UIFont systemFontOfSize:16*BILI];
    [self.shiJianContentView addSubview:chuLiFangShiLable];
    
    UILabel * xiaoGuoPingGuLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI,chuLiFangShiLable.frame.origin.y+chuLiFangShiLable.frame.size.height, VIEW_WIDTH-26*BILI, 40*BILI)];
    xiaoGuoPingGuLable.text = @"效果评估:  ";
    xiaoGuoPingGuLable.text = [NSString stringWithFormat:@"效果评估:   %@",[info objectForKey:@"xgpg"]];

    xiaoGuoPingGuLable.textColor = UIColorFromRGB(0x787878);
    xiaoGuoPingGuLable.font = [UIFont systemFontOfSize:16*BILI];
    [self.shiJianContentView addSubview:xiaoGuoPingGuLable];
    
    UILabel * chuLJjieGuoLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI,xiaoGuoPingGuLable.frame.origin.y+xiaoGuoPingGuLable.frame.size.height, VIEW_WIDTH-26*BILI, 40*BILI)];
    chuLJjieGuoLable.text = @"处理结果:  ";
    chuLJjieGuoLable.text = [NSString stringWithFormat:@"处理结果:  %@",[info objectForKey:@"results"]];

    chuLJjieGuoLable.textColor = UIColorFromRGB(0x787878);
    chuLJjieGuoLable.font = [UIFont systemFontOfSize:16*BILI];
    [self.shiJianContentView addSubview:chuLJjieGuoLable];
    
    UILabel * chuLiTimeLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI,chuLJjieGuoLable.frame.origin.y+chuLJjieGuoLable.frame.size.height, VIEW_WIDTH-26*BILI, 40*BILI)];
    chuLiTimeLable.text = @"处理时间:  ";
    chuLiTimeLable.text = [NSString stringWithFormat:@"处理时间:  %@",[info objectForKey:@"processdate"]];

    chuLiTimeLable.textColor = UIColorFromRGB(0x787878);
    chuLiTimeLable.font = [UIFont systemFontOfSize:16*BILI];
    [self.shiJianContentView addSubview:chuLiTimeLable];
    
    UILabel * xiangQingLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI,chuLiTimeLable.frame.origin.y+chuLiTimeLable.frame.size.height, 75*BILI, 16*BILI)];
    xiangQingLable.text = @"事件详情:";
    xiangQingLable.textColor = UIColorFromRGB(0x787878);
    xiangQingLable.font = [UIFont systemFontOfSize:16*BILI];
    [self.shiJianContentView addSubview:xiangQingLable];
    
    UILabel * xiangQingDetailLable = [[UILabel alloc] initWithFrame:CGRectMake(xiangQingLable.frame.origin.x+xiangQingLable.frame.size.width, xiangQingLable.frame.origin.y, VIEW_WIDTH-(xiangQingLable.frame.origin.x+nameTipLable.frame.size.width)-13*BILI, 60*BILI)];
    xiangQingDetailLable.font = [UIFont systemFontOfSize:16*BILI];
    xiangQingDetailLable.textColor = UIColorFromRGB(0x787878);
    xiangQingDetailLable.numberOfLines = 0;
    [self.shiJianContentView addSubview:xiangQingDetailLable];
    
    NSString * messageStr = [info objectForKey:@"content"];
    
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:messageStr];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:6];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [messageStr length])];
    [xiangQingDetailLable setAttributedText:attributedString1];
    [xiangQingDetailLable sizeToFit];
    xiangQingDetailLable.lineBreakMode = NSLineBreakByTruncatingTail;
    
    if(addressLable.frame.size.height<60*BILI)
    {
        xiangQingDetailLable.frame = CGRectMake(xiangQingDetailLable.frame.origin.x, xiangQingDetailLable.frame.origin.y, xiangQingDetailLable.frame.size.width, 60*BILI);
    }
    
    
    UIButton*  shouQiButton = [[UIButton alloc] initWithFrame:CGRectMake(0, xiangQingDetailLable.frame.origin.y+xiangQingDetailLable.frame.size.height, VIEW_WIDTH, 30*BILI)];
    shouQiButton.backgroundColor =[UIColor clearColor];
    shouQiButton.tag = 0;
    [shouQiButton addTarget:self action:@selector(shouQiButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.shiJianContentView addSubview:shouQiButton];
    
    UIImageView * shouQiImageView = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_WIDTH-27*BILI/2-13*BILI, (30-15/2)*BILI/2, 27*BILI/2, 15*BILI/2)];
    shouQiImageView.image = [UIImage imageNamed:@"shang_jiantou"];
    [shouQiButton addSubview:shouQiImageView];
    
    UILabel * shouQiLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH-(27*BILI/2+13*BILI)-5*BILI, 30*BILI)];
    shouQiLable.textAlignment = NSTextAlignmentRight;
    shouQiLable.font = [UIFont systemFontOfSize:15*BILI];
    shouQiLable.textColor =UIColorFromRGB(0x787878);
    shouQiLable.text = @"收起";
    [shouQiButton addSubview:shouQiLable];
    
    self.shiJianContentView.frame = CGRectMake(self.shiJianContentView.frame.origin.x, self.shiJianContentView.frame.origin.y, VIEW_WIDTH, shouQiButton.frame.origin.y+shouQiButton.frame.size.height);
    
    
    
    self.jinDuDetailView = [[UIView alloc] initWithFrame:CGRectMake(0, self.shiJianContentView.frame.origin.y+self.shiJianContentView.frame.size.height, VIEW_WIDTH, 100)];
    self.jinDuDetailView.backgroundColor = [UIColor whiteColor];
    [self.mainScrollView addSubview:self.jinDuDetailView];
    
    UIView * topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 5*BILI)];
    topLineView.backgroundColor = UIColorFromRGB(0xdddddd);
    [self.jinDuDetailView addSubview:topLineView];
    
    
    float jinDuHeight = topLineView.frame.origin.y+topLineView.frame.size.height+13*BILI;
    NSArray * array = [info objectForKey:@"tracklist"];
    
    NSMutableArray * pointArray = [NSMutableArray array];
    
    for (int i=0; i<array.count; i++) {
        
        NSDictionary * info = [array objectAtIndex:i];
        
        UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(63*BILI, jinDuHeight, VIEW_WIDTH-(63+13)*BILI, 16*BILI)];
        titleLable.font = [UIFont systemFontOfSize:16*BILI];
        titleLable.textColor = UIColorFromRGB(0xFE9052);
        titleLable.text = [info objectForKey:@"nodename"];
        [self.jinDuDetailView addSubview:titleLable];
        
        [pointArray addObject:[NSString stringWithFormat:@"%f",titleLable.frame.origin.y]];
        
        NSString * detail = [info objectForKey:@"nodecontent"];
        
        UILabel * detailLable = [[UILabel alloc] initWithFrame:CGRectMake(63*BILI, titleLable.frame.origin.y+titleLable.frame.size.height+13*BILI,titleLable.frame.size.width, 0)];
        detailLable.font = [UIFont systemFontOfSize:16*BILI];
        detailLable.textColor = UIColorFromRGB(0xFE9052);
        detailLable.text = [info objectForKey:@"nodecontent"];
        detailLable.numberOfLines = 0;
        [self.jinDuDetailView addSubview:detailLable];
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:detail];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        //调整行间距
        [paragraphStyle setLineSpacing:2];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [detail length])];
        detailLable.attributedText = attributedString;
        //设置自适应
        [detailLable  sizeToFit];
        
        UILabel * timeLable = [[UILabel alloc] initWithFrame:CGRectMake(63*BILI, detailLable.frame.origin.y+detailLable.frame.size.height+13*BILI, VIEW_WIDTH, 16*BILI)];
        timeLable.font = [UIFont systemFontOfSize:16*BILI];
        timeLable.textColor = UIColorFromRGB(0xFE9052);
        timeLable.text = [info objectForKey:@"nodetime"];
        [self.jinDuDetailView addSubview:timeLable];
        
        if (i!=0) {
            
            titleLable.textColor = UIColorFromRGB(0xAEB6BD);
            detailLable.textColor = UIColorFromRGB(0xAEB6BD);
            timeLable.textColor = UIColorFromRGB(0xAEB6BD);
            
        }
        
        jinDuHeight=jinDuHeight+16*BILI+13*BILI+detailLable.frame.size.height+13*BILI+16*BILI+30*BILI;
        
        NSString * originy = [pointArray objectAtIndex:0];
        NSString * finishy = [pointArray objectAtIndex:pointArray.count-1];
        UIView * timeLineView = [[UIView alloc] initWithFrame:CGRectMake(41*BILI, originy.floatValue, 1, finishy.floatValue-originy.floatValue)];
        timeLineView.backgroundColor =UIColorFromRGB(0xAEB6BD);
        [self.jinDuDetailView addSubview:timeLineView];
        
        for (int i=0; i<pointArray.count; i++) {
            
            NSString * origin = [pointArray objectAtIndex:i];
            UIView * pointView = [[UIView alloc] initWithFrame:CGRectMake(41*BILI-7.5*BILI, origin.floatValue, 16*BILI, 16*BILI)];
            pointView.layer.masksToBounds = YES;
            pointView.layer.cornerRadius = 8*BILI;
            [self.jinDuDetailView addSubview:pointView];
            
            if (i==0) {
                pointView.backgroundColor = UIColorFromRGB(0xFE9052);
            }
            else
            {
                pointView.backgroundColor = UIColorFromRGB(0xAEB6BD);
            }
        }
        
        
        self.jinDuDetailView.frame = CGRectMake(self.jinDuDetailView.frame.origin.x, self.jinDuDetailView.frame.origin.y, VIEW_WIDTH, jinDuHeight);
        jinDuDetailViewHeight = jinDuHeight;
        
        [self.mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH, self.jinDuDetailView.frame.origin.y+self.jinDuDetailView.frame.size.height)];
        
    }

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
-(void)shouQiButtonClick
{
    if (self.jinDuDetailView.frame.size.height>=VIEW_HEIGHT-self.shiJianContentView.frame.origin.y-(self.navView.frame.origin.y+self.navView.frame.size.height))
    {
        self.jinDuDetailView.frame = CGRectMake(0, self.shiJianContentView.frame.origin.y, VIEW_WIDTH, jinDuDetailViewHeight);
    }
    else
    {
        self.jinDuDetailView.frame = CGRectMake(0, self.shiJianContentView.frame.origin.y, VIEW_WIDTH, VIEW_HEIGHT-self.shiJianContentView.frame.origin.y-(self.navView.frame.origin.y+self.navView.frame.size.height));
    }
    
    [self.mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH, self.jinDuDetailView.frame.origin.y+self.jinDuDetailView.frame.size.height)];
    
}
-(void)zhanKaiButtonClick
{
    self.jinDuDetailView.frame = CGRectMake(0, self.shiJianContentView.frame.origin.y+self.shiJianContentView.frame.size.height, VIEW_WIDTH, jinDuDetailViewHeight);
    [self.mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH, self.jinDuDetailView.frame.origin.y+self.jinDuDetailView.frame.size.height)];
}
-(void)imageViewTap
{
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
    [browser setCurrentPhotoIndex:0];
    [self .navigationController pushViewController:browser animated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
