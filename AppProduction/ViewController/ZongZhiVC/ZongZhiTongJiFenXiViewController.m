//
//  ZongZhiTongJiFenXiViewController.m
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/26.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ZongZhiTongJiFenXiViewController.h"

@interface ZongZhiTongJiFenXiViewController ()

@end

@implementation ZongZhiTongJiFenXiViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.titleLale.textColor = [UIColor whiteColor];
    self.titleLale.text = @"统计分析";
    
    self.nowInfo =   [Common getNowDateAndWeek];
    self.fenLeiType = @"1";
    self.month = [self.nowInfo objectForKey:@"month"];
    self.jiDu = [self.nowInfo objectForKey:@"jiDu"];
    self.year = [self.nowInfo objectForKey:@"year"];
    
   
    
    
     self.cloudClient = [CloudClient getInstance];
    [self getSourceData];
    
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT)];
    [self.view addSubview:self.contentView];
    [self initTopButtonView];
    
    UILabel * tipLable = [[UILabel alloc] initWithFrame:CGRectMake(0, VIEW_HEIGHT-45*BILI, VIEW_WIDTH, 10*BILI)];
    tipLable.text = @"单位为(件)";
    tipLable.textColor = UIColorFromRGB(0x787878);;
    tipLable.font = [UIFont systemFontOfSize:10*BILI];
    tipLable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:tipLable];
    
    UIView * wanChengTipView = [[UIView alloc] initWithFrame:CGRectMake(13*BILI, VIEW_HEIGHT-30*BILI, 10*BILI, 10*BILI)];
    wanChengTipView.backgroundColor = UIColorFromRGB(0x4DBA7A);
    [self.view addSubview:wanChengTipView];
    
    UILabel * wanChengTipLable = [[UILabel alloc] initWithFrame:CGRectMake(wanChengTipView.frame.origin.x+wanChengTipView.frame.size.width+3, wanChengTipView.frame.origin.y, 40*BILI, 10*BILI)];
    wanChengTipLable.text = @"已处理";
    wanChengTipLable.textColor = UIColorFromRGB(0x4DBA7A);;
    wanChengTipLable.font = [UIFont systemFontOfSize:10*BILI];
    [self.view addSubview:wanChengTipLable];
    
    UIView * weiChuLiTipView = [[UIView alloc] initWithFrame:CGRectMake(wanChengTipLable.frame.origin.x+wanChengTipLable.frame.size.width+5, wanChengTipView.frame.origin.y, 10*BILI, 10*BILI)];
    weiChuLiTipView.backgroundColor = UIColorFromRGB(0xF55E4E);
    [self.view addSubview:weiChuLiTipView];
    
    UILabel * weiChuLiTipLable = [[UILabel alloc] initWithFrame:CGRectMake(weiChuLiTipView.frame.origin.x+weiChuLiTipView.frame.size.width+3, wanChengTipView.frame.origin.y, 40*BILI, 10*BILI)];
    weiChuLiTipLable.text = @"未处理";
    weiChuLiTipLable.textColor = UIColorFromRGB(0xF55E4E);;
    weiChuLiTipLable.font = [UIFont systemFontOfSize:10*BILI];
    [self.view addSubview:weiChuLiTipLable];
    
    
  
}
-(void)getSourceData
{
    [self.cloudClient lingDaoTongJiFenXi:@"chartGraph!tjfx.do"
                                    type:self.fenLeiType
                                   month:self.month
                                 quarter:self.jiDu
                                    year:self.year
                                delegate:self
                                selector:@selector(getDataSuccess:)
                           errorSelector:@selector(getDataError:)];
}
-(void)initTopButtonView
{
    self.monthButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH/3, 40*BILI)];
    self.monthButton.backgroundColor = UIColorFromRGB(0xEEF1F5);
    [self.monthButton setTitle:@"本月" forState:UIControlStateNormal];
    [self.monthButton setTitleColor:UIColorFromRGB(0x787878) forState:UIControlStateNormal];
    self.monthButton.titleLabel.font = [UIFont systemFontOfSize:18*BILI];
    [self.monthButton addTarget:self action:@selector(monthButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.monthButton];
    
    UIImageView * monthJianTouImageView = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_WIDTH/3-27*BILI/2-5*BILI, (40-15/2)*BILI/2, 27*BILI/2, 15*BILI/2)];
    monthJianTouImageView.image = [UIImage imageNamed:@"xia_jiantou"];
    [self.monthButton addSubview:monthJianTouImageView];
    
    self.jiDuButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH/3, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH/3, 40*BILI)];
    self.jiDuButton.backgroundColor = UIColorFromRGB(0xEEF1F5);
    [self.jiDuButton setTitle:@"本季度" forState:UIControlStateNormal];
    [self.jiDuButton setTitleColor:UIColorFromRGB(0x787878) forState:UIControlStateNormal];
    self.jiDuButton.titleLabel.font = [UIFont systemFontOfSize:18*BILI];
    [self.jiDuButton addTarget:self action:@selector(jiDuButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.jiDuButton];
    
    UIImageView * jiDuJianTouImageView = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_WIDTH/3-27*BILI/2-5*BILI, (40-15/2)*BILI/2, 27*BILI/2, 15*BILI/2)];
    jiDuJianTouImageView.image = [UIImage imageNamed:@"xia_jiantou"];
    [self.jiDuButton addSubview:jiDuJianTouImageView];
    
    
    self.yearButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH*2/3, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH/3, 40*BILI)];
    self.yearButton.backgroundColor = UIColorFromRGB(0xEEF1F5);
    [self.yearButton setTitle:@"本年" forState:UIControlStateNormal];
    [self.yearButton setTitleColor:UIColorFromRGB(0x787878) forState:UIControlStateNormal];
    self.yearButton.titleLabel.font = [UIFont systemFontOfSize:18*BILI];
    [self.yearButton addTarget:self action:@selector(yearButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.yearButton];
    
    UIImageView * yearJianTouImageView = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_WIDTH/3-27*BILI/2-5*BILI, (40-15/2)*BILI/2, 27*BILI/2, 15*BILI/2)];
    yearJianTouImageView.image = [UIImage imageNamed:@"xia_jiantou"];
    [self.yearButton addSubview:yearJianTouImageView];
    
}
-(void)monthButtonClick
{
    [self initFenLei:@"1"];
}
-(void)jiDuButtonClick
{
    [self initFenLei:@"2"];
}
-(void)yearButtonClick
{
    [self initFenLei:@"3"];
}
-(void)initFenLei:(NSString *)type
{
    self.fenLeiType = type;
    [self.fenLeiView removeFromSuperview];
    
    
    
    
    if (alsoShouFeiLei)
    {
        alsoShouFeiLei = NO;
        [self.fenLeiView removeFromSuperview];
    }
    else
    {
        alsoShouFeiLei = YES;
        if ([@"1" isEqualToString:type])
        {
            //[self.mainScrollView setContentOffset:CGPointMake(0, 0)];
            
            self.sourceArray = [[NSMutableArray alloc] initWithObjects:@"本月",@"1月",@"2月",@"3月",@"4月",@"5月",@"6月",@"7月",@"8月",@"9月",@"10月",@"11月",@"12月", nil];
            
            self.fenLeiView = [[UIScrollView alloc] initWithFrame:CGRectMake(self.monthButton.frame.origin.x+(self.monthButton.frame.size.width-100*BILI)/2, self.monthButton.frame.origin.y+self.monthButton.frame.size.height, 100*BILI, 8*35*BILI)];
            [self.fenLeiView setContentSize:CGSizeMake(self.fenLeiView.frame.size.width, self.sourceArray.count*35*BILI)];
            
        }
        else if ([@"2" isEqualToString:type])
        {
            self.sourceArray = [[NSMutableArray alloc] initWithObjects:@"本季度",@"1季度",@"2季度",@"3季度",@"4季度", nil];
            self.fenLeiView = [[UIScrollView alloc] initWithFrame:CGRectMake(self.jiDuButton.frame.origin.x+(self.jiDuButton.frame.size.width-100*BILI)/2, self.monthButton.frame.origin.y+self.monthButton.frame.size.height, 100*BILI, self.sourceArray.count*35*BILI)];
            
            
        }
        else if ([@"3" isEqualToString:type])
        {
            NSString * year = [self.nowInfo objectForKey:@"year"];
            
            self.sourceArray = [[NSMutableArray alloc] initWithObjects:@"本年",year,[NSString stringWithFormat:@"%d",year.intValue-1],[NSString stringWithFormat:@"%d",year.intValue-2], nil];
            self.fenLeiView = [[UIScrollView alloc] initWithFrame:CGRectMake(self.yearButton.frame.origin.x+(self.yearButton.frame.size.width-100*BILI)/2, self.monthButton.frame.origin.y+self.monthButton.frame.size.height, 100*BILI, self.sourceArray.count*35*BILI)];
        }
        
        self.fenLeiView.backgroundColor = UIColorFromRGB(0x787878);
        self.fenLeiView.layer.cornerRadius = 4*BILI;
        self.fenLeiView.layer.borderWidth = 1;
        self.fenLeiView.layer.borderColor = [[UIColor whiteColor] CGColor];
        [self.view addSubview:self.fenLeiView];
        
        
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
    if ([@"1" isEqualToString:self.fenLeiType])
    {
        if (button.tag==0) {
            
            self.month = [self.nowInfo objectForKey:@"month"];
        }
        else
        {
            self.month = [NSString stringWithFormat:@"%d",(int)button.tag];
        }
        [self.monthButton setTitle:[self.sourceArray objectAtIndex:button.tag] forState:UIControlStateNormal];
    }
    else if ([@"2" isEqualToString:self.fenLeiType])
    {
        [self.jiDuButton setTitle:[self.sourceArray objectAtIndex:button.tag] forState:UIControlStateNormal];
        if (button.tag==0) {
            
            self.jiDu = [self.nowInfo objectForKey:@"jiDu"];
        }
        else
        {
            self.jiDu = [NSString stringWithFormat:@"%d",(int)button.tag];
        }
    }
    else if ([@"3" isEqualToString:self.fenLeiType])
    {
        [self.yearButton setTitle:[self.sourceArray objectAtIndex:button.tag] forState:UIControlStateNormal];
        
        if (button.tag==0) {
            
            self.year = [self.nowInfo objectForKey:@"year"];
        }
        else
        {
            self.year = [self.sourceArray objectAtIndex:button.tag];
        }
    }
    [self getSourceData];
}

-(void)getDataSuccess:(NSDictionary *)info
{
    [self initTuBiao:[info objectForKey:@"sjqklist"]];
}
-(void)getDataError:(NSArray *)list
{
    
}
-(void)initTuBiao:(NSArray *)list
{
    [self.contentView removeAllSubviews];
    int max = 0;
    for (NSDictionary * info in list) {
        
        NSNumber * number = [info objectForKey:@"wbjnum"];
        if(max<number.intValue)
        {
            max = number.intValue;
        }
        number = [info objectForKey:@"ybjnum"];
        if(max<number.intValue)
        {
            max = number.intValue;
        }
    }
    
    
    int fenGeNumber;//纵坐标分多少格
    float tuBiaoHeight = VIEW_HEIGHT-250*BILI;//y轴的高度
    float meiJianHeight ;//每一件的高度

    if (max==0) {
        
        max = 1;
        fenGeNumber = 1;
         meiJianHeight = tuBiaoHeight;
    }
    else
    {
        meiJianHeight = tuBiaoHeight/max;
        if (max<=20) {
            
            fenGeNumber = max;
        }
        else if (max<=40)
        {
            fenGeNumber = max/2;
        }
        else if (max<=60)
        {
            fenGeNumber = max/3;
        }
        else if (max<=80)
        {
            fenGeNumber = max/4;
        }
        else if (max<=100)
        {
            fenGeNumber = max/5;
        }
        else
        {
            fenGeNumber = 20;
        }
        
    }
    
    
    
    int cellNumberY = max/fenGeNumber;
    int cellHeight = tuBiaoHeight/fenGeNumber;
    
    
    UIScrollView * mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(30*BILI, 50*BILI, VIEW_WIDTH-35*BILI, cellHeight*fenGeNumber+100)];
    mainScrollView.showsVerticalScrollIndicator = NO;
    mainScrollView.showsHorizontalScrollIndicator = NO;
    [self.contentView addSubview:mainScrollView];
    
    
    int cellWidth = 10*BILI;
    int distance = 5;
    
    UIView * lineViewX = [[UIView alloc] initWithFrame:CGRectMake(0*BILI, tuBiaoHeight, 5+(cellWidth*2+distance)*list.count, 1)];
    lineViewX.backgroundColor = [UIColor blackColor];
    [mainScrollView addSubview:lineViewX];
    
    for (int i=0; i<list.count; i++)
    {
     
        NSDictionary * info = [list objectAtIndex:i];
        NSNumber * number = [info objectForKey:@"ybjnum"];
        
        UIView * view1 = [[UIView alloc] initWithFrame:CGRectMake(5*BILI+(cellWidth*2+distance)*i, tuBiaoHeight-number.intValue*meiJianHeight, cellWidth, number.intValue*meiJianHeight)];
        view1.backgroundColor = UIColorFromRGB(0x4DBA7A);
        [mainScrollView addSubview:view1];
        
        
        UILabel * numberLable1 = [[UILabel alloc] initWithFrame:CGRectMake(5*BILI+(cellWidth*2+distance)*i, tuBiaoHeight-20*BILI, cellWidth, 20*BILI)];
        numberLable1.font = [UIFont systemFontOfSize:5*BILI];
        numberLable1.adjustsFontSizeToFitWidth = YES;
        numberLable1.textColor = [UIColor blackColor];
        numberLable1.text = [NSString stringWithFormat:@"%d",number.intValue];
        numberLable1.textAlignment = NSTextAlignmentCenter;
        [mainScrollView addSubview:numberLable1];
        
        
        number = [info objectForKey:@"wbjnum"];

        UIView * view2 = [[UIView alloc] initWithFrame:CGRectMake(5*BILI+(cellWidth*2+distance)*i+cellWidth*BILI, tuBiaoHeight-number.intValue*meiJianHeight, cellWidth, number.intValue*meiJianHeight)];
        view2.backgroundColor = UIColorFromRGB(0xF55E4E);
        [mainScrollView addSubview:view2];
        
        UILabel * numberLable2 = [[UILabel alloc] initWithFrame:CGRectMake(5*BILI+(cellWidth*2+distance)*i+cellWidth*BILI, tuBiaoHeight-20*BILI,cellWidth, 20*BILI)];
        numberLable2.font = [UIFont systemFontOfSize:5*BILI];
        numberLable2.adjustsFontSizeToFitWidth = YES;
        numberLable2.textColor = [UIColor blackColor];
        numberLable2.text = [NSString stringWithFormat:@"%d",number.intValue];
        numberLable2.textAlignment = NSTextAlignmentCenter;
        [mainScrollView addSubview:numberLable2];
        
        NSString * titleStr = [info objectForKey:@"gridname"];
        UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(5*BILI+(cellWidth*2+distance)*i+(cellWidth*2-10)/2, tuBiaoHeight+3, 10*BILI, titleStr.length*10*BILI)];
        titleLable.text = titleStr;
        titleLable.textColor = [UIColor blackColor];
        titleLable.font = [UIFont systemFontOfSize:10*BILI];
        titleLable.numberOfLines = titleStr.length;
        [mainScrollView addSubview:titleLable];
        
    }
    [mainScrollView setContentSize:CGSizeMake((cellWidth*2+distance)*list.count+5*BILI, mainScrollView.frame.size.height)];
    
    
    for (int y=0; y<fenGeNumber; y++) {
        
        UILabel * numberLable = [[UILabel alloc] initWithFrame:CGRectMake(0*BILI, 50*BILI+cellHeight*y, 30*BILI, 10*BILI)];
        numberLable.textAlignment = NSTextAlignmentCenter;
        numberLable.textColor = [UIColor blackColor];
        numberLable.font = [UIFont systemFontOfSize:10*BILI];
        if (y==0) {
            
            numberLable.text = [NSString stringWithFormat:@"%d",max];

        }
        else
        {
            numberLable.text = [NSString stringWithFormat:@"%d",cellNumberY*fenGeNumber-cellNumberY*y];

        }
        [self.contentView addSubview:numberLable];
    }
    UIView * lineViewY = [[UIView alloc] initWithFrame:CGRectMake(30*BILI, 50*BILI, 1, tuBiaoHeight)];
    lineViewY.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:lineViewY];
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
