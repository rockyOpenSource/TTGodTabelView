//
//  CustomScrollView.h
//  上下滑动的Demo
//
//  Created by qishang on 16/3/21.
//  Copyright © 2016年 Rocky. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^BuyClick)();
@interface CustomScrollView : UIScrollView
@property (nonatomic, strong) UIButton *buyBtn;
@property (nonatomic, copy) BuyClick buyClick;
@end
