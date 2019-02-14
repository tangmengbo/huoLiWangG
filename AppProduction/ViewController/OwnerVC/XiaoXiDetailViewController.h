//
//  XiaoXiDetailViewController.h
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/25.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BaseViewController.h"

@protocol XiaoXiDetailViewControllerDelegate
@required

- (void)readMyMessageSuccess:(NSDictionary *)info;
@end


@interface XiaoXiDetailViewController : BaseViewController

@property (nonatomic, assign) id<XiaoXiDetailViewControllerDelegate> delegate;


@property(nonatomic,strong)CloudClient * cloudClient;

@property(nonatomic,strong)NSString * xiaoXiType;

@property(nonatomic,strong)UIScrollView * mainScrollView;

@property(nonatomic,strong)NSDictionary * info;

@end
