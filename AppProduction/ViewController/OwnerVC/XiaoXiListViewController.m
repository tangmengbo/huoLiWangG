//
//  XiaoXiListViewController.m
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/9.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "XiaoXiListViewController.h"

@interface XiaoXiListViewController ()

@end

@implementation XiaoXiListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTabBarHidden];
    self.titleLale.text =  self.titleStr;
    self.titleLale.textColor = [UIColor whiteColor];
    self.cloudClient = [CloudClient getInstance];
    
    self.view.backgroundColor =UIColorFromRGB(0xEEF1F5);
    
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT-(self.navView.frame.origin.y+self.navView.frame.size.height))];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView.showsVerticalScrollIndicator = FALSE;
    self.mainTableView.showsHorizontalScrollIndicator = FALSE;
    self.mainTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.mainTableView];
    
    [self initRefreshView];
    
    if ([@"公告广播" isEqualToString:self.titleStr]) {
        
        self.methodStr = @"notice.do";
        alsoTongZhi = NO;
    }
    else if ([@"通知" isEqualToString:self.titleStr])
    {
        self.methodStr = @"notice!noticeList.do";
        alsoTongZhi = YES;
    }
    else if ([@"预警消息" isEqualToString:self.titleStr])
    {
        self.methodStr = @"notice!warningMsgList.do";
        alsoTongZhi = NO;
    }
    else if([@"我的消息" isEqualToString:self.titleStr])
    {
        self.methodStr = @"notice!myMsgList.do";
        alsoTongZhi = NO;
    }
    
    [self showNewLoadingView:nil view:self.view];
    if (alsoTongZhi) {
        
        [self.cloudClient tongZhiList:self.methodStr
                             delegate:self
                             selector:@selector(getListSuccess:)
                        errorSelector:@selector(getListError:)];
    }
    else
    {
        [self.cloudClient gongGaoYuJingAndMyMessageList:self.methodStr
                                               pagesize:@"20"
                                                 pageno:@"1"
                                               delegate:self
                                               selector:@selector(getListSuccess:)
                                          errorSelector:@selector(getListError:)];
    }
}
-(void)getListSuccess:(NSArray *)list
{
    [self hideNewLoadingView];
    [UIView animateWithDuration:.3 animations:^{
        
        self.xiaLaLable.tag = 0;
        
        self.xiaLaLable.text = @"下拉刷新";
        
        [self.activityView stopAnimating];
        
        self.mainTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
    }];
    
    if (list.count==20) {
        
        mainTableViewSection = 2;
    }
    else
    {
        mainTableViewSection = 1;
    }
    pageIndex++;
    self.sourceArray = [[NSMutableArray alloc] initWithArray:list];
    [self.mainTableView reloadData];
}
-(void)getListError:(NSDictionary *)info
{
    [self hideNewLoadingView];
    [Common showToastView:[info objectForKey:@"message"] view:self.view];
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
            
            [self performSelector:@selector(refreshList) withObject:nil afterDelay:1];
            
            
            
        }];
    }
}
-(void)refreshList
{
    pageIndex = 1;
    if (!alsoTongZhi)
    {
        [self.cloudClient tongZhiList:self.methodStr
                             delegate:self
                             selector:@selector(getListSuccess:)
                        errorSelector:@selector(getListError:)];
    }
    else
    {
        [self.cloudClient gongGaoYuJingAndMyMessageList:self.methodStr
                                               pagesize:@"20"
                                                 pageno:@"1"
                                               delegate:self
                                               selector:@selector(getListSuccess:)
                                          errorSelector:@selector(getListError:)];
    }
    
    
  
    
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if( scrollView.contentOffset.y+500 > ((scrollView.contentSize.height - scrollView.frame.size.height))&&scrollView.contentOffset.y>0)
    {
        if (!alsoTongZhi) {
            
            [self.cloudClient gongGaoYuJingAndMyMessageList:self.methodStr
                                                   pagesize:@"20"
                                                     pageno:[NSString stringWithFormat:@"%d",pageIndex]
                                                   delegate:self
                                                   selector:@selector(getMoreListSuccess:)
                                              errorSelector:@selector(getListError:)];
            
        }
        
        
        
    }
    
    
    
}
-(void)getMoreListSuccess:(NSArray *)list
{
    for (NSDictionary * info in list) {
        
        [self.sourceArray addObject:info];
    }
    if (list.count==20) {
        
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
    if (alsoTongZhi) {
        
        return 1;
    }
    else
    {
        return mainTableViewSection;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        
        return self.sourceArray.count;
    }
    else
    {
        return 1;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
   
    if (indexPath.section==0) {
        
         return  134*BILI/2;
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
        XiaoXiListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
        if (cell == nil)
        {
            cell = [[XiaoXiListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        [cell initData:[self.sourceArray objectAtIndex:indexPath.row]];
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
    XiaoXiDetailViewController * vc = [[XiaoXiDetailViewController alloc] init];
    vc.info = [self.sourceArray objectAtIndex:indexPath.row];
    vc.xiaoXiType = self.titleStr;
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)readMyMessageSuccess:(NSDictionary *)info
{
    for (int i=0; i<self.sourceArray.count; i++) {
        NSDictionary * info1 = [self.sourceArray objectAtIndex:i];
        if ([[info1 objectForKey:@"msgid"] isEqualToString:[info objectForKey:@"msgid"]]) {
            
            [self.sourceArray replaceObjectAtIndex:i withObject:info];
            break;
        }
    }
    [self.mainTableView reloadData];
    
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
