//
//  WangGeXinXiWangGeTableViewCell.h
//  SeeYou
//
//  Created by 唐蒙波 on 2018/7/23.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WangGeXinXiWangGeTableViewCellDelegate
@required

- (void)telPush:(NSDictionary *)info;
@end

@interface WangGeXinXiWangGeTableViewCell : UITableViewCell

@property (nonatomic, assign) id<WangGeXinXiWangGeTableViewCellDelegate> delegate;
@property(nonatomic,strong)NSDictionary * info;


-(void)initData:(NSDictionary *)info;

@end
