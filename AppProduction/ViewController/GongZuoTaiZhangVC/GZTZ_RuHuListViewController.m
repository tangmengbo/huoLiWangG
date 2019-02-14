//
//  HuZhuMessageListViewController.m
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/10.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "GZTZ_RuHuListViewController.h"

@interface GZTZ_RuHuListViewController ()

@end

@implementation GZTZ_RuHuListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLale.textColor = [UIColor whiteColor];
    
    pageIndex = 1;
    
    [self setTabBarHidden];
    self.cloudClient = [CloudClient getInstance];
    
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, 50)];// 初始化，不解释
    [self.searchBar setShowsCancelButton:NO];// 是否显示取消按钮
    [self.searchBar setTintColor:[UIColor blackColor]];// 搜索框的颜色，当设置此属性时，barStyle将失效
    [self.searchBar setTranslucent:YES];// 设置是否透明
    [self.view addSubview:self.searchBar];
    
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.searchBar.frame.origin.y+self.searchBar.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT-(self.searchBar.frame.origin.y+self.searchBar.frame.size.height))];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView.showsVerticalScrollIndicator = FALSE;
    self.mainTableView.showsHorizontalScrollIndicator = FALSE;
    self.mainTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.mainTableView];
    
    [self initRefreshView];
    
    [self showNewLoadingView:nil view:self.view];
    
   
        self.titleLale.text = @"入户走访";
        //[self.searchBar setPlaceholder:@"请输入户主姓名查询"];// 搜索框的占位符
    self.searchBar.delegate = self;
    [self.searchBar changeLeftPlaceholder:@"请输入户主姓名查询"];

        [self showNewLoadingView:nil view:self.view];
    [self.cloudClient ruHuZouFangXinXiList:@"patrolVisits!houseVisitList.do"
                                  pagesize:@"20"
                                    pageno:@"1"
                                  keywords:self.searchBar.text
                                  delegate:self
                                  selector:@selector(getListSuccess:)
                             errorSelector:@selector(getListError:)];
    
    

    
   

}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    [self refreshList];
}
-(void)getListSuccess:(NSArray *)list
{
    
    [UIView animateWithDuration:.3 animations:^{
        
        self.xiaLaLable.tag = 0;
        
        self.xiaLaLable.text = @"下拉刷新";
        
        [self.activityView stopAnimating];
        
        self.mainTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
    }];
    
    [self hideNewLoadingView];
    pageIndex++;
    self.sourceArray = [[NSMutableArray alloc] initWithArray:list];
    if (list.count==20) {
        
        mainTableViewSection = 2;
    }
    else
    {
        mainTableViewSection = 1;
    }
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
    
    [self.searchBar resignFirstResponder];
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
    [self.cloudClient ruHuZouFangXinXiList:@"patrolVisits!houseVisitList.do"
                                  pagesize:@"20"
                                    pageno:@"1"
                                  keywords:self.searchBar.text
                                  delegate:self
                                  selector:@selector(getListSuccess:)
                             errorSelector:@selector(getListError:)];

}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if( scrollView.contentOffset.y+500 > ((scrollView.contentSize.height - scrollView.frame.size.height))&&scrollView.contentOffset.y>0)
    {
        
        [self.cloudClient ruHuZouFangXinXiList:@"patrolVisits!houseVisitList.do"
                                      pagesize:@"20"
                                        pageno:[NSString stringWithFormat:@"%d",pageIndex]
                                      keywords:self.searchBar.text
                                      delegate:self
                                      selector:@selector(getMoreListSuccess:)
                                 errorSelector:@selector(getListError:)];

        
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
    return mainTableViewSection;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        
        return  self.sourceArray.count;
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
        return  50*BILI;
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
        HuZhuMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
        if (cell == nil)
        {
            cell = [[HuZhuMessageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
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
    NSDictionary * info = [self.sourceArray objectAtIndex:indexPath.row];
    GZTZ_RuHuDetailViewController * vc = [[GZTZ_RuHuDetailViewController alloc] init];
    vc.dataid = [info objectForKey:@"dataid"];
    [self.navigationController pushViewController:vc animated:YES];


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
