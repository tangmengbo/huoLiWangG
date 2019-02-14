//
//  OwnerHomeViewController.h
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/9.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BaseViewController.h"
#import "AboutUsViewController.h"


@interface OwnerHomeViewController : BaseViewController<UIImagePickerControllerDelegate,UIActionSheetDelegate>

@property(nonatomic,strong)CloudClient * cloudClient;

@property(nonatomic,strong)UIImage * headerImage;

@property(nonatomic,strong)CustomImageView * headerImageView;

@property(nonatomic,strong)UILabel * nameLable;

@property(nonatomic,strong)UILabel * messageLable;

@property(nonatomic,strong)UILabel * telLable;

@property(nonatomic,strong)UIImagePickerController * imagePickerController;

@property(nonatomic,strong)NSDictionary * userInfo;



@end
