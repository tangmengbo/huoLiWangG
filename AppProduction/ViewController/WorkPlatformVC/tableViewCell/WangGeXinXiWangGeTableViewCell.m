//
//  WangGeXinXiWangGeTableViewCell.m
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/23.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "WangGeXinXiWangGeTableViewCell.h"

@implementation WangGeXinXiWangGeTableViewCell

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
    self.info = info;
    UILabel * wangGeLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, 0, VIEW_WIDTH/2-13*BILI, 50*BILI)];
    wangGeLable.font = [UIFont systemFontOfSize:13*BILI];
    wangGeLable.textColor =UIColorFromRGB(0x787878);
    wangGeLable.text = [info objectForKey:@"gridname"];
    [self addSubview:wangGeLable];
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(VIEW_WIDTH/2+20*BILI, 15*BILI, 0.5, 20*BILI)];
    lineView.backgroundColor = UIColorFromRGB(0x787878);
    [self addSubview:lineView];
    
    UILabel * nameLable = [[UILabel alloc] initWithFrame:CGRectMake(lineView.frame.origin.x+10*BILI, 0, VIEW_WIDTH-(lineView.frame.origin.x+10*BILI)-40*BILI, 50*BILI)];
    nameLable.font = [UIFont systemFontOfSize:13*BILI];
    nameLable.textColor =UIColorFromRGB(0x787878);
    nameLable.textAlignment = NSTextAlignmentCenter;
    nameLable.text = [info objectForKey:@"gridheader"];
    [self addSubview:nameLable];
    
    UIButton * telButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-50*BILI, 0, 50*BILI, 50*BILI)];
    [telButton addTarget:self action:@selector(telButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:telButton];
    
    UIImageView * telImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15*BILI, 15*BILI, 20*BILI, 20*BILI)];
    telImageView.image = [UIImage imageNamed:@"dianhua"];
    [telButton addSubview:telImageView];
    
    UIView * bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50*BILI-0.5, VIEW_WIDTH, 0.5)];
    bottomLineView.backgroundColor =  UIColorFromRGB(0x787878);
    [self addSubview:bottomLineView];
}
-(void)telButtonClick
{
    [self.delegate telPush:self.info];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
