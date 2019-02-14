//
//  WangGeXinXiWangGeZhangTableViewCell.h
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/23.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WangGeXinXiWangGeZhangTableViewCellDelegate
@required

- (void)telPush:(NSDictionary *)info;
@end



@interface WangGeXinXiWangGeZhangTableViewCell : UITableViewCell

@property (nonatomic, assign) id<WangGeXinXiWangGeZhangTableViewCellDelegate> delegate;

-(void)initData:(NSDictionary *)info;

@property(nonatomic,strong)NSDictionary * info;

@end
