//
//  ViewController.h
//  上下滑动的Demo
//
//  Created by qishang on 16/3/17.
//  Copyright © 2016年 Rocky. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^offSetXBlock)(CGFloat x);

@interface ViewController : UIViewController
@property (nonatomic,assign) float CellLastScrollX; // 最后的cell的移动距离
@property (nonatomic, copy) offSetXBlock offsetBlock;

@end
