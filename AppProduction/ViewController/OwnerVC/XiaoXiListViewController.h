//
//  XiaoXiListViewController.h
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/9.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BaseViewController.h"
#import "XiaoXiListTableViewCell.h"
#import "XiaoXiDetailViewController.h"


@interface XiaoXiListViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,XiaoXiDetailViewControllerDelegate>
{
    BOOL alsoTongZhi;
    int mainTableViewSection;
    int pageIndex;
}

@property(nonatomic,strong)UILabel * xiaLaLable;
@property(nonatomic,strong)UIActivityIndicatorView * activityView;


@property(nonatomic,strong)NSString * titleStr;

@property(nonatomic,strong)UITableView * mainTableView;

@property(nonatomic,strong)CloudClient * cloudClient;
@property(nonatomic,strong)NSMutableArray * sourceArray;

@property(nonatomic,strong)NSString * methodStr;

@end
