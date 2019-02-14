//
//  HuZhuMessageTableViewCell.m
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/10.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "HuZhuMessageTableViewCell.h"

@implementation HuZhuMessageTableViewCell

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
    UILabel * nameLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI,0, VIEW_WIDTH-82*BILI, 50*BILI)];
    nameLable.font = [UIFont systemFontOfSize:18*BILI];
    nameLable.textColor = UIColorFromRGB(0x4A4A4A);
    nameLable.text = [info objectForKey:@"realname"];
    [self addSubview:nameLable];
    
    UILabel * telLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0*BILI, VIEW_WIDTH-23*BILI, 50*BILI)];
    telLable.font = [UIFont systemFontOfSize:13*BILI];
    telLable.textColor = UIColorFromRGB(0x787878);
    telLable.textAlignment = NSTextAlignmentRight;
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
