//
//  KaoHePingBiListTableViewCell.m
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/27.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "KaoHePingBiListTableViewCell.h"

@implementation KaoHePingBiListTableViewCell

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
-(void)initData:(NSDictionary *)info number:(int)number
{

    UIButton * numberLable = [[UIButton alloc] initWithFrame:CGRectMake(13*BILI, (80-20)*BILI/2, 30*BILI, 20*BILI)];
    numberLable.backgroundColor = UIColorFromRGB(0x5077AA);
    numberLable.layer.cornerRadius = 4*BILI;
    numberLable.titleLabel.font = [UIFont systemFontOfSize:13*BILI];
    [numberLable setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:numberLable];
    
    
    
    UILabel * nameLable = [[UILabel alloc] initWithFrame:CGRectMake(numberLable.frame.origin.x+numberLable.frame.size.width+10*BILI, 9*BILI, VIEW_WIDTH-(numberLable.frame.origin.x+numberLable.frame.size.width+10*BILI), 23*BILI)];
    nameLable.font = [UIFont systemFontOfSize:13*BILI];
    nameLable.textColor = UIColorFromRGB(0x787878);
    [self addSubview:nameLable];
    
    UILabel * scoreLable = [[UILabel alloc] initWithFrame:CGRectMake(0*BILI,numberLable.frame.origin.y, VIEW_WIDTH-13*BILI, 20*BILI)];
    scoreLable.font = [UIFont systemFontOfSize:13*BILI];
    scoreLable.textColor = UIColorFromRGB(0x787878);
    scoreLable.textAlignment = NSTextAlignmentRight;
    [self addSubview:scoreLable];
    
    UILabel * messageLable = [[UILabel alloc] initWithFrame:CGRectMake(nameLable.frame.origin.x, nameLable.frame.origin.y+nameLable.frame.size.height+13*BILI, VIEW_WIDTH-nameLable.frame.origin.x-13*BILI, 13*BILI)];
    messageLable.font = [UIFont systemFontOfSize:13*BILI];
    messageLable.textColor = UIColorFromRGB(0x787878);
    [self addSubview:messageLable];
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 80*BILI-1, VIEW_WIDTH, 1)];
    lineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [self addSubview:lineView];
    
    [numberLable setTitle:[NSString stringWithFormat:@"%d",number] forState:UIControlStateNormal];
    nameLable.text = [info objectForKey:@"realname"];
    NSNumber * scoreNumber = [info objectForKey:@"score"];
    scoreLable.text = [NSString stringWithFormat:@"得分:%d",scoreNumber.intValue];
    messageLable.text = [info objectForKey:@"gridname"];
//    titleLable.text = [info objectForKey:@"title"];
//    messageLable.text = [info objectForKey:@"content"];
//    timeLable.text = [info objectForKey:@"pubdate"];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
