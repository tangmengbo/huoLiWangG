//
//  XiaoXiListTableViewCell.m
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/9.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "XiaoXiListTableViewCell.h"

@implementation XiaoXiListTableViewCell

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
    UIView * alsoReadView  = [[UIImageView alloc] initWithFrame:CGRectMake(13*BILI, (134*BILI/2-10)*BILI/2, 10*BILI, 10*BILI)];
    alsoReadView.layer.masksToBounds = YES;
    alsoReadView.layer.cornerRadius = 5*BILI;
    alsoReadView.backgroundColor = UIColorFromRGB(0xFE9052);
    [self addSubview:alsoReadView];
    
    if ([[info allKeys] containsObject:@"readflag"])
    {
        NSNumber * readNumber = [info objectForKey:@"readflag"];
        if (readNumber.intValue==1) {//已读
            
            alsoReadView.backgroundColor = UIColorFromRGB(0xA29F9F);
        }
        else
        {
            alsoReadView.backgroundColor = UIColorFromRGB(0xF51616);
        }
    }
    
    
    UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(36*BILI, 9*BILI, VIEW_WIDTH-52*BILI-68*BILI, 23*BILI)];
    titleLable.font = [UIFont systemFontOfSize:16*BILI];
    titleLable.textColor = UIColorFromRGB(0x4A4A4A);
    [self addSubview:titleLable];
    
    UILabel * timeLable = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_WIDTH-68*BILI, 12*BILI, 68*BILI, 15*BILI)];
    timeLable.font = [UIFont systemFontOfSize:10*BILI];
    timeLable.textColor = UIColorFromRGB(0x787878);
    [self addSubview:timeLable];
    
    UILabel * messageLable = [[UILabel alloc] initWithFrame:CGRectMake(36*BILI, titleLable.frame.origin.y+titleLable.frame.size.height+5*BILI, VIEW_WIDTH-36*BILI-13*BILI, 20*BILI)];
    messageLable.font = [UIFont systemFontOfSize:14*BILI];
    messageLable.textColor = UIColorFromRGB(0x787878);
    [self addSubview:messageLable];
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 134*BILI/2-1, VIEW_WIDTH, 1*BILI)];
    lineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [self addSubview:lineView];
    
    titleLable.text = [info objectForKey:@"title"];
    messageLable.text = [info objectForKey:@"content"];
    timeLable.text = [info objectForKey:@"pubdate"];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
