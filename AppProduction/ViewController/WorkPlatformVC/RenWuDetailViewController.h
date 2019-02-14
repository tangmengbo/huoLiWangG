//
//  RenWuDetailViewController.h
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/15.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BaseViewController.h"

@interface RenWuDetailViewController : BaseViewController

@property(nonatomic,strong)CloudClient * cloudClient;
@property(nonatomic,strong)UIScrollView * mainScrollView;

@property(nonatomic,strong)NSString * taskid;

@property(nonatomic,strong)NSArray * imageArray;

@end
