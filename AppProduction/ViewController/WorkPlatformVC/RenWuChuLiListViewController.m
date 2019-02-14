//
//  RenWuChuLiListViewController.m
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/15.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RenWuChuLiListViewController.h"

@interface RenWuChuLiListViewController ()

@end

@implementation RenWuChuLiListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLale.text = @"任务处理";
    self.titleLale.textColor = [UIColor whiteColor];
    [self setTabBarHidden];
    
    self.cloudClient = [CloudClient getInstance];
    
    UIView * topView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, 40*BILI)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    
    weiChuLiPageIndex = 1;
    yiChuLiPageIndex = 1;
    woDeXiaDaPageIndex = 1;
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50*BILI-1, VIEW_WIDTH, 1*BILI)];
    lineView.backgroundColor = UIColorFromRGB(0xEDEFF4);
    [topView addSubview:lineView];
    
    self.weiChuLiButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH/3, 40*BILI)];
    [self.weiChuLiButton setTitleColor:UIColorFromRGB(0xFE9052) forState:UIControlStateNormal];
    [self.weiChuLiButton setTitle:@"未处理" forState:UIControlStateNormal];
    self.weiChuLiButton.titleLabel.font = [UIFont systemFontOfSize:18*BILI];
    [self.weiChuLiButton addTarget:self action:@selector(weiChuLiButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:self.weiChuLiButton];
    
    self.yiChuLiButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH/3, 0, VIEW_WIDTH/3, 40*BILI)];
    [self.yiChuLiButton setTitleColor:UIColorFromRGB(0x787878) forState:UIControlStateNormal];
    [self.yiChuLiButton setTitle:@"已处理" forState:UIControlStateNormal];
    self.yiChuLiButton.titleLabel.font = [UIFont systemFontOfSize:18*BILI];
    [self.yiChuLiButton addTarget:self action:@selector(yiChuLiButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:self.yiChuLiButton];
    
    self.woDeXiaDaButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH/3*2, 0, VIEW_WIDTH/3, 40*BILI)];
    [self.woDeXiaDaButton setTitleColor:UIColorFromRGB(0x787878) forState:UIControlStateNormal];
    [self.woDeXiaDaButton setTitle:@"我的下达" forState:UIControlStateNormal];
    self.woDeXiaDaButton.titleLabel.font = [UIFont systemFontOfSize:18*BILI];
    [self.woDeXiaDaButton addTarget:self action:@selector(woDeXiaDaButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:self.woDeXiaDaButton];
    
    
    
    self.sliderView = [[UIView alloc] initWithFrame:CGRectMake(0, topView.frame.size.height-1, VIEW_WIDTH/3, 1)];
    self.sliderView.backgroundColor = UIColorFromRGB(0xFE9052);
    [topView addSubview:self.sliderView];
    
   
    
    self.weiChuLiTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, topView.frame.origin.y+topView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT-(topView.frame.origin.y+topView.frame.size.height))];
    self.weiChuLiTableView.delegate = self;
    self.weiChuLiTableView.dataSource = self;
    self.weiChuLiTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.weiChuLiTableView.showsVerticalScrollIndicator = FALSE;
    self.weiChuLiTableView.showsHorizontalScrollIndicator = FALSE;
    self.weiChuLiTableView.tag = 0;
    [self.view addSubview:self.weiChuLiTableView];
    
    self.yiChuLiTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, topView.frame.origin.y+topView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT-(topView.frame.origin.y+topView.frame.size.height))];
    self.yiChuLiTableView.delegate = self;
    self.yiChuLiTableView.dataSource = self;
    self.yiChuLiTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.yiChuLiTableView.showsVerticalScrollIndicator = FALSE;
    self.yiChuLiTableView.showsHorizontalScrollIndicator = FALSE;
    self.yiChuLiTableView.tag = 1;
    [self.view addSubview:self.yiChuLiTableView];
    self.yiChuLiTableView.hidden = YES;
    
    self.woDeXiaDaTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, topView.frame.origin.y+topView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT-(topView.frame.origin.y+topView.frame.size.height))];
    self.woDeXiaDaTableView.delegate = self;
    self.woDeXiaDaTableView.dataSource = self;
    self.woDeXiaDaTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.woDeXiaDaTableView.showsVerticalScrollIndicator = FALSE;
    self.woDeXiaDaTableView.showsHorizontalScrollIndicator = FALSE;
    self.woDeXiaDaTableView.tag = 2;
    [self.view addSubview:self.woDeXiaDaTableView];
    self.woDeXiaDaTableView.hidden = YES;
    
    
    UIButton * ruHuZouFangButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-64*BILI-20*BILI, VIEW_HEIGHT-64*BILI-30*BILI, 64*BILI, 64*BILI)];
    [ruHuZouFangButton setBackgroundImage:[UIImage imageNamed:@"ruHuZouFang"] forState:UIControlStateNormal];
    [ruHuZouFangButton addTarget:self action:@selector(xiaDaRenWuButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ruHuZouFangButton];
    
    UILabel * ruHuZouFangLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 36*BILI, 64*BILI, 14*BILI)];
    ruHuZouFangLable.font = [UIFont systemFontOfSize:6*BILI];
    ruHuZouFangLable.textAlignment = NSTextAlignmentCenter;
    ruHuZouFangLable.text = @"下达任务";
    ruHuZouFangLable.textColor = [UIColor whiteColor];
    [ruHuZouFangButton addSubview:ruHuZouFangLable];
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * userInfo = [defaults objectForKey:USERINFO];
    NSNumber * typeNumber = [userInfo objectForKey:@"logintype"];
    if (typeNumber.intValue==2)
    {
        self.weiChuLiButton.frame = CGRectMake(0, 0, VIEW_WIDTH/2, 40*BILI);
        self.yiChuLiButton.frame = CGRectMake(VIEW_WIDTH/2, 0, VIEW_WIDTH/2, 40*BILI);
        self.woDeXiaDaButton.hidden = YES;
        self.sliderView.frame = CGRectMake(0, topView.frame.size.height-1, VIEW_WIDTH/2, 1);
        ruHuZouFangButton.hidden = YES;
    }
    
    self.noContenImageView = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_WIDTH/4, (VIEW_HEIGHT-VIEW_WIDTH/2)/2, VIEW_WIDTH/2, VIEW_WIDTH/2)];
    self.noContenImageView.image = [UIImage imageNamed:@"no_content"];
    self.noContenImageView.hidden = YES;
    [self.view addSubview:self.noContenImageView];
    
    [self.cloudClient renWuChuLiList:@"task.do"
                            pagesize:@"20"
                              pageno:@"1"
                               state:@"0"
                            delegate:self
                            selector:@selector(getWeiChuLiListSuccess:)
                       errorSelector:@selector(getListError:)];
    
    [self.cloudClient renWuChuLiList:@"task.do"
                            pagesize:@"20"
                              pageno:@"1"
                               state:@"1"
                            delegate:self
                            selector:@selector(getYiChuLiListSuccess:)
                       errorSelector:@selector(getListError:)];
    
    [self.cloudClient woDeXiaDaList:@"task!list.do"
                           pagesize:@"20"
                             pageno:@"1"
                           delegate:self
                           selector:@selector(getXiaDaListSuccess:)
                      errorSelector:@selector(getListError:)];
}
-(void)getWeiChuLiListSuccess:(NSArray *)array
{
    weiChuLiPageIndex++;
    if (array.count==20)
    {
        weiChuLiTableViewSection = 2;
        
    }
    else
    {
        weiChuLiTableViewSection = 1;
    }
    self.weiChuLiArray = [[NSMutableArray alloc] initWithArray:array];
    [self.weiChuLiTableView reloadData];
    
    if (self.weiChuLiArray.count==0) {
        
        self.noContenImageView.hidden = NO;
    }
    else
    {
         self.noContenImageView.hidden = YES;
    }
    
}
-(void)getYiChuLiListSuccess:(NSArray *)array
{
    yiChuLiPageIndex++;
    if (array.count==20)
    {
        yiChuLiTableViewSection = 2;
        
    }
    else
    {
        yiChuLiTableViewSection = 1;
    }
    self.yiChuLiArray = [[NSMutableArray alloc] initWithArray:array];
    [self.yiChuLiTableView reloadData];
}
-(void)getXiaDaListSuccess:(NSArray *)array
{
    woDeXiaDaPageIndex++;
    if (array.count==20)
    {
        woDeXiaDaTableViewSection = 2;
        
    }
    else
    {
        woDeXiaDaTableViewSection = 1;
    }
    self.woDeXiaDaArray = [[NSMutableArray alloc] initWithArray:array];
    [self.woDeXiaDaTableView reloadData];
}
-(void)getMoreWeiChuLiListSuccess:(NSArray *)array
{
    weiChuLiPageIndex++;
    if (array.count==20)
    {
        weiChuLiTableViewSection = 2;
        
    }
    else
    {
        weiChuLiTableViewSection = 1;
    }
    for (NSDictionary * info in array) {
        
        [self.weiChuLiArray addObject:info];
    }
    [self.weiChuLiTableView reloadData];
}

