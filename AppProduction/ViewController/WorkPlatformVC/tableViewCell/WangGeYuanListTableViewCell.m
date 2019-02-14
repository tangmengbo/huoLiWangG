//
//  WangGeYuanListTableViewCell.m
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/15.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "WangGeYuanListTableViewCell.h"

@implementation WangGeYuanListTableViewCell

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
    
    UILabel * wangGeLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI,0, VIEW_WIDTH-13*BILI-93*BILI, 70*BILI)];
    wangGeLable.font = [UIFont systemFontOfSize:16*BILI];
    wangGeLable.textColor = UIColorFromRGB(0x4A4A4A);
    wangGeLable.numberOfLines = 2;
    wangGeLable.text = [info objectForKey:@"gridname"];
    wangGeLable.adjustsFontSizeToFitWidth = YES;
    [self addSubview:wangGeLable];
    
    UILabel * nameLable = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_WIDTH-93*BILI, 0*BILI, 80*BILI, 70*BILI)];
    nameLable.font = [UIFont systemFontOfSize:16*BILI];
    nameLable.textColor = UIColorFromRGB(0x787878);
    nameLable.textAlignment = NSTextAlignmentRight;
    nameLable.adjustsFontSizeToFitWidth = YES;
    nameLable.text = [info objectForKey:@"realname"];
    [self addSubview:nameLable];
    
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 70*BILI-1, VIEW_WIDTH, 1*BILI)];
    lineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [self addSubview:lineView];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
