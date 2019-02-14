//
//  GuanKongTaiZhangDetailViewController.m
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/25.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "GuanKongTaiZhangDetailViewController.h"

@interface GuanKongTaiZhangDetailViewController ()

@end

@implementation GuanKongTaiZhangDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLale.textColor = [UIColor whiteColor];
    self.titleLale.text = @"走访详情";
    self.cloudClient = [CloudClient getInstance];
    [self showNewLoadingView:nil view:self.view];
    
    [self.cloudClient zhongDianRenYuanZouFangDetail:@"patrolVisits!visitsView.do"
                                             visitid:self.visitid
                                           delegate:self
                                           selector:@selector(getMesSuccess:)
                                      errorSelector:@selector(getMesError:)];

    
}
-(void)getMesSuccess:(NSDictionary *)info
{
    [self hideNewLoadingView];
    [self initView:info];
}
-(void)getMesError:(NSDictionary *)info
{
    [self hideNewLoadingView];
    [Common showToastView:[info objectForKey:@"message"] view:self.view];
}
-(void)initView:(NSDictionary *)info
{
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT-(self.navView.frame.origin.y+self.navView.frame.size.height))];
    [self.view addSubview:self.mainScrollView];
    
    UILabel * shenFenZhengLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, 0, VIEW_WIDTH-26*BILI, 50*BILI)];
    shenFenZhengLable.text = [NSString stringWithFormat:@"身 份 证: %@",[info objectForKey:@"foucusidcard"]] ;
    shenFenZhengLable.textColor = UIColorFromRGB(0x787878);
    shenFenZhengLable.font = [UIFont systemFontOfSize:16*BILI];
    [self.mainScrollView addSubview:shenFenZhengLable];
    
    UIView * shenFenZhengLineView  = [[UIView alloc] initWithFrame:CGRectMake(0, shenFenZhengLable.frame.origin.y+shenFenZhengLable.frame.size.height, VIEW_WIDTH, 1)];
    shenFenZhengLineView.backgroundColor = UIColorFromRGB(0xdddddd);
    [self.mainScrollView addSubview:shenFenZhengLineView];
    
    UILabel *nameLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, shenFenZhengLineView.frame.origin.y+shenFenZhengLineView.frame.size.height, VIEW_WIDTH-26*BILI, 50*BILI)];
    nameLable.text = [NSString stringWithFormat:@"重点人姓名: %@",[info objectForKey:@"foucusname"]] ;
    nameLable.textColor = UIColorFromRGB(0x787878);
    nameLable.font = [UIFont systemFontOfSize:16*BILI];
    [self.mainScrollView addSubview:nameLable];
    
    UIView * nameLineView  = [[UIView alloc] initWithFrame:CGRectMake(0, nameLable.frame.origin.y+nameLable.frame.size.height, VIEW_WIDTH, 1)];
    nameLineView.backgroundColor = UIColorFromRGB(0xdddddd);
    [self.mainScrollView addSubview:nameLineView];
    
    
    UILabel * telLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, nameLineView.frame.origin.y+nameLineView.frame.size.height, VIEW_WIDTH-26*BILI, 50*BILI)];
    telLable.text = [NSString stringWithFormat:@"联系电话: %@",[info objectForKey:@"foucustel"]] ;
    telLable.textColor = UIColorFromRGB(0x787878);
    telLable.font = [UIFont systemFontOfSize:16*BILI];
    [self.mainScrollView addSubview:telLable];
    
    UIView * mingChengLineView  = [[UIView alloc] initWithFrame:CGRectMake(0, telLable.frame.origin.y+telLable.frame.size.height, VIEW_WIDTH, 1)];
    mingChengLineView.backgroundColor = UIColorFromRGB(0xdddddd);
    [self.mainScrollView addSubview:mingChengLineView];
    
    UILabel * addressLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, mingChengLineView.frame.origin.y+1, VIEW_WIDTH-26*BILI, 50*BILI)];
    addressLable.textColor = UIColorFromRGB(0x787878);
    addressLable.font = [UIFont systemFontOfSize:16*BILI];
    addressLable.numberOfLines = 0;
    [self.mainScrollView addSubview:addressLable];
    
    NSString * messageStr = [NSString stringWithFormat:@"位    置:  %@",[info objectForKey:@"foucusaddress"]];
    
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:messageStr];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:6];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [messageStr length])];
    [addressLable setAttributedText:attributedString1];
    [addressLable sizeToFit];
    addressLable.lineBreakMode = NSLineBreakByTruncatingTail;
    
    if(addressLable.frame.size.height<50*BILI)
    {
        addressLable.frame = CGRectMake(addressLable.frame.origin.x, addressLable.frame.origin.y, addressLable.frame.size.width, 50*BILI);
    }
    
    
    UIView * addressLableLineView  = [[UIView alloc] initWithFrame:CGRectMake(0, addressLable.frame.origin.y+addressLable.frame.size.height, VIEW_WIDTH, 1)];
    addressLableLineView.backgroundColor = UIColorFromRGB(0xdddddd);
    [self.mainScrollView addSubview:addressLableLineView];
    
    
 
    UILabel * riQiLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, addressLableLineView.frame.origin.y+1, VIEW_WIDTH-26*BILI, 50*BILI)];
    riQiLable.textColor =UIColorFromRGB(0x787878);
    riQiLable.font = [UIFont systemFontOfSize:16*BILI];
    riQiLable.text = [NSString stringWithFormat:@"走访日期: %@",[info objectForKey:@"visitdate"]];
    [self.mainScrollView addSubview:riQiLable];
    
    UIView * riQiLableLineView  = [[UIView alloc] initWithFrame:CGRectMake(0, riQiLable.frame.origin.y+riQiLable.frame.size.height, VIEW_WIDTH, 1)];
    riQiLableLineView.backgroundColor = UIColorFromRGB(0xdddddd);
    [self.mainScrollView addSubview:riQiLableLineView];
    
    UILabel * neiRongLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, riQiLableLineView.frame.origin.y+1, VIEW_WIDTH-26*BILI, 100*BILI)];
    neiRongLable.textColor =UIColorFromRGB(0x787878);
    neiRongLable.font = [UIFont systemFontOfSize:16*BILI];
    neiRongLable.numberOfLines = 0;
    [self.mainScrollView addSubview:neiRongLable];
    
    messageStr = [NSString stringWithFormat:@"走访内容: %@",[info objectForKey:@"visitcontent"]];
    
    attributedString1 = [[NSMutableAttributedString alloc] initWithString:messageStr];
    paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:6];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [messageStr length])];
    [neiRongLable setAttributedText:attributedString1];
    [neiRongLable sizeToFit];
    neiRongLable.lineBreakMode = NSLineBreakByTruncatingTail;
    
    if(neiRongLable.frame.size.height<50*BILI)
    {
        neiRongLable.frame = CGRectMake(neiRongLable.frame.origin.x, neiRongLable.frame.origin.y, neiRongLable.frame.size.width, 50*BILI);
    }
    
    UIView * neiRongLineView = [[UIView alloc] initWithFrame:CGRectMake(0, neiRongLable.frame.origin.y+neiRongLable.frame.size.height, VIEW_WIDTH, 1)];
    neiRongLineView.backgroundColor = UIColorFromRGB(0xEEF1F5);
    [self.mainScrollView addSubview:neiRongLineView];
    
    UILabel * pingGuLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, neiRongLineView.frame.origin.y+neiRongLineView.frame.size.height, VIEW_WIDTH-26*BILI, 50*BILI)];
    pingGuLable.textColor =UIColorFromRGB(0x787878);
    pingGuLable.font = [UIFont systemFontOfSize:16*BILI];
    pingGuLable.text = [NSString stringWithFormat:@"效果评估: %@",[info objectForKey:@"xgpg"]];
    [self.mainScrollView addSubview:pingGuLable];
    
    UIView * pingGuLineView = [[UIView alloc] initWithFrame:CGRectMake(0, pingGuLable.frame.origin.y+pingGuLable.frame.size.height, VIEW_WIDTH, 1)];
    pingGuLineView.backgroundColor = UIColorFromRGB(0xEEF1F5);
    [self.mainScrollView addSubview:pingGuLineView];
    
    [self.mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH, pingGuLineView.frame.origin.y+pingGuLineView.frame.size.height)];
    
    float imageWidth = (VIEW_WIDTH-56*BILI)/4;
    
     float nowHeigjht = pingGuLineView.frame.origin.y+pingGuLineView.frame.size.height+3*BILI;
    
    
    self.imageArray = [info objectForKey:@"imglist"];
    if (self.imageArray.count>0) {
        
        for (int i=0; i<self.imageArray.count; i++) {
            NSDictionary * imageInfo = [self.imageArray objectAtIndex:i];
            CustomImageView * imageView = [[CustomImageView alloc] initWithFrame:CGRectMake(13*BILI+(imageWidth+10*BILI)*(i%4),nowHeigjht+(imageWidth+5*BILI)*(i/4), imageWidth, imageWidth)];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
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
        
        UIView * imageLineView = [[UIView alloc] initWithFrame:CGRectMake(0, pingGuLineView.frame.origin.y+pingGuLineView.frame.size.height+(5*BILI+imageWidth)*imageLines+3*BILI, VIEW_WIDTH, 200)];
        imageLineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
        [self.mainScrollView addSubview:imageLineView];
        
        [self.mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH, imageLineView.frame.origin.y+1)];
    }
    else
    {
        pingGuLineView.frame = CGRectMake(pingGuLineView.frame.origin.x, pingGuLineView.frame.origin.y, VIEW_WIDTH, 1000);
    }
    
    
    
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
