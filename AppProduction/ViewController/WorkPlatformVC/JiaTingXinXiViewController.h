//
//  JiaTingXinXiViewController.h
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/10.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BaseViewController.h"

@interface JiaTingXinXiViewController : BaseViewController

@property(nonatomic,strong)UIScrollView * mainScrollView;

@property(nonatomic,strong)NSString * holderid;

@property(nonatomic,strong)CloudClient * cloudClient;

@property(nonatomic,strong)NSDictionary * info;

@end
