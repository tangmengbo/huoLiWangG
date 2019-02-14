//
//  BaoLiaoTableViewCell.m
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/9.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BaoLiaoTableViewCell.h"

@implementation BaoLiaoTableViewCell

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
    
    UILabel * messageLable = [[UILabel alloc] initWithFrame:CGRectMake(9*BILI, 8*BILI, 435*BILI/2, 51*BILI)];
    messageLable.font = [UIFont systemFontOfSize:16*BILI];
    messageLable.textColor = UIColorFromRGB(0x4A4A4A);
    messageLable.numberOfLines = 2;
    [self addSubview:messageLable];
    
    CustomImageView * imageView = [[CustomImageView alloc] initWithFrame:CGRectMake(533*BILI/2, 8*BILI, 100*BILI, 185*BILI/2-16*BILI)];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.autoresizingMask = UIViewAutoresizingNone;
    imageView.clipsToBounds = YES;
    [self addSubview:imageView];
    
    UILabel * timeLable = [[UILabel alloc] initWithFrame:CGRectMake(9*BILI, 138*BILI/2, 200*BILI, 15*BILI)];
    timeLable.font = [UIFont systemFontOfSize:10*BILI];
    timeLable.textColor = UIColorFromRGB(0xAEB6BD);
    [self addSubview:timeLable];
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 185*BILI/2-1, VIEW_WIDTH, 1*BILI)];
    lineView.backgroundColor = UIColorFromRGB(0xEDEFF4);
    [self addSubview:lineView];

    if([@"baoLiao" isEqualToString:self.fromWhere])
    {
        NSString * messageStr = [info objectForKey:@"content"];
        if (messageStr) {
            
            NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:messageStr];
            NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
            [paragraphStyle1 setLineSpacing:6];
            [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [messageStr length])];
            [messageLable setAttributedText:attributedString1];
            [messageLable sizeToFit];
            messageLable.lineBreakMode = NSLineBreakByTruncatingTail;
        }
        
        NSArray * imageArray = [info objectForKey:@"imglist"];
        if (imageArray.count>0) {
            
            NSDictionary * info = [imageArray objectAtIndex:0];
            imageView.urlPath = [info objectForKey:@"imgurl"];
        }
        timeLable.text = [info objectForKey:@"tipoffdate"];
    }
    else
    {
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
        
        NSArray * imageArray = [info objectForKey:@"imglist"];
        if (imageArray.count>0) {
            
            NSDictionary * info = [imageArray objectAtIndex:0];
            imageView.urlPath = [info objectForKey:@"imgurl"];
        }
        timeLable.text = [info objectForKey:@"pubdate"];

    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
