//
//  BaoGaoShenYueTableViewCell.m
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/14.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BaoGaoShenYueTableViewCell.h"

@implementation BaoGaoShenYueTableViewCell

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
    UILabel * messageLable = [[UILabel alloc] initWithFrame:CGRectMake(9*BILI, 10*BILI, 435*BILI/2, 51*BILI)];
    messageLable.font = [UIFont systemFontOfSize:16*BILI];
    messageLable.textColor = UIColorFromRGB(0x4A4A4A);
    messageLable.numberOfLines = 2;
    [self addSubview:messageLable];
    
    UILabel * nameLable = [[UILabel alloc] initWithFrame:CGRectMake(9*BILI, messageLable.frame.origin.y+messageLable.frame.size.height+5*BILI, VIEW_WIDTH, 13*BILI)];
    nameLable.textColor = UIColorFromRGB(0x247EF3);
    nameLable.font = [UIFont systemFontOfSize:13*BILI];
    [self addSubview:nameLable];
    
    CustomImageView * imageView = [[CustomImageView alloc] initWithFrame:CGRectMake(533*BILI/2, 8*BILI, 100*BILI, 185*BILI/2-16*BILI)];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.autoresizingMask = UIViewAutoresizingNone;
    imageView.clipsToBounds = YES;
    [self addSubview:imageView];
    
    UILabel * timeLable = [[UILabel alloc] initWithFrame:CGRectMake(9*BILI, nameLable.frame.origin.y+nameLable.frame.size.height+3*BILI, 200*BILI, 11*BILI)];
    timeLable.font = [UIFont systemFontOfSize:11*BILI];
    timeLable.textColor = UIColorFromRGB(0x247EF3);
    [self addSubview:timeLable];
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 97*BILI-1, VIEW_WIDTH, 1*BILI)];
    lineView.backgroundColor = UIColorFromRGB(0xEDEFF4);
    [self addSubview:lineView];
    
    
    NSString * messageStr = [info objectForKey:@"title"];
    if (messageStr) {
        
        NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:messageStr];
        NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle1 setLineSpacing:6];
        [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [messageStr length])];
        [messageLable setAttributedText:attributedString1];
        [messageLable sizeToFit];
        messageLable.lineBreakMode = NSLineBreakByTruncatingTail;
        

    }
    nameLable.text = [info objectForKey:@"sbrname"];
    
    imageView.urlPath = [info objectForKey:@"imgurl"];
    
    NSNumber * number = [info objectForKey:@"syzt"];
    NSString * str;
    if (0==number.intValue) {
        
        str = [NSString stringWithFormat:@"%@   已审阅",[info objectForKey:@"happenddate"]];
        
    }
    else
    {
        str = [NSString stringWithFormat:@"%@   未审阅",[info objectForKey:@"happenddate"]];
    }
    
    NSAttributedString * str1 = [[NSAttributedString alloc] initWithString:str];
    NSMutableAttributedString * text1 = [[NSMutableAttributedString alloc] initWithAttributedString:str1];
    
    [text1 addAttribute:NSForegroundColorAttributeName
     
                  value:UIColorFromRGB(0xAEB6BD)
     
                  range:NSMakeRange(0, 16)];
    
    
    
    timeLable.attributedText = text1;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
