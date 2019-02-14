//
//  ZhongDianChangSuoListTableViewCell.m
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/19.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ZhongDianChangSuoListTableViewCell.h"

@implementation ZhongDianChangSuoListTableViewCell

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
    float lableWidth = (VIEW_WIDTH-26*BILI-10*BILI)/3;
    [self removeAllSubviews];
    UILabel * nameLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI,0, lableWidth, 50*BILI)];
    nameLable.font = [UIFont systemFontOfSize:13*BILI];
    nameLable.textColor = UIColorFromRGB(0x4A4A4A);
    nameLable.text = [info objectForKey:@"placename"];
    [self addSubview:nameLable];
    
    UILabel * telLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI+lableWidth+5*BILI, 0*BILI, lableWidth, 50*BILI)];
    telLable.font = [UIFont systemFontOfSize:13*BILI];
    telLable.textColor = UIColorFromRGB(0x787878);
    telLable.textAlignment = NSTextAlignmentRight;
    telLable.text = [info objectForKey:@"headertel"];
    telLable.adjustsFontSizeToFitWidth = YES;
    [self addSubview:telLable];
    
    UILabel * fuZeRenLableLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI+lableWidth*2+10*BILI, 0*BILI, lableWidth, 50*BILI)];
    fuZeRenLableLable.font = [UIFont systemFontOfSize:13*BILI];
    fuZeRenLableLable.textColor = UIColorFromRGB(0x787878);
    fuZeRenLableLable.textAlignment = NSTextAlignmentRight;
    fuZeRenLableLable.text = [info objectForKey:@"placeheader"];
    fuZeRenLableLable.adjustsFontSizeToFitWidth = YES;
    [self addSubview:fuZeRenLableLable];
    
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50*BILI-1, VIEW_WIDTH, 1*BILI)];
    lineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [self addSubview:lineView];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
