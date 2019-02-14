//
//  BaoLiaoDetailViewController.m
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/24.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BaoLiaoDetailViewController.h"
#import "UIImageView+WebCache.h"

@interface BaoLiaoDetailViewController ()

@end

@implementation BaoLiaoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLale.text = @"详情";
    self.titleLale.textColor = [UIColor whiteColor];
    [self setTabBarHidden];
    sourceImageIndex = 0;
    
    [self showNewLoadingView:nil view:self.view];
    self.photoArray = [NSMutableArray array];
    NSArray * imagePathArray = [self.info objectForKey:@"imglist"];
    if (imagePathArray.count>0) {
        
        [self getImage:imagePathArray];
    }
    else
    {
        [self initView];
    }
}
-(void)getImage:(NSArray *)array
{
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(-100, -100, 100, 100)];
    NSDictionary * info = [array objectAtIndex:sourceImageIndex];
    NSString * imageStr = [info objectForKey:@"imgurl"];
    [imageView sd_setImageWithURL:[NSURL URLWithString:imageStr] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        
        [self.view addSubview:imageView];//这一行必须添加要不回调里边代码不执行
        if(image !=nil)
        {
            [self.photoArray addObject:image];
        }
        sourceImageIndex  = sourceImageIndex+1;
        if (sourceImageIndex<array.count) {
            
            [self getImage:array];
        }
        else
        {
          
            [self initView];
        }
        
        
        
    }];
}
-(void)initView
{
    self.view.backgroundColor = UIColorFromRGB(0xdddddd);
    [self hideNewLoadingView];
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT-(self.navView.frame.origin.y+self.navView.frame.size.height))];
    self.mainScrollView.showsVerticalScrollIndicator = NO;
    self.mainScrollView.showsHorizontalScrollIndicator = NO;
    self.mainScrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.mainScrollView];
    
    UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, 13*BILI, VIEW_WIDTH-26*BILI, 25*BILI)];
    titleLable.textColor = UIColorFromRGB(0x787878);
    titleLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:25*BILI];
    titleLable.text = [self.info objectForKey:@"content"];
    [self.mainScrollView addSubview:titleLable];
    
    
    
    UILabel * timeLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, titleLable.frame.origin.y+titleLable.frame.size.height+13*BILI, VIEW_WIDTH, 13*BILI)];
    timeLable.textColor = UIColorFromRGB(0x787878);
    timeLable.font = [UIFont systemFontOfSize:13*BILI];
    timeLable.text = [self.info objectForKey:@"tipoffdate"];
    [self.mainScrollView addSubview:timeLable];
    
    float height = timeLable.frame.origin.y+timeLable.frame.size.height+13*BILI;
    for (UIImage * image in self.photoArray) {
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(13*BILI, height, VIEW_WIDTH-26*BILI, (VIEW_WIDTH-26*BILI)*image.size.height/image.size.width)];
        imageView.image = image;
        [self.mainScrollView addSubview:imageView];
        
        height = imageView.frame.origin.y+imageView.frame.size.height+13*BILI;
    }
    
    UILabel * messageLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, height, VIEW_WIDTH-26*BILI, 0)];
    messageLable.textColor = UIColorFromRGB(0x787878);
    messageLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:18*BILI];
    [self.mainScrollView addSubview:messageLable];
    
    NSString * messageStr = [self.info objectForKey:@"content"];
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:messageStr];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:3];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [messageStr length])];
    [messageLable setAttributedText:attributedString1];
    [messageLable sizeToFit];
    messageLable.lineBreakMode = NSLineBreakByTruncatingTail;
    
    [self.mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH, messageLable.frame.origin.y+messageLable.frame.size.height)];
    
    UIView * jieGuoView = [[UIView alloc] initWithFrame:CGRectMake(0, messageLable.frame.origin.y+messageLable.frame.size.height+13*BILI, VIEW_WIDTH, 20)];
    jieGuoView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [self.mainScrollView addSubview:jieGuoView];
    
    UIView * lineView1 = [[UIView alloc] initWithFrame:CGRectMake(13*BILI, (50*BILI-1)/2, (VIEW_WIDTH-70*BILI-26*BILI)/2, 1)];
    lineView1.backgroundColor = UIColorFromRGB(0x787878);
    lineView1.alpha = 0.5;
    [jieGuoView addSubview:lineView1];
    
    
    UIView * lineView2 = [[UIView alloc] initWithFrame:CGRectMake(13*BILI+lineView1.frame.size.width+70*BILI, (50*BILI-1)/2, (VIEW_WIDTH-70*BILI-26*BILI)/2, 1)];
    lineView2.backgroundColor = UIColorFromRGB(0x787878);
    lineView2.alpha = 0.5;
    [jieGuoView addSubview:lineView2];
    
    UILabel * jieHuoLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 50*BILI)];
    jieHuoLable.textColor = UIColorFromRGB(0X787878);
    jieHuoLable.font = [UIFont systemFontOfSize:15*BILI];
    jieHuoLable.text = @"处理结果";
    jieHuoLable.textAlignment = NSTextAlignmentCenter;
    [jieGuoView addSubview:jieHuoLable];
    
    if ([@"待处理" isEqualToString:[self.info objectForKey:@"state"]]) {
        
        UILabel * zhuangTaiLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, jieHuoLable.frame.origin.y+jieHuoLable.frame.size.height, VIEW_WIDTH-26*BILI, 15*BILI)];
        zhuangTaiLable.textColor = UIColorFromRGB(0X787878);
        zhuangTaiLable.font = [UIFont systemFontOfSize:15*BILI];
        zhuangTaiLable.text = [NSString stringWithFormat:@"处理状态:  %@",[self.info objectForKey:@"state"]];
        [jieGuoView addSubview:zhuangTaiLable];
        
        jieGuoView.frame = CGRectMake(jieGuoView.frame.origin.x, jieGuoView.frame.origin.y, jieGuoView.frame.size.width, zhuangTaiLable.frame.origin.y+zhuangTaiLable.frame.size.height+13*BILI);
    }
    else
    {
        UILabel * zhuangTaiLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, jieHuoLable.frame.origin.y+jieHuoLable.frame.size.height, VIEW_WIDTH-26*BILI, 15*BILI)];
        zhuangTaiLable.textColor = UIColorFromRGB(0X787878);
        zhuangTaiLable.font = [UIFont systemFontOfSize:15*BILI];
        zhuangTaiLable.text = [NSString stringWithFormat:@"处理状态:  %@",[self.info objectForKey:@"state"]];
        [jieGuoView addSubview:zhuangTaiLable];
        
        UILabel * timeLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, zhuangTaiLable.frame.origin.y+zhuangTaiLable.frame.size.height+13*BILI, VIEW_WIDTH-26*BILI, 15*BILI)];
        timeLable.textColor = UIColorFromRGB(0X787878);
        timeLable.font = [UIFont systemFontOfSize:15*BILI];
        timeLable.text = [NSString stringWithFormat:@"办结时间:  %@",[self.info objectForKey:@"processdate"]];
        [jieGuoView addSubview:timeLable];
        
        UILabel * resultLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, timeLable.frame.origin.y+timeLable.frame.size.height+13*BILI, VIEW_WIDTH-26*BILI, 15*BILI)];
        resultLable.textColor = UIColorFromRGB(0X787878);
        resultLable.font = [UIFont systemFontOfSize:15*BILI];
        resultLable.text = [NSString stringWithFormat:@"处理结果:  %@",[self.info objectForKey:@"processresult"]];
        [jieGuoView addSubview:resultLable];
        
         jieGuoView.frame = CGRectMake(jieGuoView.frame.origin.x, jieGuoView.frame.origin.y, jieGuoView.frame.size.width, resultLable.frame.origin.y+resultLable.frame.size.height+13*BILI);
        
    }
    
    [self.mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH, jieGuoView.frame.origin.y+jieGuoView.frame.size.height)];
    
    jieGuoView.frame = CGRectMake(jieGuoView.frame.origin.x, jieGuoView.frame.origin.y, jieGuoView.frame.size.width, VIEW_HEIGHT);
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
