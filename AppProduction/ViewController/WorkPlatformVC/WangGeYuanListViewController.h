//
//  WangGeYuanListViewController.h
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/15.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BaseViewController.h"
#import "WangGeYuanListTableViewCell.h"

@protocol WangGeYuanListViewControllerelegate
@required

- (void)selectWanGeYuan:(NSString *)str ;
@end

@interface WangGeYuanListViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
{
    int pageIndex;
    int sectionNumber;
}


@property (nonatomic, assign) id<WangGeYuanListViewControllerelegate> delegate;

@property(nonatomic,strong)NSString * fromWhere;


@property(nonatomic,strong)CloudClient * cloudClient;
@property(nonatomic,strong)UISearchBar * searchBar;
@property(nonatomic,strong)UILabel * xiaLaLable;
@property(nonatomic,strong)UIActivityIndicatorView * activityView;

@property(nonatomic,strong)UITableView * mainTableView;

@property(nonatomic,strong)NSMutableArray * sourceArray;


@end
