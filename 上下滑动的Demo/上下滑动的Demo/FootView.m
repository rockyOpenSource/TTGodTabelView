//
//  FootView.m
//  上下滑动的Demo
//
//  Created by qishang on 16/3/19.
//  Copyright © 2016年 Rocky. All rights reserved.
//

#import "FootView.h"

@implementation FootView

+ (FootView *)footView {

    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}
@end
