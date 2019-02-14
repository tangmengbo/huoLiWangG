//
//  BaoLiaoHomeViewController.m
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/9.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BaoLiaoHomeViewController.h"

@interface BaoLiaoHomeViewController ()

@end

@implementation BaoLiaoHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLale.textColor = [UIColor whiteColor];
    self.titleLale.text = @"爆料";

   
    
    self.cloudClient = [CloudClient getInstance];
 
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, 50)];// 初始化，不解释
    //[self.searchBar setPlaceholder:@"请输入关键字"];// 搜索框的占位符
    self.searchBar.delegate = self;
    [self.searchBar changeLeftPlaceholder:@"请输入关键字"];

    [self.searchBar setShowsCancelButton:NO];// 是否显示取消按钮
    [self.searchBar setTintColor:[UIColor blackColor]];// 搜索框的颜色，当设置此属性时，barStyle将失效
    [self.searchBar setTranslucent:YES];// 设置是否透明
    [self.view addSubview:self.searchBar];
    
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.searchBar.frame.origin.y+self.searchBar.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT-(self.searchBar.frame.origin.y+self.searchBar.frame.size.height+SafeAreaBottomHeight))];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView.showsVerticalScrollIndicator = FALSE;
    self.mainTableView.showsHorizontalScrollIndicator = FALSE;
    self.mainTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.mainTableView];
    
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * userInfo = [userDefaults objectForKey:USERINFO];
    NSNumber * typeNumber = [userInfo objectForKey:@"logintype"];
    if (typeNumber.intValue==1)//网格长
    {
        self.backImageView.frame = CGRectMake(self.backImageView.frame.origin.x, (self.navView.frame.size.height-18*BILIY)/2,  18*59/65*BILI, 18*BILIY);
        self.backImageView.image = [UIImage imageNamed:@"xiaoxi_lingDang"];
        
        
        self.view.backgroundColor = UIColorFromRGB(0xEEF1F5);
        
        UIButton * rightButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-50*BILI, 0, 50*BILI, self.navView.frame.size.height)];
        [rightButton addTarget:self action:@selector(bangZhuButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [rightButton setTitle:@"帮助" forState:UIControlStateNormal];
        [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        rightButton.titleLabel.font = [UIFont systemFontOfSize:16*BILI];
        [self.navView addSubview:rightButton];
        
    }
    else if (typeNumber.intValue==4)//综治
    {
        self.mainTableView.frame = CGRectMake(0, self.searchBar.frame.origin.y+self.searchBar.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT-(self.searchBar.frame.origin.y+self.searchBar.frame.size.height));
    }
    
    if (typeNumber.intValue==3||typeNumber.intValue==6) {
        
        UIButton * ruHuZouFangButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-64*BILI-20*BILI, VIEW_HEIGHT-64*BILI-30*BILI, 64*BILI, 64*BILI)];
        [ruHuZouFangButton setBackgroundImage:[UIImage imageNamed:@"ruHuZouFang"] forState:UIControlStateNormal];
        [ruHuZouFangButton addTarget:self action:@selector(baoLiaoButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:ruHuZouFangButton];
        
        UILabel * ruHuZouFangLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 36*BILI, 64*BILI, 14*BILI)];
        ruHuZouFangLable.font = [UIFont systemFontOfSize:6*BILI];
        ruHuZouFangLable.textAlignment = NSTextAlignmentCenter;
        ruHuZouFangLable.text = @"我要爆料";
        ruHuZouFangLable.textColor = [UIColor whiteColor];
        [ruHuZouFangButton addSubview:ruHuZouFangLable];
    }
    
    [self initRefreshView];
    
    [self showNewLoadingView:nil view:self.view];
    [self.cloudClient baoLiaoList:@"tipOffInfo.do"
                         pagesize:@"10"
                           pageno:@"1"
                         keywords:self.searchBar.text
                         delegate:self
                         selector:@selector(getListSuccess:)
                    errorSelector:@selector(getListError:)];

}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    [self huanYiPiButtonClick];
}
-(void)baoLiaoButtonClick
{
    WoYaoBaoLiaoViewController * vc = [[WoYaoBaoLiaoViewController alloc] init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)baoLiaoShangBaoSuccess
{
    pageIndex = 1;
    [self.cloudClient baoLiaoList:@"tipOffInfo.do"
                         pagesize:@"10"
                           pageno:@"1"
                         keywords:self.searchBar.text
                         delegate:self
                         selector:@selector(getListSuccess:)
                    errorSelector:@selector(getListError:)];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self setTabBarShow];
}
-(void)getListSuccess:(NSArray *)array
{
    
    [UIView animateWithDuration:.3 animations:^{
        
        self.xiaLaLable.tag = 0;
        
        self.xiaLaLable.text = @"下拉刷新";
        
        [self.activityView stopAnimating];
        
        self.mainTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
    }];
    
    [self hideNewLoadingView];
    
//    NSData *joinUsersData;
//    NSArray * array ;
//    if (result !=nil && result.length>0) {
//
//        joinUsersData=[result dataUsingEncoding:NSUTF8StringEncoding];
//        array =   [NSJSONSerialization JSONObjectWithData:joinUsersData options:kNilOptions error:nil];
//    }
    self.sourceArray = [[NSMutableArray alloc] initWithArray:array];
    pageIndex++;
    
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
            
            [self performSelector:@selector(huanYiPiButtonClick) withObject:nil afterDelay:1];
            
            
            
        }];
    }
}
-(void)huanYiPiButtonClick
{
    pageIndex=1;
    [self.cloudClient baoLiaoList:@"tipOffInfo.do"
                         pagesize:@"10"
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
        
        [self.cloudClient baoLiaoList:@"tipOffInfo.do"
                             pagesize:@"10"
                               pageno:[NSString stringWithFormat:@"%d",pageIndex]
                             keywords:self.searchBar.text
                             delegate:self
                             selector:@selector(getMoreListSuccess:)
                        errorSelector:@selector(getListError:)];
        
    }
    
    
    
}
-(void)getMoreListSuccess:(NSArray *)array
{
//    NSData *joinUsersData;
//    NSArray * array ;
//    if (result !=nil && result.length>0) {
//
//        joinUsersData=[result dataUsingEncoding:NSUTF8StringEncoding];
//        array =   [NSJSONSerialization JSONObjectWithData:joinUsersData options:kNilOptions error:nil];
//    }
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
    pageIndex++;
    [self.mainTableView reloadData];
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
        return 1;
    }
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        
        return  185*BILI/2;
    }
    else
    {
        return 50;
    }
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        
        NSString *tableIdentifier = [NSString stringWithFormat:@"TrendsTableViewCell%d",(int)indexPath.row];
        BaoLiaoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
        if (cell == nil)
        {
            cell = [[BaoLiaoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
        }
        cell.fromWhere = @"baoLiao";
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
    BaoLiaoDetailViewController * vc = [[BaoLiaoDetailViewController alloc] init];
    vc.info = info;
    [self.navigationController pushViewController:vc animated:YES];
    
    
}
-(void)leftClick
{
    
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * userInfo = [userDefaults objectForKey:USERINFO];
    NSNumber * typeNumber = [userInfo objectForKey:@"logintype"];
    if (typeNumber.intValue==1)//网格长
    {
        XiaoXiClassifyViewController * vc = [[XiaoXiClassifyViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    else if (typeNumber.intValue==4||typeNumber.intValue ==3||typeNumber.intValue==6)//综治
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
   
}
-(void)bangZhuButtonClick
{
    BangZhuListViewController * vc = [[BangZhuListViewController alloc] init];
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
