//
//  TongJiFenXiViewController.m
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/12.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TongJiFenXiViewController.h"
#import "DVPieChart.h"
#import "DVFoodPieModel.h"
#import "MYHCircleManageView.h"

@interface TongJiFenXiViewController ()

@end

@implementation TongJiFenXiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTabBarHidden];
    self.titleLale.text = @"统计分析";
    self.titleLale.textColor = [UIColor whiteColor];
    
   self.cloudClient = [CloudClient getInstance];
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT-(self.navView.frame.origin.y+self.navView.frame.size.height))];
    [self.view addSubview:self.mainScrollView];
    
    
    [self initTopButtonView];
    
    
    self.nowInfo =   [Common getNowDateAndWeek];
    self.fenLeiType = @"1";
    self.month = [self.nowInfo objectForKey:@"month"];
    self.jiDu = [self.nowInfo objectForKey:@"jiDu"];
    self.year = [self.nowInfo objectForKey:@"year"];
    
    [self getSourceData];
    
    
    
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
-(void)getSourceData
{
    [self.cloudClient wangGeZhangTongJiFenXi:@"chartGraph.do"
                                        type:self.fenLeiType
                                       month:self.month
                                     quarter:self.jiDu
                                        year:self.year
                                    delegate:self
                                    selector:@selector(getDataSuccess:)
                               errorSelector:@selector(getDataError:)];
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
    [self.mainScrollView removeAllSubviews];
    
   
    [self initShiJianJiBieZhanBiView:[info objectForKey:@"sjlevellist"]];
    
    [self initShiJianChuLiQingKuang:[info objectForKey:@"sjclqklist"]];
    
    [self initShiJianLeiBieZhanBi:[info objectForKey:@"sjtypelist"]];
    
    [self initRenKouGaiKuangTongJi:[info objectForKey:@"rklist"]];
}
-(void)getDataError:(NSDictionary *)info
{
    [Common showToastView:[info objectForKey:@"message"] view:self.view];
}
//事件级别占比
-(void)initShiJianJiBieZhanBiView:(NSArray *)array
{
    UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, 50*BILI, VIEW_WIDTH, 18*BILI)];
    titleLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:18*BILI];
    titleLable.textColor = UIColorFromRGB(0x787878);
    titleLable.text = @"事件级别占比(按事件级别)";
    [self.mainScrollView addSubview:titleLable];
    
    DVPieChart *chart = [[DVPieChart alloc] initWithFrame:CGRectMake(0*BILI, 80*BILI, VIEW_WIDTH-0*BILI, VIEW_WIDTH)];
    chart.radiusBiLi = @"0.34";
    chart.guaiDianY = [NSString stringWithFormat:@"%f",10*BILI];
    [self.mainScrollView addSubview:chart];
    
    
    int total = 0;
    
    for (int i =0; i<array.count; i++)
    {
        NSDictionary * info = [array objectAtIndex:i];
        NSNumber * number = [info objectForKey:@"eventnum"];
        total = total+number.intValue+1;
    }
    
    NSMutableArray * modelArray = [NSMutableArray array];
    for (int i=0; i<array.count; i++) {
        NSDictionary * info = [array objectAtIndex:i];
        
        DVFoodPieModel *model = [[DVFoodPieModel alloc] init];
        NSNumber * number =  [info objectForKey:@"eventnum"];
        model.rate = (number.floatValue+1)/total;
        model.name = [NSString stringWithFormat:@"%@%@",number,[info objectForKey:@"levelname"]];
        model.value = 423651.23;
        
       
        [modelArray addObject:model];
        
    }
    chart.dataArray = modelArray;
    
    chart.title = @"";
    
    [chart draw];
    
}
-(void)initShiJianChuLiQingKuang:(NSDictionary *)info
{
    
    UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, 80*BILI+VIEW_WIDTH, VIEW_WIDTH, 18*BILI)];
    titleLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:18*BILI];
    titleLable.textColor = UIColorFromRGB(0x787878);
    titleLable.text = @"事件处理情况统计";
    [self.mainScrollView addSubview:titleLable];
    
    NSNumber * leiJiNumber = [info objectForKey:@"eventnum"];
    NSNumber * yiChuLiNumber = [info objectForKey:@"overeventnum"];
    
    MYHCircleManageView * circleView2 = [[MYHCircleManageView alloc] initWithFrame:CGRectMake(0, 80*BILI+VIEW_WIDTH+30*BILI, [UIScreen mainScreen].bounds.size.width, VIEW_WIDTH)];
    [circleView2 loadDataArray:@[@{@"number":[NSString stringWithFormat:@"%d",yiChuLiNumber.intValue+1],@"color":UIColorFromRGB(0xDDF4E9),@"name":@"已处理"},
                                 @{@"number":[NSString stringWithFormat:@"%d",(leiJiNumber.intValue-yiChuLiNumber.intValue)+1],@"color":UIColorFromRGB(0x2BB072),@"name":@"未处理"}
                                ] withType:MYHCircleManageViewTypeArc];
    [self.mainScrollView addSubview:circleView2];
    
    UIButton * weiChuLiButton = [[UIButton alloc] initWithFrame:CGRectMake(18*BILI, titleLable.frame.origin.y+30*BILI+55*BILI, 50*BILI, 35*BILI)];
    weiChuLiButton.layer.borderWidth = 2;
    weiChuLiButton.layer.borderColor = [UIColorFromRGB(0x448C66) CGColor];
    weiChuLiButton.backgroundColor = UIColorFromRGB(0x2BB072);//@"60%\n3未处理"
    if(leiJiNumber.intValue==0)
    {
        [weiChuLiButton setTitle:[NSString stringWithFormat:@"%d%@\n%d未处理",0,@"%",(leiJiNumber.intValue-yiChuLiNumber.intValue)] forState:UIControlStateNormal];

    }
    else
    {
        [weiChuLiButton setTitle:[NSString stringWithFormat:@"%d%@\n%d未处理",(leiJiNumber.intValue-yiChuLiNumber.intValue)*100/leiJiNumber.intValue,@"%",(leiJiNumber.intValue-yiChuLiNumber.intValue)] forState:UIControlStateNormal];

    }
    weiChuLiButton.titleLabel.lineBreakMode = 0;
    weiChuLiButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    weiChuLiButton.layer.cornerRadius = 4*BILI;
    weiChuLiButton.titleLabel.font = [UIFont systemFontOfSize:10*BILI];
    [self.mainScrollView addSubview:weiChuLiButton];
    
    UIButton * chuLiButon = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-50*BILI-18*BILI, titleLable.frame.origin.y+30*BILI+VIEW_WIDTH-65*BILI, 50*BILI, 35*BILI)];
    chuLiButon.layer.borderWidth = 2;
    chuLiButon.layer.borderColor = [UIColorFromRGB(0x2BB072) CGColor];
    chuLiButon.backgroundColor = UIColorFromRGB(0xDDF4E9);
    [chuLiButon setTitleColor:UIColorFromRGB(0x448C66) forState:UIControlStateNormal];
    if(leiJiNumber.intValue==0)
    {
        [chuLiButon setTitle:[NSString stringWithFormat:@"%d%@\n%d已处理",0,@"%",yiChuLiNumber.intValue] forState:UIControlStateNormal];

    }
    else
    {
        [chuLiButon setTitle:[NSString stringWithFormat:@"%d%@\n%d已处理",yiChuLiNumber.intValue*100/leiJiNumber.intValue,@"%",yiChuLiNumber.intValue] forState:UIControlStateNormal];

    }
    chuLiButon.titleLabel.lineBreakMode = 0;
    chuLiButon.titleLabel.textAlignment = NSTextAlignmentCenter;
    chuLiButon.layer.cornerRadius = 4*BILI;
    chuLiButon.titleLabel.font = [UIFont systemFontOfSize:10*BILI];
    [self.mainScrollView addSubview:chuLiButon];
  
}
-(void)initShiJianLeiBieZhanBi:(NSArray *)array
{
    
    UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, 80*BILI+VIEW_WIDTH+30*BILI+VIEW_WIDTH, VIEW_WIDTH, 18*BILI)];
    titleLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:18*BILI];
    titleLable.textColor = UIColorFromRGB(0x787878);
    titleLable.text = @"事件类别占比(按大类)";
    [self.mainScrollView addSubview:titleLable];
    
    
    DVPieChart *chart = [[DVPieChart alloc] initWithFrame:CGRectMake(0*BILI, 80*BILI+VIEW_WIDTH+30*BILI+VIEW_WIDTH+30*BILI, VIEW_WIDTH-10*BILI, VIEW_WIDTH+300*BILI)];
    chart.radiusBiLi = @"0.3";
    chart.guaiDianY = [NSString stringWithFormat:@"%f",250*BILI];
    chart.guaiDianX = [NSString stringWithFormat:@"%f",50*BILI];
    chart.lineXWidth = [NSString stringWithFormat:@"%f",60*BILI];
    chart.fontNumber = [NSString stringWithFormat:@"%f",12*BILI];
    [self.mainScrollView addSubview:chart];
    
    
    int total = 0;
    
    for (int i =0; i<array.count; i++)
    {
        NSDictionary * info = [array objectAtIndex:i];
        NSNumber * number = [info objectForKey:@"eventnum"];
        total = total+number.intValue+5;
    }
    
    NSMutableArray * modelArray = [NSMutableArray array];
    for (int i=0; i<array.count; i++) {
        
        DVFoodPieModel *model = [[DVFoodPieModel alloc] init];
        
        NSDictionary * info = [array objectAtIndex:i];
        NSNumber * number = [info objectForKey:@"eventnum"];
        model.rate = (number.floatValue+5)/total;
        model.name = [NSString stringWithFormat:@"%d%@",number.intValue,[info objectForKey:@"bigtype"]];
        model.value = number.intValue;
        [modelArray addObject:model];
        
    }
    chart.dataArray = modelArray;
    
    chart.title = @"";
    
    [chart draw];
    
   
      [self.mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH, chart.frame.origin.y+chart.frame.size.height+50*BILI)];
    
}
-(void)initRenKouGaiKuangTongJi:(NSDictionary *)info
{
    
    NSDictionary * info1 = [[NSDictionary alloc] initWithObjectsAndKeys:[info objectForKey:@"hjrknum"],@"number",@"户籍人口",@"name", nil];
    NSDictionary * info2 = [[NSDictionary alloc] initWithObjectsAndKeys:[info objectForKey:@"ldrknum"],@"number",@"流动人口",@"name", nil];
    NSDictionary * info3 = [[NSDictionary alloc] initWithObjectsAndKeys:[info objectForKey:@"lsrknum"],@"number",@"留守人口",@"name", nil];
    NSDictionary * info4 = [[NSDictionary alloc] initWithObjectsAndKeys:[info objectForKey:@"jwrknum"],@"number",@"境外人员",@"name", nil];
    NSDictionary * info5 = [[NSDictionary alloc] initWithObjectsAndKeys:[info objectForKey:@"wlhrknum"],@"number",@"未落户人口",@"name", nil];
    NSDictionary * info6 = [[NSDictionary alloc] initWithObjectsAndKeys:[info objectForKey:@"xmsfrknum"],@"number",@"刑释人员",@"name", nil];
    NSDictionary * info7 = [[NSDictionary alloc] initWithObjectsAndKeys:[info objectForKey:@"sqjzrknum"],@"number",@"矫正人员",@"name", nil];
    NSDictionary * info8 = [[NSDictionary alloc] initWithObjectsAndKeys:[info objectForKey:@"xdrknum"],@"number",@"吸毒人员",@"name", nil];
    NSDictionary * info9 = [[NSDictionary alloc] initWithObjectsAndKeys:[info objectForKey:@"zdxfrknum"],@"number",@"重点信访人员",@"name", nil];
    NSDictionary * info10 = [[NSDictionary alloc] initWithObjectsAndKeys:[info objectForKey:@"sxjrknum"],@"number",@"涉邪教人员",@"name", nil];
    NSDictionary * info11 = [[NSDictionary alloc] initWithObjectsAndKeys:[info objectForKey:@"wxpcyrknum"],@"number",@"危险品从业人员",@"name", nil];
    NSDictionary * info12 = [[NSDictionary alloc] initWithObjectsAndKeys:[info objectForKey:@"mentalnum"],@"number",@"精神病疾患人员",@"name", nil];
    NSDictionary * info13 = [[NSDictionary alloc] initWithObjectsAndKeys:[info objectForKey:@"youngnum"],@"number",@"重点青少年",@"name", nil];
    
    NSArray * array = [[NSArray alloc] initWithObjects:info1,info2,info3,info4,info5,info6,info7,info8,info9,info10,info11,info12,info13, nil];
    DVPieChart *chart = [[DVPieChart alloc] initWithFrame:CGRectMake(0*BILI, 80*BILI+VIEW_WIDTH+30*BILI+VIEW_WIDTH+30*BILI+VIEW_WIDTH+300*BILI, VIEW_WIDTH-0*BILI, VIEW_WIDTH+250*BILI)];
    
    if(VIEW_WIDTH<375)
    {
        chart.radiusBiLi = [NSString stringWithFormat:@"%f",0.35*BILI];
    }
    else
    {
        chart.radiusBiLi = [NSString stringWithFormat:@"%f",0.35];
    }
    chart.guaiDianY = [NSString stringWithFormat:@"%f",200*BILI];
    [self.mainScrollView addSubview:chart];
    
    
    int total = 0;
    
    for (int i =0; i<array.count; i++)
    {
        NSDictionary * info = [array objectAtIndex:i];
        NSNumber * number = [info objectForKey:@"number"];
        if (number.intValue>100) {
            
            total = total+100+number.intValue/100+5;

        }
        else
        {
            total = total+number.intValue+5;
        }
    }
    
    NSMutableArray * modelArray = [NSMutableArray array];
    for (int i=0; i<array.count; i++) {
        
        NSDictionary * info = [array objectAtIndex:i];
        DVFoodPieModel *model = [[DVFoodPieModel alloc] init];
        
        NSNumber * number = [info objectForKey:@"number"];
        if (number.intValue>100)
        {
            model.rate = (105+number.floatValue/100)/total;
        }
        else
        {
            model.rate = (number.floatValue+5)/total;
        }
        model.name = [NSString stringWithFormat:@"%d%@",number.intValue,[info objectForKey:@"name"]];
        model.value = number.intValue;
        [modelArray addObject:model];
        
    }
    chart.dataArray = modelArray;
    
    chart.title = @"";
    
    [chart draw];
    
    
    UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, 80*BILI+VIEW_WIDTH+30*BILI+VIEW_WIDTH+30*BILI+VIEW_WIDTH+300*BILI, VIEW_WIDTH, 18*BILI)];
    titleLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:18*BILI];
    titleLable.textColor = UIColorFromRGB(0x787878);
    titleLable.text = @"人口概况统计";
    [self.mainScrollView addSubview:titleLable];
    
    
    [self.mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH, chart.frame.origin.y+chart.frame.size.height+50*BILI)];
    
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
