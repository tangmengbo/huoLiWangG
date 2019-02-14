//
//  WangGeXinXiViewController.h
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/23.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BaseViewController.h"
#import "WangGeXinXiWangGeTableViewCell.h"
#import "WangGeXinXiWangGeZhangTableViewCell.h"

@interface WangGeXinXiViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,WangGeXinXiWangGeZhangTableViewCellDelegate,WangGeXinXiWangGeTableViewCellDelegate>

@property(nonatomic,strong)CloudClient * cloudClient;
@property(nonatomic,strong)NSString * gridid;
@property(nonatomic,strong)NSDictionary * info;
@property(nonatomic,strong)NSArray * wgzlist;//网格长数组
@property(nonatomic,strong)NSArray * gridlist;//网格列表

@property(nonatomic,strong)UIScrollView * mainScrollView;

@property(nonatomic,strong)UIView * headerView;

@property(nonatomic,strong)UITableView * mainTableView;

@end
