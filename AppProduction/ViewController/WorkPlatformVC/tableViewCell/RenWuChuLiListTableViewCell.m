//
//  RenWuChuLiListTableViewCell.m
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/15.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RenWuChuLiListTableViewCell.h"

@implementation RenWuChuLiListTableViewCell

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
    UIView * pointView = [[UIView alloc] initWithFrame:CGRectMake(13*BILI, (50-10)*BILI/2, 10*BILI, 10*BILI)];
    pointView.layer.masksToBounds = YES;
    pointView.layer.cornerRadius = 5*BILI;
    pointView.backgroundColor = UIColorFromRGB(0x1ADB9F);
    [self addSubview:pointView];
    
    UILabel * reWuNameLable = [[UILabel alloc] initWithFrame:CGRectMake(pointView.frame.origin.x+pointView.frame.size.width+13*BILI, 0*BILI, 450*BILI/2, 50*BILI)];
    reWuNameLable.font = [UIFont systemFontOfSize:16*BILI];
    reWuNameLable.textColor = UIColorFromRGB(0x787878);
    [self addSubview:reWuNameLable];
    
    
    UILabel * timeLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH-13*BILI, 50*BILI)];
    timeLable.font = [UIFont systemFontOfSize:11*BILI];
    timeLable.textColor = UIColorFromRGB(0x787878);
    timeLable.textAlignment = NSTextAlignmentRight;
    [self addSubview:timeLable];
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50*BILI-1, VIEW_WIDTH, 1*BILI)];
    lineView.backgroundColor = UIColorFromRGB(0xEDEFF4);
    [self addSubview:lineView];
    
    if ([@"未完成" isEqualToString:[info objectForKey:@"taskzt"]]) {
        
        pointView.backgroundColor = UIColorFromRGB(0xFE986C);
    }
    else
    {
        pointView.backgroundColor = UIColorFromRGB(0x1ADB9F);
    }
    reWuNameLable.text = [info objectForKey:@"taskname"];
    timeLable.text = [info objectForKey:@"taskdate"];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
