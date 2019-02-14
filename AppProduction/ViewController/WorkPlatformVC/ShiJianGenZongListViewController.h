//
//  ShiJianGenZongListViewController.h
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/12.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BaseViewController.h"
#import "ShiJianListTableViewCell.h"

@interface ShiJianGenZongListViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    int pageIndex;
    int sectionNumber;
}

@property(nonatomic,strong)CloudClient * cloudClient;
@property(nonatomic,strong)UISearchBar * searchBar;
@property(nonatomic,strong)UILabel * xiaLaLable;
@property(nonatomic,strong)UIActivityIndicatorView * activityView;

@property(nonatomic,strong)UITableView * mainTableView;

@property(nonatomic,strong)NSMutableArray * sourceArray;

@end
