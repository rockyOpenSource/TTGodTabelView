//
//  CustomCell.h
//  上下滑动的Demo
//
//  Created by qishang on 16/3/17.
//  Copyright © 2016年 Rocky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomScrollView.h"
typedef void(^BuyBtnClick)(NSIndexPath *indexPath);
typedef void(^TapGesClick)(NSIndexPath *indexPath);
static NSString *GodCellScrollNotification = @"GodCellScrollNotification";
@interface CustomCell : UITableViewCell <UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet CustomScrollView *rightScrollView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic,assign) BOOL isNotification;
@property (nonatomic, copy) BuyBtnClick buyBtnClick;
@property (nonatomic, copy) TapGesClick tapGesClick;
@end
