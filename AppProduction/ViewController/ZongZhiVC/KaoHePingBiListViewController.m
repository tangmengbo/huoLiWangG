//
//  KaoHePingBiListViewController.m
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/27.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "KaoHePingBiListViewController.h"
#import "KaoHePingBiListTableViewCell.h"

@interface KaoHePingBiListViewController ()

@end

@implementation KaoHePingBiListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titleLale.textColor = [UIColor whiteColor];
    self.titleLale.text = @"考核";
    
    [self setTabBarHidden];
    
    pageIndex = 1;
    self.nowInfo =   [Common getNowDateAndWeek];
    self.fenLeiType = @"1";
    self.month = [self.nowInfo objectForKey:@"month"];
    self.jiDu = [self.nowInfo objectForKey:@"jiDu"];
    self.year = [self.nowInfo objectForKey:@"year"];
    self.cloudClient = [CloudClient getInstance];
    [self getSourceData];
    
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height+50*BILI, VIEW_WIDTH, VIEW_HEIGHT-(self.navView.frame.origin.y+self.navView.frame.size.height+50*BILI))];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView.showsVerticalScrollIndicator = FALSE;
    self.mainTableView.showsHorizontalScrollIndicator = FALSE;
    self.mainTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.mainTableView];
    
    [self initTopButtonView];

}
-(void)getSourceData
{
    [self showNewLoadingView:nil view:self.view];
    pageIndex = 1;
    [self.cloudClient kaoHePingBiList:@"assessScore.do"
                             pagesize:@"10"
                               pageno:@"1"
                           assesstype:self.fenLeiType
                                month:self.month
                              quarter:self.jiDu
                                 year:self.year
                             keywords:@""
                             delegate:self
                             selector:@selector(getListSuccess:)
                        errorSelector:@selector(getListError:)];
}
-(void)getListSuccess:(NSArray *)array
{
    [self hideNewLoadingView];
    if (array.count==10) {
        
        mainTableViewSection = 2;
    }
    else
    {
        mainTableViewSection = 1;
    }
    self.kaoHeList = [[NSMutableArray alloc] initWithArray:array];
    [self.mainTableView reloadData];
}
-(void)getListError:(NSDictionary *)info
{
    [self hideNewLoadingView];
    [Common showToastView:[info objectForKey:@"message"] view:self.view];
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

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if( scrollView.contentOffset.y+500 > ((scrollView.contentSize.height - scrollView.frame.size.height))&&scrollView.contentOffset.y>0)
    {
        
        [self.cloudClient kaoHePingBiList:@"assessScore.do"
                                 pagesize:@"10"
                                   pageno:[NSString stringWithFormat:@"%d",pageIndex]
                               assesstype:self.fenLeiType
                                    month:self.month
                                  quarter:self.jiDu
                                     year:self.year
                                 keywords:@""
                                 delegate:self
                                 selector:@selector(getListSuccess:)
                            errorSelector:@selector(getListError:)];
        
        
    }
    
    
    
}
-(void)getMoreListSuccess:(NSArray *)list
{
    for (NSDictionary * info in list) {
        
        [self.kaoHeList addObject:info];
    }
    if (list.count==10) {
        
        mainTableViewSection = 2;
    }
    else
    {
        mainTableViewSection = 1;
    }
    pageIndex++;
    [self.mainTableView reloadData];
}

#pragma mark---UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return mainTableViewSection;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        
        return  self.kaoHeList.count;
    }
    else
    {
        return 1;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        return  80*BILI;
    }
    else
    {
        return  50;
    }
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        
        NSString *tableIdentifier = [NSString stringWithFormat:@"TrendsTableViewCell%d",(int)indexPath.row];
        KaoHePingBiListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
        if (cell == nil)
        {
            cell = [[KaoHePingBiListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        [cell initData:[self.kaoHeList objectAtIndex:indexPath.row] number:(int)indexPath.row+1];
        return cell;
    }
    else
    {
        static NSString *tableIdentifier = @"SearchListDownloadTableViewCell";
        SearchListDownloadTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
        if (cell == nil)
        {
            cell = [[SearchListDownloadTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
        }
        [cell initData:nil];
        return cell;
    }
    
    
}
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.section ==0)
//    {
//        
//        ShiJianDetailViewController * vc = [[ShiJianDetailViewController alloc] init];
//        NSDictionary * info = [self.sourceArray objectAtIndex:indexPath.row];
//        vc.eventid = [info objectForKey:@"eventid"];
//        [self.navigationController pushViewController:vc animated:YES];
//        
//    }
//    
//    
//}
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