-(void)getMoreYiChuLiListSuccess:(NSArray *)array
{
    yiChuLiPageIndex++;
    if (array.count==20)
    {
        yiChuLiTableViewSection = 2;
        
    }
    else
    {
        yiChuLiTableViewSection = 1;
    }
    for (NSDictionary * info in array) {
        
        [self.yiChuLiArray addObject:info];
    }
    [self.yiChuLiTableView reloadData];
}
-(void)getMoreXiaDaListSuccess:(NSArray *)array
{
    woDeXiaDaPageIndex++;
    if (array.count==20)
    {
        woDeXiaDaTableViewSection = 2;
        
    }
    else
    {
        woDeXiaDaTableViewSection = 1;
    }
    for (NSDictionary * info in array) {
        
        [self.woDeXiaDaArray addObject:info];
    }
    [self.woDeXiaDaTableView reloadData];
}

-(void)getListError:(NSDictionary *)info
{
    
}
-(void)weiChuLiButtonClick
{
    
    if (self.weiChuLiArray.count==0) {
        
        self.noContenImageView.hidden = NO;
    }
    else
    {
        self.noContenImageView.hidden = YES;
    }
    self.weiChuLiTableView.hidden = NO;
    self.yiChuLiTableView.hidden = YES;
    self.woDeXiaDaTableView.hidden = YES;
    
    [self.weiChuLiButton setTitleColor:UIColorFromRGB(0xFE9052) forState:UIControlStateNormal];
    [self.yiChuLiButton setTitleColor:UIColorFromRGB(0x787878) forState:UIControlStateNormal];
    [self.woDeXiaDaButton setTitleColor:UIColorFromRGB(0x787878) forState:UIControlStateNormal];
    self.sliderView.frame = CGRectMake(self.weiChuLiButton.frame.origin.x, self.sliderView.frame.origin.y, self.sliderView.frame.size.width, self.sliderView.frame.size.height);
}
-(void)yiChuLiButtonClick
{
    
    if (self.yiChuLiArray.count==0) {
        
        self.noContenImageView.hidden = NO;
    }
    else
    {
        self.noContenImageView.hidden = YES;
    }
    self.weiChuLiTableView.hidden = YES;
    self.yiChuLiTableView.hidden = NO;
    self.woDeXiaDaTableView.hidden = YES;
    
    [self.weiChuLiButton setTitleColor:UIColorFromRGB(0x787878) forState:UIControlStateNormal];
    [self.yiChuLiButton setTitleColor:UIColorFromRGB(0xFE9052) forState:UIControlStateNormal];
    [self.woDeXiaDaButton setTitleColor:UIColorFromRGB(0x787878) forState:UIControlStateNormal];
    self.sliderView.frame = CGRectMake(self.yiChuLiButton.frame.origin.x, self.sliderView.frame.origin.y, self.sliderView.frame.size.width, self.sliderView.frame.size.height);


}
-(void)woDeXiaDaButtonClick
{
    
    if (self.woDeXiaDaArray.count==0) {
        
        self.noContenImageView.hidden = NO;
    }
    else
    {
        self.noContenImageView.hidden = YES;
    }
    self.weiChuLiTableView.hidden = YES;
    self.yiChuLiTableView.hidden = YES;
    self.woDeXiaDaTableView.hidden = NO;
    
    [self.weiChuLiButton setTitleColor:UIColorFromRGB(0x787878) forState:UIControlStateNormal];
    [self.yiChuLiButton setTitleColor:UIColorFromRGB(0x787878) forState:UIControlStateNormal];
    [self.woDeXiaDaButton setTitleColor:UIColorFromRGB(0xFE9052) forState:UIControlStateNormal];
    self.sliderView.frame = CGRectMake(self.woDeXiaDaButton.frame.origin.x, self.sliderView.frame.origin.y, self.sliderView.frame.size.width, self.sliderView.frame.size.height);


}
#pragma mark---UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView.tag==0) {
        
        return weiChuLiTableViewSection;
    }
    else if (tableView.tag==1)
    {
        return yiChuLiTableViewSection;
    }
    else
    {
        return woDeXiaDaTableViewSection;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag==0) {
        if (section==0) {
            
            return self.weiChuLiArray.count;
        }
        else
        {
            return 1;
        }
        
    }
    else if (tableView.tag==1)
    {
        if (section==0) {
            
            return self.yiChuLiArray.count;
        }
        else
        {
            return 1;
        }
    }
    else
    {
        
        if (section==0) {
            
            return self.woDeXiaDaArray.count;
        }
        else
        {
            return 1;
        }
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return  50*BILI;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        if (tableView.tag==0)
        {
            NSString *tableIdentifier = [NSString stringWithFormat:@"TrendsTableViewCell%d",(int)indexPath.row];
            RenWuChuLiListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
            if (cell == nil)
            {
                cell = [[RenWuChuLiListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor whiteColor];
            NSDictionary * info = [self.weiChuLiArray objectAtIndex:indexPath.row];
            [cell initData:info];
            return cell;
            
        }
        else if (tableView.tag==1)
        {
            NSString *tableIdentifier = [NSString stringWithFormat:@"TrendsTableViewCell%d",(int)indexPath.row];
            RenWuChuLiListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
            if (cell == nil)
            {
                cell = [[RenWuChuLiListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor whiteColor];
            NSDictionary * info = [self.yiChuLiArray objectAtIndex:indexPath.row];
            [cell initData:info];
            return cell;
            
        }
        else
        {
           
            NSString *tableIdentifier = [NSString stringWithFormat:@"TrendsTableViewCell%d",(int)indexPath.row];
            RenWuChuLiListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
            if (cell == nil)
            {
                cell = [[RenWuChuLiListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor whiteColor];
            NSDictionary * info = [self.woDeXiaDaArray objectAtIndex:indexPath.row];
            [cell initData:info];
            return cell;
        }
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
    if (tableView.tag==0) {
        
    }
    else if (tableView.tag==1)
    {
        
    }
    else
    {
        NSDictionary * info = [self.woDeXiaDaArray objectAtIndex:indexPath.row];
        RenWuDetailViewController * vc = [[RenWuDetailViewController alloc] init];
        vc.taskid = [info objectForKey:@"taskid"];
        [self.navigationController pushViewController:vc animated:YES];

    }
    
    
}
-(void)xiaDaRenWuButtonClick
{
    XiaDaRenWuViewController * vc = [[XiaDaRenWuViewController alloc] init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)xiaDaTaskSuccess
{
    [Common showToastView:@"下的任务成功" view:self.view];
    woDeXiaDaPageIndex = 1;
    [self.cloudClient woDeXiaDaList:@"task!list.do"
                           pagesize:@"20"
                             pageno:@"1"
                           delegate:self
                           selector:@selector(getXiaDaListSuccess:)
                      errorSelector:@selector(getListError:)];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if( scrollView.contentOffset.y+500 > ((scrollView.contentSize.height - scrollView.frame.size.height))&&scrollView.contentOffset.y>0)
    {
        if (scrollView.tag==0)
        {
            [self.cloudClient renWuChuLiList:@"task.do"
                                    pagesize:@"20"
                                      pageno:[NSString stringWithFormat:@"%d",weiChuLiPageIndex]
                                       state:@"0"
                                    delegate:self
                                    selector:@selector(getMoreWeiChuLiListSuccess:)
                               errorSelector:@selector(getListError:)];
            
        }
        else if (scrollView.tag==1)
        {
            [self.cloudClient renWuChuLiList:@"task.do"
                                    pagesize:@"20"
                                      pageno:[NSString stringWithFormat:@"%d",yiChuLiPageIndex]
                                       state:@"1"
                                    delegate:self
                                    selector:@selector(getMoreYiChuLiListSuccess:)
                               errorSelector:@selector(getListError:)];

        }
        else if (scrollView.tag==2)
        {
            [self.cloudClient woDeXiaDaList:@"task!list.do"
                                   pagesize:@"20"
                                     pageno:[NSString stringWithFormat:@"%d",woDeXiaDaPageIndex]
                                   delegate:self
                                   selector:@selector(getMoreXiaDaListSuccess:)
                              errorSelector:@selector(getListError:)];
        }
        
    }
    
    
    
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
