//
//  WangGeXinXiWangGeZhangTableViewCell.m
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/23.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "WangGeXinXiWangGeZhangTableViewCell.h"

@implementation WangGeXinXiWangGeZhangTableViewCell

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
    
    UILabel * nameLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, 0, VIEW_WIDTH, 50*BILI)];
    nameLable.font = [UIFont systemFontOfSize:13*BILI];
    nameLable.textColor =UIColorFromRGB(0x787878);
    nameLable.text = [info objectForKey:@"wgzname"];
    [self addSubview:nameLable];
    
    UILabel * telLable = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_WIDTH/2, 0, VIEW_WIDTH, 50*BILI)];
    telLable.font = [UIFont systemFontOfSize:13*BILI];
    telLable.textColor =UIColorFromRGB(0x787878);
    telLable.text = [info objectForKey:@"wgztel"];
    [self addSubview:telLable];
    
    UIButton * telButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-40*BILI, 0, 50*BILI, 50*BILI)];
    [telButton addTarget:self action:@selector(telButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:telButton];
    
    UIImageView * telImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15*BILI, 15*BILI, 20*BILI, 20*BILI)];
    telImageView.image = [UIImage imageNamed:@"dianhua"];
    [telButton addSubview:telImageView];

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
