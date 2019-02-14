//
//  ZhiShiKuListTableViewCell.m
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/26.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ZhiShiKuListTableViewCell.h"

@implementation ZhiShiKuListTableViewCell

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
    
    UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI,13*BILI, VIEW_WIDTH-26*BILI, 50*BILI)];
    titleLable.textColor = UIColorFromRGB(0x787878);
    titleLable.font = [UIFont systemFontOfSize:16*BILI];
    titleLable.numberOfLines = 0;
    [self addSubview:titleLable];
    
    NSString * messageStr = [info objectForKey:@"title"];
    
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:messageStr];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:6];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [messageStr length])];
    [titleLable setAttributedText:attributedString1];
    [titleLable sizeToFit];
    titleLable.lineBreakMode = NSLineBreakByTruncatingTail;
    titleLable.textAlignment = NSTextAlignmentCenter;
    
    UILabel * timeLable = [[UILabel alloc] initWithFrame:CGRectMake(0, titleLable.frame.origin.y+titleLable.frame.size.height+13*BILI,VIEW_WIDTH-13*BILI, 11*BILI)];
    timeLable.font = [UIFont systemFontOfSize:11*BILI];
    timeLable.textColor = UIColorFromRGB(0xAEB6BD);
    timeLable.textAlignment = NSTextAlignmentRight;
    timeLable.text = [info objectForKey:@"pubdate"];
    [self addSubview:timeLable];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, timeLable.frame.origin.y+timeLable.frame.size.height+13*BILI, VIEW_WIDTH, 0.5)];
    lineView.backgroundColor = UIColorFromRGB(0xdddddd);
    [self addSubview:lineView];
}
@end
