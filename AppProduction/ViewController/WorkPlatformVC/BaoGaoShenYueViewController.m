//
//  BaoGaoShenYueViewController.m
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/14.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BaoGaoShenYueViewController.h"
#import "BaoGaoDetailViewController.h"


@interface BaoGaoShenYueViewController ()

@end

@implementation BaoGaoShenYueViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.cloudClient = [CloudClient getInstance];
    self.titleLale.textColor = [UIColor whiteColor];
    self.titleLale.text = self.titleStr;
    
    pageIndex = 1;
    
    [self setTabBarHidden];
    
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT-(self.navView.frame.origin.y+self.navView.frame.size.height))];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView.showsVerticalScrollIndicator = FALSE;
    self.mainTableView.showsHorizontalScrollIndicator = FALSE;
    self.mainTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.mainTableView];
    
    if ([@"报告列表" isEqualToString:self.titleStr]) {
        
        UIButton * ruHuZouFangButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-64*BILI-20*BILI, VIEW_HEIGHT-64*BILI-30*BILI, 64*BILI, 64*BILI)];
        [ruHuZouFangButton setBackgroundImage:[UIImage imageNamed:@"ruHuZouFang"] forState:UIControlStateNormal];
        [ruHuZouFangButton addTarget:self action:@selector(shangBaoButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:ruHuZouFangButton];
        
        UILabel * ruHuZouFangLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 36*BILI, 64*BILI, 14*BILI)];
        ruHuZouFangLable.font = [UIFont systemFontOfSize:6*BILI];
        ruHuZouFangLable.textAlignment = NSTextAlignmentCenter;
        ruHuZouFangLable.text = @"上报";
        ruHuZouFangLable.textColor = [UIColor whiteColor];
        [ruHuZouFangButton addSubview:ruHuZouFangLable];
        
        [self showNewLoadingView:nil view:self.view];
        [self.cloudClient baoGaoList:@"eventInfo!eventReportList.do"
                            pagesize:@"10"
                              pageno:@"1"
                             eywords:@""
                               sdate:@""
                               edate:@""
                            delegate:self
                            selector:@selector(getBaoGaoListSuccess:)
                       errorSelector:@selector(getListError:)];
    }
    else
    {
        [self.cloudClient baoGaoShenYueList:@"eventInfo!reviewEventList.do"
                                   pagesize:@"10"
                                     pageno:@"1"
                                   keywords:@""
                                      sdate:@""
                                      edate:@""
                                   delegate:self
                                   selector:@selector(getBaoGaoListSuccess:)
                              errorSelector:@selector(getListError:)];
    }
    
    [self initRefreshView];

}
-(void)viewWillAppear:(BOOL)animated
{
    if (![@"报告列表" isEqualToString:self.titleStr]) {
        [self.cloudClient baoGaoShenYueList:@"eventInfo!reviewEventList.do"
                                   pagesize:@"10"
                                     pageno:@"1"
                                   keywords:@""
                                      sdate:@""
                                      edate:@""
                                   delegate:self
                                   selector:@selector(getBaoGaoListSuccess:)
                              errorSelector:@selector(getListError:)];
    }
}
-(void)getBaoGaoListSuccess:(NSArray *)array
{
    [self hideNewLoadingView];
    
    [UIView animateWithDuration:.3 animations:^{
        
        self.xiaLaLable.tag = 0;
        
        self.xiaLaLable.text = @"下拉刷新";
        
        [self.activityView stopAnimating];
        
        self.mainTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
    }];
    
    pageIndex++;
    self.sourceArray = [[NSMutableArray alloc] initWithArray:array];
    if (array.count==10) {
        
        sectionNumber = 2;
    }
    else
    {
        sectionNumber = 1;
    }
    [self.mainTableView reloadData];
}
-(void)getMoreBaoGaoListSuccess:(NSArray *)array
{
    pageIndex++;
    for (NSDictionary * info in array) {
        
        [self.sourceArray addObject:info];
    }
   
    if (array.count==10) {
        
        sectionNumber = 2;
    }
    else
    {
        sectionNumber = 1;
    }
    [self.mainTableView reloadData];
}
-(void)getListError:(NSDictionary *)info
{
    [self hideNewLoadingView];
    
}
//下拉刷新
-(void)initRefreshView
{
    
    
    //下拉刷新
    self.xiaLaLable = [[UILabel alloc] initWithFrame:CGRectMake(0, -50, VIEW_WIDTH, 50)];
    self.xiaLaLable.text  = @"下拉刷新";
    self.xiaLaLable.textAlignment = NSTextAlignmentCenter;
    self.xiaLaLable.tag = 0;
    self.xiaLaLable.font = [UIFont systemFontOfSize:15];
    [self.mainTableView addSubview:self.xiaLaLable];
    
    
    self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityView.frame = CGRectMake(VIEW_WIDTH/2-60, -35, 20, 20);
    self.activityView.hidesWhenStopped = NO;
    [self.mainTableView addSubview:self.activityView];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.y <= -50) {
        if (self.xiaLaLable.tag == 0) {
            self.xiaLaLable.text = @"松开刷新";
        }
        
        self.xiaLaLable.tag = 1;
    }else{
        //防止用户在下拉到contentOffset.y <= -50后不松手，然后又往回滑动，需要将值设为默认状态
        self.xiaLaLable.tag = 0;
        self.xiaLaLable.text = @"下拉刷新";
    }
    
}
//即将结束拖拽
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    
    if (self.xiaLaLable.tag == 1) {
        
        [UIView animateWithDuration:.3 animations:^{
            
            self.xiaLaLable.text = @"加载中...";
            
            [self.activityView startAnimating];
            
            
            scrollView.contentInset = UIEdgeInsetsMake(50.0f, 0.0f, 0.0f, 0.0f);
            
            [self performSelector:@selector(huanYiPiButtonClick) withObject:nil afterDelay:1];
            
            
            
        }];
    }
}
-(void)huanYiPiButtonClick
{
    pageIndex = 1;
    if ([@"报告列表" isEqualToString:self.titleStr]) {
        
        [self.cloudClient baoGaoList:@"eventInfo!eventReportList.do"
                            pagesize:@"10"
                              pageno:@"1"
                             eywords:@""
                               sdate:@""
                               edate:@""
                            delegate:self
                            selector:@selector(getBaoGaoListSuccess:)
                       errorSelector:@selector(getListError:)];
    }
    else
    {
        [self.cloudClient baoGaoShenYueList:@"eventInfo!reviewEventList.do"
                                   pagesize:@"10"
                                     pageno:@"1"
                                   keywords:@""
                                      sdate:@""
                                      edate:@""
                                   delegate:self
                                   selector:@selector(getBaoGaoListSuccess:)
                              errorSelector:@selector(getListError:)];
    }
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if( scrollView.contentOffset.y+500 > ((scrollView.contentSize.height - scrollView.frame.size.height))&&scrollView.contentOffset.y>0)
    {
        if ([@"报告列表" isEqualToString:self.titleStr]) {
            
            [self.cloudClient baoGaoList:@"eventInfo!eventReportList.do"
                                pagesize:@"10"
                                  pageno:[NSString stringWithFormat:@"%d",pageIndex]
                                 eywords:@""
                                   sdate:@""
                                   edate:@""
                                delegate:self
                                selector:@selector(getMoreBaoGaoListSuccess:)
                           errorSelector:@selector(getListError:)];
        }
        else
        {
            [self.cloudClient baoGaoShenYueList:@"eventInfo!reviewEventList.do"
                                       pagesize:@"10"
                                         pageno:[NSString stringWithFormat:@"%d",pageIndex]
                                       keywords:@""
                                          sdate:@""
                                          edate:@""
                                       delegate:self
                                       selector:@selector(getMoreBaoGaoListSuccess:)
                                  errorSelector:@selector(getListError:)];
        }
       
        
    }
    
    
    
}
#pragma mark---UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return sectionNumber;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
      return  self.sourceArray.count;
    }
    else
    {
       return  1;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        
        return  97*BILI;
    }
    else
    {
        return 50;
    }
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        
        NSString *tableIdentifier = [NSString stringWithFormat:@"TrendsTableViewCell%d",(int)indexPath.row];
        BaoGaoShenYueTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
        if (cell == nil)
        {
            cell = [[BaoGaoShenYueTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        NSDictionary * info = [self.sourceArray objectAtIndex:indexPath.row];
        [cell initData:info];
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * info = [self.sourceArray objectAtIndex:indexPath.row];
    
    BaoGaoDetailViewController * vc = [[BaoGaoDetailViewController alloc] init];
    vc.eventid = [info objectForKey:@"eventid"];
    if ([@"报告列表" isEqualToString:self.titleStr])
    {
        vc.fromWhere = @"baoGaoList";
    }
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)shangBaoButtonClick
{
    ShangBaoBaoGaoViewController * vc = [[ShangBaoBaoGaoViewController alloc] init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
   
}
-(void)shagBaoBaoGaoSuccess
{
     [Common showToastView:@"提交成功" view:self.view];
    pageIndex = 1;
    [self.cloudClient baoGaoList:@"eventInfo!eventReportList.do"
                        pagesize:@"10"
                          pageno:@"1"
                         eywords:@""
                           sdate:@""
                           edate:@""
                        delegate:self
                        selector:@selector(getBaoGaoListSuccess:)
                   errorSelector:@selector(getListError:)];
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
