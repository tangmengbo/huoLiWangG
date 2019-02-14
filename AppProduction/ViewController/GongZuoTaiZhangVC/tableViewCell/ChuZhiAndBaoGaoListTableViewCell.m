//
//  ChuZhiAndBaoGaoListTableViewCell.m
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/25.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ChuZhiAndBaoGaoListTableViewCell.h"

@implementation ChuZhiAndBaoGaoListTableViewCell

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
    
    UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, 9*BILI, VIEW_WIDTH-26*BILI, 30*BILI)];
    titleLable.font = [UIFont systemFontOfSize:16*BILI];
    titleLable.textColor = UIColorFromRGB(0x4A4A4A);
    [self addSubview:titleLable];
    
    UILabel * telLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 30*BILI,VIEW_WIDTH-23*BILI, 25*BILI)];
    telLable.font = [UIFont systemFontOfSize:13*BILI];
    telLable.textColor = UIColorFromRGB(0x787878);
    telLable.textAlignment = NSTextAlignmentRight;
    [self addSubview:telLable];
    
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 60*BILI-1, VIEW_WIDTH, 1)];
    lineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [self addSubview:lineView];
    
    titleLable.text = [info objectForKey:@"title"];
    if ([info objectForKey:@"sbrname"]) {
        
        telLable.text = [NSString stringWithFormat:@"%@    %@",[info objectForKey:@"sbrname"],[info objectForKey:@"happenddate"]];
    }
    else
    {
        telLable.text = [NSString stringWithFormat:@"  %@",[info objectForKey:@"happenddate"]];
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
