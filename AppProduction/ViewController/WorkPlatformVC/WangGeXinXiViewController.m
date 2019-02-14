//
//  WangGeXinXiViewController.m
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/23.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "WangGeXinXiViewController.h"
#import "DVPieChart.h"
#import "DVFoodPieModel.h"
#import "MYHCircleManageView.h"

@interface WangGeXinXiViewController ()

@end

@implementation WangGeXinXiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTabBarHidden];
    
    self.titleLale.text = @"网格信息";
    self.titleLale.textColor = [UIColor whiteColor];
    
    self.cloudClient = [CloudClient getInstance];
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT-(self.navView.frame.origin.y+self.navView.frame.size.height))];
    [self.view addSubview:self.mainScrollView];
    
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(13*BILI, 13*BILI, VIEW_WIDTH-26*BILI, 180*BILI)];
    self.headerView.backgroundColor = UIColorFromRGB(0x3181F1);
    self.headerView.layer.cornerRadius = 10*BILI;
    self.headerView.layer.masksToBounds = YES;
    [self.mainScrollView addSubview:self.headerView];
    
    
    
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.headerView.frame.origin.y+self.headerView.frame.size.height+13*BILI, VIEW_WIDTH, VIEW_HEIGHT-(self.navView.frame.origin.y+self.navView.frame.size.height))];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView.showsVerticalScrollIndicator = FALSE;
    self.mainTableView.showsHorizontalScrollIndicator = FALSE;
    self.mainTableView.backgroundColor = [UIColor clearColor];
    [self.mainScrollView addSubview:self.mainTableView];
    
    [self showNewLoadingView:nil view:self.view];
    
    
    if (self.gridid) {
        
        [self.cloudClient wangGeLieBiaoList:@"grid!view.do"
                                     gridid:self.gridid
                                   delegate:self
                                   selector:@selector(getMesSuccess:)
                              errorSelector:@selector(getMesError:)];
    }
    else
    {
        [self.cloudClient wangGeXinXi:@"grid.do"
                             delegate:self
                             selector:@selector(getMesSuccess:)
                        errorSelector:@selector(getMesError:)];
    }
}
-(void)getMesSuccess:(NSDictionary *)info
{
    [self hideNewLoadingView];
    self.info = info;
    
    self.titleLale.text = [info objectForKey:@"currgridname"];
    self.titleLale.textColor = [UIColor whiteColor];
    
    NSNumber * number = [info objectForKey:@"hjrknum"];
    UILabel * huJiRenKouLable = [[UILabel alloc] initWithFrame:CGRectMake(0*BILI, 0, (VIEW_WIDTH-26*BILI)/2, 30*BILI)];
    huJiRenKouLable.textColor = [UIColor whiteColor];
    huJiRenKouLable.font = [UIFont systemFontOfSize:13*BILI];
    huJiRenKouLable.text = [NSString stringWithFormat:@"    户籍人口:  %d人",number.intValue];
    [self.headerView addSubview:huJiRenKouLable];
    
    number  = [info objectForKey:@"ldrknum"];
    UILabel * liuDongRenKouLable = [[UILabel alloc] initWithFrame:CGRectMake((VIEW_WIDTH-26*BILI)/2, 0, (VIEW_WIDTH-26*BILI)/2, 30*BILI)];
    liuDongRenKouLable.textColor = [UIColor whiteColor];
    liuDongRenKouLable.font = [UIFont systemFontOfSize:13*BILI];
    liuDongRenKouLable.text = [NSString stringWithFormat:@"    流动人口:  %d人",number.intValue];
    [self.headerView addSubview:liuDongRenKouLable];
    
    number  = [info objectForKey:@"lsrknum"];
    UILabel * liuShouRenKouLable = [[UILabel alloc] initWithFrame:CGRectMake(0*BILI, 30*BILI, (VIEW_WIDTH-26*BILI)/2, 30*BILI)];
    liuShouRenKouLable.textColor = [UIColor whiteColor];
    liuShouRenKouLable.font = [UIFont systemFontOfSize:13*BILI];
    liuShouRenKouLable.text = [NSString stringWithFormat:@"    留守人口:  %d人",number.intValue];
    [self.headerView addSubview:liuShouRenKouLable];
    
    number  = [info objectForKey:@"jwrknum"];
    UILabel * jingWaiRenKouLable = [[UILabel alloc] initWithFrame:CGRectMake((VIEW_WIDTH-26*BILI)/2, 30*BILI, (VIEW_WIDTH-26*BILI)/2, 30*BILI)];
    jingWaiRenKouLable.textColor = [UIColor whiteColor];
    jingWaiRenKouLable.font = [UIFont systemFontOfSize:13*BILI];
    jingWaiRenKouLable.text = [NSString stringWithFormat:@"    境外人员:  %d人",number.intValue];
    [self.headerView addSubview:jingWaiRenKouLable];
    
    
    number  = [info objectForKey:@"wlhrknum"];
    UILabel * weiLuoHuRenKouLable = [[UILabel alloc] initWithFrame:CGRectMake(0*BILI, 60*BILI, (VIEW_WIDTH-26*BILI)/2, 30*BILI)];
    weiLuoHuRenKouLable.textColor = [UIColor whiteColor];
    weiLuoHuRenKouLable.font = [UIFont systemFontOfSize:13*BILI];
    weiLuoHuRenKouLable.text = [NSString stringWithFormat:@"    未落户人口:  %d人",number.intValue];
    [self.headerView addSubview:weiLuoHuRenKouLable];
    
    number  = [info objectForKey:@"xmsfrknum"];
    UILabel * xingShiRenKouLable = [[UILabel alloc] initWithFrame:CGRectMake((VIEW_WIDTH-26*BILI)/2, 60*BILI, (VIEW_WIDTH-26*BILI)/2, 30*BILI)];
    xingShiRenKouLable.textColor = [UIColor whiteColor];
    xingShiRenKouLable.font = [UIFont systemFontOfSize:13*BILI];
    xingShiRenKouLable.text = [NSString stringWithFormat:@"    刑释人员:  %d人",number.intValue];
    [self.headerView addSubview:xingShiRenKouLable];
    
    number  = [info objectForKey:@"sqjzrknum"];
    UILabel * sheQuJiaoZhengLable = [[UILabel alloc] initWithFrame:CGRectMake(0*BILI, 90*BILI, (VIEW_WIDTH-26*BILI)/2, 30*BILI)];
    sheQuJiaoZhengLable.textColor = [UIColor whiteColor];
    sheQuJiaoZhengLable.font = [UIFont systemFontOfSize:13*BILI];
    sheQuJiaoZhengLable.text = [NSString stringWithFormat:@"    社区矫正人员:  %d人",number.intValue];
    [self.headerView addSubview:sheQuJiaoZhengLable];
    
    number  = [info objectForKey:@"xdrknum"];
    UILabel * xiDuRenKouLable = [[UILabel alloc] initWithFrame:CGRectMake((VIEW_WIDTH-26*BILI)/2, 90*BILI, (VIEW_WIDTH-26*BILI)/2, 30*BILI)];
    xiDuRenKouLable.textColor = [UIColor whiteColor];
    xiDuRenKouLable.font = [UIFont systemFontOfSize:13*BILI];
    xiDuRenKouLable.text = [NSString stringWithFormat:@"    吸毒人员:  %d人",number.intValue];
    [self.headerView addSubview:xiDuRenKouLable];
    
    number  = [info objectForKey:@"heresynum"];
    UILabel * sheXieJiaoLable = [[UILabel alloc] initWithFrame:CGRectMake(0*BILI, 120*BILI, (VIEW_WIDTH-26*BILI)/2, 30*BILI)];
    sheXieJiaoLable.textColor = [UIColor whiteColor];
    sheXieJiaoLable.font = [UIFont systemFontOfSize:13*BILI];
    sheXieJiaoLable.text = [NSString stringWithFormat:@"    涉邪教人员:  %d人",number.intValue];
    [self.headerView addSubview:sheXieJiaoLable];
    
    number  = [info objectForKey:@"mentalnum"];
    UILabel * jingShenJiHuanLable = [[UILabel alloc] initWithFrame:CGRectMake((VIEW_WIDTH-26*BILI)/2, 120*BILI, (VIEW_WIDTH-26*BILI)/2, 30*BILI)];
    jingShenJiHuanLable.textColor = [UIColor whiteColor];
    jingShenJiHuanLable.font = [UIFont systemFontOfSize:13*BILI];
    jingShenJiHuanLable.text = [NSString stringWithFormat:@"    精神疾患人员:  %d人",number.intValue];
    [self.headerView addSubview:jingShenJiHuanLable];
    
    number  = [info objectForKey:@"petitionnum"];
    UILabel * zhongDianXinFangLable = [[UILabel alloc] initWithFrame:CGRectMake(0*BILI, 150*BILI, (VIEW_WIDTH-26*BILI)/2, 30*BILI)];
    zhongDianXinFangLable.textColor = [UIColor whiteColor];
    zhongDianXinFangLable.font = [UIFont systemFontOfSize:13*BILI];
    zhongDianXinFangLable.text = [NSString stringWithFormat:@"    重点信访人员:  %d人",number.intValue];
    [self.headerView addSubview:zhongDianXinFangLable];
    
    number  = [info objectForKey:@"dangerousnum"];
    UILabel * weiXianPinCongYeLable = [[UILabel alloc] initWithFrame:CGRectMake((VIEW_WIDTH-26*BILI)/2, 150*BILI, (VIEW_WIDTH-26*BILI)/2, 30*BILI)];
    weiXianPinCongYeLable.textColor = [UIColor whiteColor];
    weiXianPinCongYeLable.font = [UIFont systemFontOfSize:13*BILI];
    weiXianPinCongYeLable.text = [NSString stringWithFormat:@"    危险品从业人员:  %d人",number.intValue];
    [self.headerView addSubview:weiXianPinCongYeLable];
    
     number = [self.info objectForKey:@"currgridleve"];
    if(number.intValue==3)
    {
        [self initRenKouGaiKuangTongJi:self.info];
    }
    else
    {
        self.wgzlist = [info objectForKey:@"wgzlist"];
        self.gridlist = [info objectForKey:@"gridlist"];
        [self.mainTableView reloadData];
        
        self.mainTableView.frame = CGRectMake(0, self.mainTableView.frame.origin.y, VIEW_WIDTH, 80*BILI+50*BILI*(self.wgzlist.count+self.gridlist.count));
        [self.mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH, self.mainTableView.frame.origin.y+self.mainTableView.frame.size.height)];
    }
    
    
    
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
    //NSDictionary * info9 = [[NSDictionary alloc] initWithObjectsAndKeys:[info objectForKey:@"zdxfrknum"],@"number",@"重点信访人员",@"name", nil];
   // NSDictionary * info10 = [[NSDictionary alloc] initWithObjectsAndKeys:[info objectForKey:@"sxjrknum"],@"number",@"涉邪教人员",@"name", nil];
    //NSDictionary * info11 = [[NSDictionary alloc] initWithObjectsAndKeys:[info objectForKey:@"wxpcyrknum"],@"number",@"危险品从业人员",@"name", nil];
    NSDictionary * info12 = [[NSDictionary alloc] initWithObjectsAndKeys:[info objectForKey:@"mentalnum"],@"number",@"精神病疾患人员",@"name", nil];
   // NSDictionary * info13 = [[NSDictionary alloc] initWithObjectsAndKeys:[info objectForKey:@"youngnum"],@"number",@"重点青少年",@"name", nil];
    
    NSArray * array = [[NSArray alloc] initWithObjects:info1,info2,info3,info4,info5,info6,info7,info8,info12, nil];
    DVPieChart *chart = [[DVPieChart alloc] initWithFrame:CGRectMake(0*BILI, self.headerView.frame.origin.y+self.headerView.frame.size.height+20*BILI, VIEW_WIDTH-0*BILI, VIEW_WIDTH+250*BILI)];
    
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
        NSLog(@"%@",model.name);
        model.value = number.intValue;
        [modelArray addObject:model];
        
    }
    chart.dataArray = modelArray;
    
    chart.title = @"";
    
    [chart draw];
    
    
    UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0*BILI, self.headerView.frame.origin.y+self.headerView.frame.size.height+10*BILI, VIEW_WIDTH, 18*BILI)];
    titleLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:18*BILI];
    titleLable.textColor = UIColorFromRGB(0x787878);
    titleLable.text = @"    人口概况统计";
    titleLable.backgroundColor = [UIColor whiteColor];
    [self.mainScrollView addSubview:titleLable];
    
    
    [self.mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH, chart.frame.origin.y+chart.frame.size.height+50*BILI)];
    
}
-(void)getMesError:(NSDictionary *)info
{
    [self hideNewLoadingView];
    [Common showToastView:[info objectForKey:@"message"] view:self.view];
}
#pragma mark---UITableViewDelegate
//有几组数据
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 2;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        
        return  self.wgzlist.count;
    }
    else
    {
        return self.gridlist.count;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        
        return  50*BILI;
    }
    else
    {
        return  50*BILI;
    }
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        
        NSString *tableIdentifier = [NSString stringWithFormat:@"TrendsTableViewCell%d",(int)indexPath.row];
        WangGeXinXiWangGeZhangTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
        if (cell == nil)
        {
            cell = [[WangGeXinXiWangGeZhangTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        [cell initData:[self.wgzlist objectAtIndex:indexPath.row]];
        cell.delegate = self;
        return cell;
    }
    else
    {
        
        NSString *tableIdentifier = [NSString stringWithFormat:@"TrendsTableViewCell%d",(int)indexPath.row];
        WangGeXinXiWangGeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
        if (cell == nil)
        {
            cell = [[WangGeXinXiWangGeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        [cell initData:[self.gridlist objectAtIndex:indexPath.row]];
        cell.delegate = self;
        return cell;
    }
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==1)
    {
        NSNumber * number = [self.info objectForKey:@"currgridleve"];
        
        if(number.intValue==0||number.intValue==1||number.intValue==2)
        {
            NSDictionary * info =[self.gridlist objectAtIndex:indexPath.row];
            WangGeXinXiViewController * vc = [[WangGeXinXiViewController alloc] init];
            vc.gridid = [info objectForKey:@"gridid"];
            [self.navigationController pushViewController:vc animated:YES];
        }
       

    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        
        if(self.wgzlist.count>0)
        {
            return 40*BILI;
            
        }
        else
        {
            return 0.01f;
        }
    }
    else
    {
        return 40*BILI;
    }
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        if(self.wgzlist.count>0)
        {
            
            UILabel * sectionLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, 0, VIEW_WIDTH, 40*BILI)];
            sectionLable.backgroundColor = UIColorFromRGB(0xEEF1F5);
            [sectionLable setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15*BILI]];
            sectionLable.text =[NSString stringWithFormat:@"    %@",[self.info objectForKey:@"wgzlistname"]];
            
            return sectionLable;
            
        }
        else
        {
            return nil;
        }
    }
    else
    {
        UILabel * sectionLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, 0, VIEW_WIDTH, 40*BILI)];
        sectionLable.backgroundColor = UIColorFromRGB(0xEEF1F5);
        [sectionLable setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15*BILI]];
        sectionLable.text =[NSString stringWithFormat:@"    %@",[self.info objectForKey:@"listname"]];
        
        return sectionLable;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}
-(void)telPush:(NSDictionary *)info
{
    NSMutableString* str;
    if ([info objectForKey:@"gridheadertel"]) {
        
        str = [[NSMutableString alloc]initWithFormat:@"telprompt://%@",[info objectForKey:@"gridheadertel"]];
    }
    else
    {
        str = [[NSMutableString alloc]initWithFormat:@"telprompt://%@",[Common getobjectForKey:[info objectForKey:@"wgztel"]]];
    }
   
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:str]];
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
