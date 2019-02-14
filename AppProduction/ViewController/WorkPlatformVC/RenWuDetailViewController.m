//
//  RenWuDetailViewController.m
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/15.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RenWuDetailViewController.h"
#import "MWPhotoBrowser.h"

@interface RenWuDetailViewController ()

@end

@implementation RenWuDetailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.titleLale.textColor = [UIColor whiteColor];
    self.titleLale.text = @"报告详情";
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT-(self.navView.frame.origin.y+self.navView.frame.size.height))];
    self.mainScrollView.showsVerticalScrollIndicator = NO;
    self.mainScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.mainScrollView];
    
    self.cloudClient = [CloudClient getInstance];
    [self showNewLoadingView:nil view:self.view];
    [self.cloudClient woDeXiaDaDetail:@"task!view.do"
                               taskid:self.taskid
                             delegate:self
                             selector:@selector(getMesSuccess:)
                        errorSelector:@selector(getMesError:)];
    
    
    
}
-(void)getMesSuccess:(NSDictionary *)info
{
    [self hideNewLoadingView];
    ///////////////////////事件名称
    UILabel * nameLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, 0, VIEW_WIDTH-26*BILI, 50*BILI)];
    nameLable.textColor = UIColorFromRGB(0x4A4A4A);
    nameLable.font = [UIFont systemFontOfSize:18*BILI];
    nameLable.adjustsFontSizeToFitWidth = YES;
    nameLable.text = [NSString stringWithFormat:@"任务名称:  %@",[info objectForKey:@"taskname"]];
    [self.mainScrollView addSubview:nameLable];
    
    UIView * nameLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50*BILI-1, VIEW_WIDTH-26*BILI, 1)];
    nameLineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [nameLable addSubview:nameLineView];
    
    
    //////////////////////任务内容
    UILabel * neiRongLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI,nameLable.frame.origin.y+nameLable.frame.size.height+10*BILI, 82*BILI, 18*BILI)];
    neiRongLable.text = @"任务内容:";
    neiRongLable.textColor = UIColorFromRGB(0x4A4A4A);
    neiRongLable.font = [UIFont systemFontOfSize:18*BILI];
    [self.mainScrollView addSubview:neiRongLable];
    
    UILabel * xiangQingDetailLable = [[UILabel alloc] initWithFrame:CGRectMake(neiRongLable.frame.origin.x+neiRongLable.frame.size.width, neiRongLable.frame.origin.y, VIEW_WIDTH-(neiRongLable.frame.origin.x+neiRongLable.frame.size.width)-13*BILI, 70*BILI)];
    xiangQingDetailLable.font = [UIFont systemFontOfSize:18*BILI];
    xiangQingDetailLable.textColor = UIColorFromRGB(0x4A4A4A);
    xiangQingDetailLable.adjustsFontSizeToFitWidth = YES;
    xiangQingDetailLable.numberOfLines = 0;
    [self.mainScrollView addSubview:xiangQingDetailLable];
    
    
    NSString * messageStr = [info objectForKey:@"taskcontent"];
    
    
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:messageStr];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:6];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [messageStr length])];
    [xiangQingDetailLable setAttributedText:attributedString1];
    [xiangQingDetailLable sizeToFit];
    xiangQingDetailLable.lineBreakMode = NSLineBreakByTruncatingTail;
    
    UIView * huiYinLineView;
    if (xiangQingDetailLable.frame.size.height>50*BILI) {
        
        huiYinLineView = [[UIView alloc] initWithFrame:CGRectMake(13*BILI, xiangQingDetailLable.frame.origin.y+xiangQingDetailLable.frame.size.height+10*BILI, VIEW_WIDTH-26*BILI, 1)];
        huiYinLineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
        [self.mainScrollView addSubview:huiYinLineView];
        
    }
    else
    {
        neiRongLable.frame = CGRectMake(neiRongLable.frame.origin.x, nameLable.frame.origin.y+nameLable.frame.size.height, neiRongLable.frame.size.width, 50*BILI);
        
        xiangQingDetailLable.frame = CGRectMake(xiangQingDetailLable.frame.origin.x, neiRongLable.frame.origin.y, xiangQingDetailLable.frame.size.width, 50*BILI);
        
        
        huiYinLineView = [[UIView alloc] initWithFrame:CGRectMake(13*BILI, neiRongLable.frame.origin.y+neiRongLable.frame.size.height, VIEW_WIDTH-26*BILI, 1)];
        huiYinLineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
        [self.mainScrollView addSubview:huiYinLineView];
        
    }
    
    
    //////////////////////下达时间
    UILabel * zhengZhiMianMaoLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, huiYinLineView.frame.origin.y+huiYinLineView.frame.size.height, VIEW_WIDTH, 50*BILI)];
    zhengZhiMianMaoLable.textColor = UIColorFromRGB(0x4A4A4A);
    zhengZhiMianMaoLable.font = [UIFont systemFontOfSize:18*BILI];
    zhengZhiMianMaoLable.text = [NSString stringWithFormat:@"下达时间:  %@",[info objectForKey:@"taskdate"]];
    [self.mainScrollView addSubview:zhengZhiMianMaoLable];
    
    UIView * zhengZhiMianMaLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50*BILI-1, VIEW_WIDTH-26*BILI, 1)];
    zhengZhiMianMaLineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [zhengZhiMianMaoLable addSubview:zhengZhiMianMaLineView];
    
    //////////////////////任务期限
    UILabel * qiXianLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, zhengZhiMianMaoLable.frame.origin.y+zhengZhiMianMaoLable.frame.size.height, VIEW_WIDTH, 50*BILI)];
    qiXianLable.textColor = UIColorFromRGB(0x4A4A4A);
    qiXianLable.font = [UIFont systemFontOfSize:18*BILI];
    qiXianLable.text = [NSString stringWithFormat:@"任务期限:  %@",[info objectForKey:@"tasklimit"]];
    [self.mainScrollView addSubview:qiXianLable];
    
    UIView * qiXianLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50*BILI-1, VIEW_WIDTH-26*BILI, 1)];
    qiXianLineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [qiXianLable addSubview:qiXianLineView];
    
    
    NSArray * feedBackList = [info objectForKey:@"feedbacklist"];
    
    float nowHeigjht = qiXianLable.frame.origin.y+qiXianLable.frame.size.height+3*BILI;
    
    for (NSDictionary * info in feedBackList) {
        
        float imageWidth = (VIEW_WIDTH-56*BILI)/4;

        
        self.imageArray = [info objectForKey:@"imglist"];
        for (int i=0; i<self.imageArray.count; i++) {
            NSDictionary * imageInfo = [self.imageArray objectAtIndex:i];
            CustomImageView * imageView = [[CustomImageView alloc] initWithFrame:CGRectMake(13*BILI+(imageWidth+10*BILI)*(i%4),nowHeigjht+(imageWidth+5*BILI)*(i/4), imageWidth, imageWidth)];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            //imageView.autoresizingMask = UIViewAutoresizingNone;
            imageView.userInteractionEnabled = YES;
            imageView.clipsToBounds = YES;
            imageView.tag = i;
            imageView.urlPath = [imageInfo objectForKey:@"imgurl"];
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
        UIView * imageLineView = [[UIView alloc] initWithFrame:CGRectMake(13*BILI, qiXianLable.frame.origin.y+qiXianLable.frame.size.height+(5*BILI+imageWidth)*imageLines+3*BILI, VIEW_WIDTH-26*BILI, 1)];
        imageLineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
        [self.mainScrollView addSubview:imageLineView];
        [self.mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH, imageLineView.frame.origin.y+1)];
        
        float y ;
        if (self.imageArray.count==0)
        {
            imageLineView.hidden = YES;
            y = qiXianLable.frame.origin.y+qiXianLable.frame.size.height+3*BILI;
        }
        else
        {
            y = imageLineView.frame.origin.y+imageLineView.frame.size.height+3*BILI;
        }
        
        UILabel * wangGeYuanLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, y, VIEW_WIDTH-26*BILI, 50*BILI)];
        wangGeYuanLable.textColor = UIColorFromRGB(0x4A4A4A);
        wangGeYuanLable.font = [UIFont systemFontOfSize:18*BILI];
        wangGeYuanLable.text = [NSString stringWithFormat:@"网格员:  %@",[info objectForKey:@"feeduser"]];
        [self.mainScrollView addSubview:wangGeYuanLable];
        
        UIView *  wangGeYuanLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50*BILI-1, VIEW_WIDTH-26*BILI, 1)];
        wangGeYuanLineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
        [wangGeYuanLable addSubview:wangGeYuanLineView];
        
        UILabel * zhuangTaiLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, wangGeYuanLable.frame.origin.y+wangGeYuanLable.frame.size.height, VIEW_WIDTH-26*BILI, 50*BILI)];
        zhuangTaiLable.textColor = UIColorFromRGB(0x4A4A4A);
        zhuangTaiLable.font = [UIFont systemFontOfSize:18*BILI];
        zhuangTaiLable.numberOfLines = 2;
        zhuangTaiLable.text = [NSString stringWithFormat:@"任务状态:  %@",[info objectForKey:@"state"]];
        [self.mainScrollView addSubview:zhuangTaiLable];
        
        UIView *  zhuangTaiLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50*BILI-1, VIEW_WIDTH-26*BILI, 1)];
        zhuangTaiLineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
        [zhuangTaiLable addSubview:zhuangTaiLineView];
        
        
        //反馈内容
        
        UILabel * fanKuiNeiRongLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI,zhuangTaiLable.frame.origin.y+zhuangTaiLable.frame.size.height+10*BILI, 82*BILI, 18*BILI)];
        fanKuiNeiRongLable.text = @"反馈内容:";
        fanKuiNeiRongLable.textColor = UIColorFromRGB(0x4A4A4A);
        fanKuiNeiRongLable.font = [UIFont systemFontOfSize:18*BILI];
        [self.mainScrollView addSubview:fanKuiNeiRongLable];
        
        UILabel * fanKuiXiangQingDetailLable = [[UILabel alloc] initWithFrame:CGRectMake(fanKuiNeiRongLable.frame.origin.x+fanKuiNeiRongLable.frame.size.width, fanKuiNeiRongLable.frame.origin.y, VIEW_WIDTH-(fanKuiNeiRongLable.frame.origin.x+fanKuiNeiRongLable.frame.size.width)-13*BILI, 70*BILI)];
        fanKuiXiangQingDetailLable.font = [UIFont systemFontOfSize:18*BILI];
        fanKuiXiangQingDetailLable.textColor = UIColorFromRGB(0x4A4A4A);
        fanKuiXiangQingDetailLable.adjustsFontSizeToFitWidth = YES;
        fanKuiXiangQingDetailLable.numberOfLines = 0;
        [self.mainScrollView addSubview:fanKuiXiangQingDetailLable];
        
        
        messageStr = [info objectForKey:@"feedcontent"];
        if(!messageStr)
        {
            messageStr = @"未反馈";
        }
        
            attributedString1 = [[NSMutableAttributedString alloc] initWithString:messageStr];
            paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
            [paragraphStyle1 setLineSpacing:6];
            [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [messageStr length])];
            [fanKuiXiangQingDetailLable setAttributedText:attributedString1];
            [fanKuiXiangQingDetailLable sizeToFit];
            fanKuiXiangQingDetailLable.lineBreakMode = NSLineBreakByTruncatingTail;
        
        
        UIView * fanKuiNeiRongLineView;
        if (fanKuiXiangQingDetailLable.frame.size.height>50*BILI) {
            
            fanKuiNeiRongLineView = [[UIView alloc] initWithFrame:CGRectMake(13*BILI, fanKuiXiangQingDetailLable.frame.origin.y+fanKuiXiangQingDetailLable.frame.size.height+10*BILI, VIEW_WIDTH-26*BILI, 1)];
            fanKuiNeiRongLineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
            [self.mainScrollView addSubview:fanKuiNeiRongLineView];
            
        }
        else
        {
            fanKuiNeiRongLable.frame = CGRectMake(fanKuiNeiRongLable.frame.origin.x, zhuangTaiLable.frame.origin.y+zhuangTaiLable.frame.size.height, fanKuiNeiRongLable.frame.size.width, 50*BILI);
            
            fanKuiXiangQingDetailLable.frame = CGRectMake(xiangQingDetailLable.frame.origin.x, fanKuiNeiRongLable.frame.origin.y, fanKuiXiangQingDetailLable.frame.size.width, 50*BILI);
            fanKuiXiangQingDetailLable.text = messageStr;
            
            fanKuiNeiRongLineView = [[UIView alloc] initWithFrame:CGRectMake(13*BILI, fanKuiNeiRongLable.frame.origin.y+fanKuiNeiRongLable.frame.size.height, VIEW_WIDTH-26*BILI, 1)];
            fanKuiNeiRongLineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
            [self.mainScrollView addSubview:fanKuiNeiRongLineView];
            
        }
        
        
        //////////////////////反馈时间网格
        
        
        UILabel * timeLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, fanKuiNeiRongLineView.frame.origin.y+fanKuiNeiRongLineView.frame.size.height, VIEW_WIDTH-26*BILI, 50*BILI)];
        timeLable.textColor = UIColorFromRGB(0x4A4A4A);
        timeLable.font = [UIFont systemFontOfSize:18*BILI];
        timeLable.text = @"反馈时间:  2018-05-29 10:50";
        NSString * timeStr = [info objectForKey:@"feeddate"];
        if (!timeStr||[@"" isEqualToString:timeStr]) {
            
            timeStr = @"无";
        }
        timeLable.text = [NSString stringWithFormat:@"反馈时间:  %@",timeStr];
        [self.mainScrollView addSubview:timeLable];
        
        
        UIView * timeLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50*BILI-1, VIEW_WIDTH-26*BILI, 1)];
        timeLineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
        [timeLable addSubview:timeLineView];
        
        
        nowHeigjht = timeLable.frame.origin.y+timeLable.frame.size.height;
        
        
        
        
    }
    [self.mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH, nowHeigjht+100*BILI)];
   
}
-(void)getMesError:(NSDictionary *)info
{
    [self hideNewLoadingView];
    [Common showToastView:[info objectForKey:@"message"] view:self.view];
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
