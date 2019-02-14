//
//  XiaoXiDetailViewController.m
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/25.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "XiaoXiDetailViewController.h"

@interface XiaoXiDetailViewController ()

@end

@implementation XiaoXiDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.cloudClient = [CloudClient getInstance];
    
    NSNumber * readNumber;
    if ([@"我的消息" isEqualToString:self.xiaoXiType]) {
        
        readNumber = [self.info objectForKey:@"readflag"];
        if (readNumber.intValue==0) {
            
            [self.cloudClient myMessageRead:@"notice!myMsgRead.do"
                                      msgid:[self.info objectForKey:@"msgid"]
                                   delegate:self
                                   selector:@selector(redSuccess:)
                              errorSelector:@selector(redError:)];
        }
        
    }
   
    
    self.titleLale.text = @"消息";
    self.titleLale.textColor = [UIColor whiteColor];
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT-(self.navView.frame.origin.y+self.navView.frame.size.height))];
    [self.view addSubview:self.mainScrollView];
    
    
    UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI,13*BILI, VIEW_WIDTH-26*BILI, 50*BILI)];
    titleLable.textColor = UIColorFromRGB(0x787878);
    titleLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:23*BILI];
    titleLable.numberOfLines = 0;
    [self.mainScrollView addSubview:titleLable];
    
    NSString * messageStr = [self.info objectForKey:@"title"];
    
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:messageStr];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:6];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [messageStr length])];
    [titleLable setAttributedText:attributedString1];
    [titleLable sizeToFit];
    titleLable.lineBreakMode = NSLineBreakByTruncatingTail;
    titleLable.textAlignment = NSTextAlignmentLeft;

    
    UILabel * messageLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, titleLable.frame.origin.y+titleLable.frame.size.height+13*BILI, VIEW_WIDTH-26*BILI, 13*BILI)];
    messageLable.font = [UIFont systemFontOfSize:13*BILI];
    messageLable.textColor = UIColorFromRGB(0x5077AA);
    [self.mainScrollView addSubview:messageLable];
    
    NSString * str ;
    if ([@"我的消息" isEqualToString:self.xiaoXiType]) {
        
        if (readNumber.intValue==0)
        {
            str =   [NSString stringWithFormat:@"%@  阅读状态:  未读",[self.info objectForKey:@"pubdate"]];
        }
        else
        {
             str =   [NSString stringWithFormat:@"%@  阅读状态:  已读",[self.info objectForKey:@"pubdate"]];
        }
       
    }
    else
    {
        str =   [NSString stringWithFormat:@"%@  %@      %@",[self.info objectForKey:@"pubdate"],[Common getobjectForKey:[self.info objectForKey:@"pubuser"]],[Common getobjectForKey:[self.info objectForKey:@"pubdept"]]];
    }
    
    NSString * timeStr = [self.info objectForKey:@"pubdate"];
    
    NSAttributedString * str1 = [[NSAttributedString alloc] initWithString:str];
    
    NSMutableAttributedString * text1 = [[NSMutableAttributedString alloc] initWithAttributedString:str1];
    
    
    [text1 addAttribute:NSForegroundColorAttributeName
     
                  value:UIColorFromRGB(0x787878)
     
                  range:NSMakeRange(0, timeStr.length)];
    
     messageLable.attributedText = text1;
    
    UILabel * contenLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, messageLable.frame.origin.y+messageLable.frame.size.height+13*BILI, VIEW_WIDTH-26*BILI, 0)];
    contenLable.textColor = UIColorFromRGB(0x787878);
    contenLable.font = [UIFont systemFontOfSize:15*BILI];
    contenLable.numberOfLines = 0;
    [self.mainScrollView addSubview:contenLable];

    messageStr = [self.info objectForKey:@"content"];
    attributedString1 = [[NSMutableAttributedString alloc] initWithString:messageStr];
    paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:6];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [messageStr length])];
    [contenLable setAttributedText:attributedString1];
    [contenLable sizeToFit];
    contenLable.lineBreakMode = NSLineBreakByTruncatingTail;
    
    [self.mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH, contenLable.frame.origin.y+contenLable.frame.size.height+13*BILI)];
}
-(void)redSuccess:(NSDictionary *)info
{
    NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithDictionary:self.info];
    [dic setObject:@"1" forKey:@"readflag"];
    [self.delegate readMyMessageSuccess:self.info];
}
-(void)redError:(NSDictionary *)info
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
