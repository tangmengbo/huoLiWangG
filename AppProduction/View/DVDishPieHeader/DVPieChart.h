//
//  DVPieChart.h
//  DVPieChart
//
//  Created by SmithDavid on 2018/2/26.
//  Copyright © 2018年 SmithDavid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DVPieChart : UIView

//半径比例
@property(nonatomic,strong)NSString * radiusBiLi;
//拐点的y的比例
@property(nonatomic,strong)NSString * guaiDianY;

@property(nonatomic,strong)NSString * guaiDianX;

@property(nonatomic,strong)NSString * lineXWidth;//横线的长度
@property(nonatomic,strong)NSString * fontNumber;//标注的字体大小

@property(nonatomic,strong)NSString * qianYinXianType;
/**
 数据数组
 */
@property (strong, nonatomic) NSArray *dataArray;

/**
 标题
 */
@property (copy, nonatomic) NSString *title;

/**
 绘制方法
 */
- (void)draw;

@end
