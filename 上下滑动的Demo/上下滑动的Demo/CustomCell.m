//
//  CustomCell.m
//  上下滑动的Demo
//
//  Created by qishang on 16/3/17.
//  Copyright © 2016年 Rocky. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    CGFloat labelW = [UIScreen mainScreen].bounds.size.width / 4;
    self.rightScrollView.contentSize = CGSizeMake(labelW * 5, 0);
    self.rightScrollView.delegate = self;
    __weak typeof (self)mySelf = self;
    self.rightScrollView.buyClick = ^(void){
        NSIndexPath *indexPath = [mySelf.tableView indexPathForCell:mySelf];
        if (mySelf.buyBtnClick) {
            mySelf.buyBtnClick(indexPath);
        }
    };

    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.rightScrollView addGestureRecognizer:tapGes];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollMove:) name:GodCellScrollNotification object:nil];
    
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _isNotification = NO;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (!_isNotification) {
        // 发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:GodCellScrollNotification object:self userInfo:@{@"x":@(scrollView.contentOffset.x)}];
    }
    _isNotification = NO;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // 避开自己发的通知，只有手指拨动才会是自己的滚动
    if (!_isNotification) {
        // 发送通知
         [[NSNotificationCenter defaultCenter] postNotificationName:GodCellScrollNotification object:self userInfo:@{@"x":@(scrollView.contentOffset.x)}];
    }
    _isNotification = NO;
}

-(void)scrollMove:(NSNotification*)notification{
    NSDictionary *xn = notification.userInfo;
    NSObject *obj = notification.object;
    float x = [xn[@"x"] floatValue];
    if (obj!=self) {
        _isNotification = YES;
        [_rightScrollView setContentOffset:CGPointMake(x, 0) animated:NO];
    }else{
        _isNotification = NO;
    }
    obj = nil;
}

#pragma mark - 点击事件
- (void)tapAction:(UITapGestureRecognizer *)gesture {
    __weak typeof (self)mySelf = self;
    if (self.tapGesClick) {
        NSIndexPath *indexPath = [mySelf.tableView indexPathForCell:mySelf];
        mySelf.tapGesClick(indexPath);
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return YES;

}

@end
