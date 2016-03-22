//
//  CustomScrollView.m
//  上下滑动的Demo
//
//  Created by qishang on 16/3/21.
//  Copyright © 2016年 Rocky. All rights reserved.
//

#import "CustomScrollView.h"

@implementation CustomScrollView
-(void)awakeFromNib {
    NSArray *arr = @[@"1.1662", @"0.01%", @"1.5880",@"3.72%",@"购买"];
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat labelW = [UIScreen mainScreen].bounds.size.width / 4;
        if (idx == arr.count - 1) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
            self.buyBtn = btn;
            btn.titleLabel.font =[UIFont systemFontOfSize:12];
            btn.layer.masksToBounds = YES;
            btn.layer.cornerRadius = 5;
            [btn addTarget:self action:@selector(buyAction:) forControlEvents:UIControlEventTouchUpInside];
            btn.frame = CGRectMake(labelW * idx + labelW / 4, self.frame.size.height / 4, labelW / 2, self.frame.size.height / 2);
            [btn setTitle:obj forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor redColor];
            [self addSubview:btn];
        } else {
            
            UILabel *label = [UILabel new];
            label.text = obj;
            if (idx % 2 != 0) {
                label.textColor = [UIColor redColor];
            } else {
                label.textColor = [UIColor blackColor];
            }
            label.font = [UIFont systemFontOfSize:12];
            label.textAlignment = NSTextAlignmentCenter;
            label.frame = CGRectMake(labelW * idx, 0, labelW,self.frame.size.height);
            [self addSubview:label];
            
        }
        
    }];

}


- (void)buyAction:(UIButton *)sender {
    if (self.buyClick) {
        self.buyClick();
    }
}
@end
