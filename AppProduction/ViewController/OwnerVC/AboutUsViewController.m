//
//  AboutUsViewController.m
//  SeeYou
//
//  Created by 周璟琳 on 2017/4/17.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLale.text = @"关于我们";
    self.titleLale.textColor = [UIColor whiteColor];
    
    self.view.backgroundColor = UIColorFromRGB(0xdddddd);
    
    UIImageView * iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake((VIEW_WIDTH-80*BILI)/2, self.navView.frame.origin.y+self.navView.frame.size.height+65*BILI, 80*BILI, 80*BILI)];
    iconImageView.image = [UIImage imageNamed:@"180logo"];
    [self.view addSubview:iconImageView];
    
//    UIButton * versionBottom = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-118*BILI/2)/2, iconImageView.frame.origin.y+iconImageView.frame.size.height+20*BILI, 118*BILI/2, 17*BILI)];
//    versionBottom.backgroundColor = [UIColor blackColor];
//    versionBottom.alpha = 0.3;
//    versionBottom.layer.cornerRadius = 17*BILI/2;
//    [self.view addSubview:versionBottom];
    
    UILabel * versionLable = [[UILabel alloc] initWithFrame:CGRectMake(0, iconImageView.frame.origin.y+iconImageView.frame.size.height+30*BILI, VIEW_WIDTH, 18*BILI)];
    versionLable.font = [UIFont systemFontOfSize:18*BILI];
    versionLable.textAlignment = NSTextAlignmentCenter;
    NSString *versionAgent = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
    versionLable.text = [NSString stringWithFormat:@"系统版本  %@",versionAgent];
    versionLable.backgroundColor = [UIColor clearColor];
    versionLable.textAlignment = NSTextAlignmentCenter;
    versionLable.textColor = UIColorFromRGB(0x787878);
    [self.view addSubview:versionLable];
    
   
        
    
    

    
}
-(void)shengJiButtonClick
{
    NSString *str = [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id%@", APP_STORE_ID];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
