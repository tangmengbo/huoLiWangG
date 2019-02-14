//
//  BaoLiaoTableViewCell.h
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/9.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaoLiaoTableViewCell : UITableViewCell

@property(nonatomic,strong)NSString * fromWhere;
-(void)initData:(NSDictionary *)info;

@end
