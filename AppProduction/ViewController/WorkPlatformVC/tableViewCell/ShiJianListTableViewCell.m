//
//  ShiJianListTableViewCell.m
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/12.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ShiJianListTableViewCell.h"

@implementation ShiJianListTableViewCell

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
    
    CustomImageView * imageView = [[CustomImageView alloc] initWithFrame:CGRectMake(13*BILI, 10*BILI, 60*BILI, 60*BILI)];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.autoresizingMask = UIViewAutoresizingNone;
    imageView.clipsToBounds = YES;
    [self addSubview:imageView];
    
    UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(imageView.frame.origin.x+imageView.frame.size.width+10*BILI, 20*BILI, VIEW_WIDTH-(imageView.frame.origin.x+imageView.frame.size.width+10*BILI+13*BILI), 17*BILI)];
    titleLable.font = [UIFont systemFontOfSize:16*BILI];
    titleLable.textColor = UIColorFromRGB(0x4A4A4A);
    [self addSubview:titleLable];
    
    UILabel * nameLable = [[UILabel alloc] initWithFrame:CGRectMake(titleLable.frame.origin.x, titleLable.frame.origin.y+titleLable.frame.size.height+10*BILI, 100, 13*BILI)];
    nameLable.font = [UIFont systemFontOfSize:13*BILI];
    nameLable.textColor = UIColorFromRGB(0xAEB6BD);
    [self addSubview:nameLable];
    
   
    
    UILabel * timeLable = [[UILabel alloc] initWithFrame:CGRectMake(0, nameLable.frame.origin.y, VIEW_WIDTH-13*BILI, 13*BILI)];
    timeLable.font = [UIFont systemFontOfSize:13*BILI];
    timeLable.textColor = UIColorFromRGB(0xAEB6BD);
    timeLable.textAlignment = NSTextAlignmentRight;
    [self addSubview:timeLable];
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 80*BILI-1, VIEW_WIDTH, 1*BILI)];
    lineView.backgroundColor = UIColorFromRGB(0xEDEFF4);
    [self addSubview:lineView];
    
    
    titleLable.text = [info objectForKey:@"title"];
    nameLable.text = [info objectForKey:@"sbrname"];
    imageView.urlPath = [info objectForKey:@"imgurl"];
    
    timeLable.text = [info objectForKey:@"happenddate"];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
