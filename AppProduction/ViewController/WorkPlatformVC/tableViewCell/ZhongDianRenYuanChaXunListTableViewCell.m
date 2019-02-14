//
//  ZhongDianRenYuanChaXunListTableViewCell.m
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ZhongDianRenYuanChaXunListTableViewCell.h"

@implementation ZhongDianRenYuanChaXunListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
    }
    return self;
}
-(void)initData:(NSDictionary *)info
{
    [self removeAllSubviews];
    
    UILabel * nameLable = [[UILabel alloc] initWithFrame:CGRectMake(0,0, VIEW_WIDTH/5*2, 50*BILI)];
    nameLable.font = [UIFont systemFontOfSize:18*BILI];
    nameLable.textColor = UIColorFromRGB(0x4A4A4A);
    nameLable.text = [info objectForKey:@"realname"];
    nameLable.textAlignment = NSTextAlignmentCenter;

    [self addSubview:nameLable];
    
    UILabel * telLable = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_WIDTH/5*2, 0*BILI, VIEW_WIDTH/5*3, 50*BILI)];
    telLable.font = [UIFont systemFontOfSize:15*BILI];
    telLable.textColor = UIColorFromRGB(0x787878);
    telLable.textAlignment = NSTextAlignmentCenter;
    telLable.text = [info objectForKey:@"tel"];
    [self addSubview:telLable];
    
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50*BILI-1, VIEW_WIDTH, 1*BILI)];
    lineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [self addSubview:lineView];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
