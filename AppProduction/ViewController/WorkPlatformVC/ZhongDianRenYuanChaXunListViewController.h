//
//  ZhongDianRenYuanListViewController.h
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BaseViewController.h"
#import "ZhongDianRenYuanChaXunListTableViewCell.h"

@interface ZhongDianRenYuanChaXunListViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    int mainTableViewSection;
    int pageIndex;
}

@property(nonatomic,strong)CloudClient * cloudClient;
@property(nonatomic,strong)UISearchBar * searchBar;
@property(nonatomic,strong)UILabel * xiaLaLable;
@property(nonatomic,strong)UIActivityIndicatorView * activityView;

@property(nonatomic,strong)UITableView * mainTableView;

@property(nonatomic,strong)NSMutableArray * sourceArray;

@end
