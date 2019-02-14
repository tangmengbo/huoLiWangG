//
//  ZhengCeXuanChuanListViewController.m
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/11.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ZhengCeXuanChuanListViewController.h"
#

@interface ZhengCeXuanChuanListViewController ()

@end

@implementation ZhengCeXuanChuanListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cloudClient = [CloudClient getInstance];
    self.titleLale.textColor = [UIColor whiteColor];
    self.titleLale.text = self.titleStr;
    
    pageIndex = 1;
    
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT-(self.navView.frame.origin.y+self.navView.frame.size.height))style:UITableViewStyleGrouped];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView.showsVerticalScrollIndicator = FALSE;
    self.mainTableView.showsHorizontalScrollIndicator = FALSE;
    self.mainTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.mainTableView];
    
    self.noContenImageView = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_WIDTH/4, (VIEW_HEIGHT-VIEW_WIDTH/2)/2, VIEW_WIDTH/2, VIEW_WIDTH/2)];
    self.noContenImageView.image = [UIImage imageNamed:@"no_content"];
    self.noContenImageView.hidden = YES;
    [self.view addSubview:self.noContenImageView];

    
    [self initRefreshView];
    
    [self showNewLoadingView:nil view:self.view];
    [self.cloudClient luoBoTuList:@"pubInfo!loopPhotoList.do"
                             type:self.type
                         delegate:self
                         selector:@selector(getLunBoListSuccess:)
                    errorSelector:@selector(getLunBoListError:)];
}
-(void)getLunBoListSuccess:(NSArray *)array
{
    
    self.lunBoList = [[NSArray alloc] initWithArray:array];
    
    [self.cloudClient zhengCeXuanChuanList:@"pubInfo.do"
                                  pagesize:@"10"
                                    pageno:@"1"
                                      type:self.type
                                  delegate:self
                                  selector:@selector(getSourceListSuccess:)
                             errorSelector:@selector(getSourceListError:)];
    
}
-(void)getSourceListSuccess:(NSArray *)array
{
    [self hideNewLoadingView];
    [UIView animateWithDuration:.3 animations:^{
        
        self.xiaLaLable.tag = 0;
        
        self.xiaLaLable.text = @"下拉刷新";
        
        [self.activityView stopAnimating];
        
        self.mainTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
    }];
    
    self.sourceListArray = [[NSMutableArray alloc] initWithArray:array];
    pageIndex ++;
    if (array.count==10) {
        
        mainTableViewSection = 2;
    }
    else
    {
        mainTableViewSection = 1;
    }
    [self.mainTableView reloadData];
}
-(void)getLunBoListError:(NSDictionary *)info
{
    [self.cloudClient zhengCeXuanChuanList:@"pubInfo.do"
                                  pagesize:@"10"
                                    pageno:@"1"
                                      type:self.type
                                  delegate:self
                                  selector:@selector(getSourceListSuccess:)
                             errorSelector:@selector(getSourceListError:)];
}
-(void)getSourceListError:(NSDictionary *)info
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
            
            [self performSelector:@selector(refreshButtonClick) withObject:nil afterDelay:1];
            
            
            
        }];
    }
}
-(void)refreshButtonClick
{
    pageIndex = 1;
    [self.cloudClient zhengCeXuanChuanList:@"pubInfo.do"
                                  pagesize:@"10"
                                    pageno:@"1"
                                      type:self.type
                                  delegate:self
                                  selector:@selector(getSourceListSuccess:)
                             errorSelector:@selector(getSourceListError:)];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if( scrollView.contentOffset.y+500 > ((scrollView.contentSize.height - scrollView.frame.size.height))&&scrollView.contentOffset.y>0)
    {
        
        
        [self.cloudClient zhengCeXuanChuanList:@"pubInfo.do"
                                      pagesize:@"10"
                                        pageno:[NSString stringWithFormat:@"%d",pageIndex]
                                          type:self.type
                                      delegate:self
                                      selector:@selector(getMoreListSuccess:)
                                 errorSelector:@selector(getSourceListError:)];
        
    }
        
    
    
}
-(void)getMoreListSuccess:(NSArray *)list
{
    for (NSDictionary * info in list) {
        
        [self.sourceListArray addObject:info];
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
//有几组数据
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return mainTableViewSection;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        
        return  self.sourceListArray.count;
    }
    else
    {
        return 1;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        
         return  185*BILI/2;
    }
    else
    {
        return  50;
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        [cell initData:[self.sourceListArray objectAtIndex:indexPath.row]];
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
    NSDictionary * info =[self.sourceListArray objectAtIndex:indexPath.row];
    
    HomeWebViewController * vc = [[HomeWebViewController alloc] init];
    vc.url = [info objectForKey:@"viewurl"];
    vc.titleStr = @"宣传详情";
    [self.navigationController pushViewController:vc animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        
        if(self.lunBoList.count>0)
        {
            return VIEW_WIDTH *0.6;
            
        }
        else
        {
            return 0.01f;
        }
    }
    else
    {
        return 0.01f;
    }
 
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        if(self.lunBoList.count>0)
        {
            
            UIView * sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_WIDTH*0.6)];
            sectionView.backgroundColor = [UIColor whiteColor];
            
            JYCarousel * jyScrollView = [[JYCarousel alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH,  VIEW_WIDTH*0.6) configBlock:^JYConfiguration *(JYConfiguration *carouselConfig) {
                carouselConfig.pageContollType = MiddlePageControl;
                carouselConfig.pageTintColor = [UIColor whiteColor];
                carouselConfig.currentPageTintColor = [UIColor lightGrayColor];
                carouselConfig.placeholder = [UIImage imageNamed:@"default"];
                carouselConfig.faileReloadTimes = 5;
                return carouselConfig;
            } target:self];
            [sectionView addSubview:jyScrollView];
            //开始轮播[]
            NSMutableArray * array = [NSMutableArray array];
            for (NSDictionary * info in self.lunBoList) {
                
                [array addObject:[info objectForKey:@"imgurl"]];
                
            }
            [jyScrollView startCarouselWithArray:array];
            
            UIView * titleLableBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, VIEW_WIDTH*0.6-30*BILI, VIEW_WIDTH, 30*BILI)];
            titleLableBottomView.alpha = 0.7;
            titleLableBottomView.backgroundColor = [UIColor blackColor];
            [sectionView addSubview:titleLableBottomView];
            
            self.lubBoTitleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, VIEW_WIDTH*0.6-30*BILI, VIEW_WIDTH, 30*BILI)];
            self.lubBoTitleLable.textAlignment = NSTextAlignmentCenter;
            self.lubBoTitleLable.font = [UIFont systemFontOfSize:15*BILI];
            self.lubBoTitleLable.textAlignment = NSTextAlignmentCenter;
            self.lubBoTitleLable.textColor = [UIColor whiteColor];
            NSDictionary * info = [self.lunBoList objectAtIndex:0];
            self.lubBoTitleLable.text = [info objectForKey:@"title"];
            [sectionView addSubview:self.lubBoTitleLable];
            
            return sectionView;
            
        }
        else
        {
            return nil;
        }
    }
    else
    {
        return nil;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}
-(void)sliderImageIndex:(NSInteger)index
{
    NSDictionary * info = [self.lunBoList objectAtIndex:index];
    self.lubBoTitleLable.text = [info objectForKey:@"title"];
}
- (void)carouselViewClick:(NSInteger)index
{
    NSDictionary * info = [self.lunBoList objectAtIndex:index];
    HomeWebViewController * vc = [[HomeWebViewController alloc] init];
    vc.url = [info objectForKey:@"viewurl"];
    vc.titleStr = @"宣传详情";
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
