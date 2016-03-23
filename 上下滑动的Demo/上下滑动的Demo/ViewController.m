//
//  ViewController.m
//  上下滑动的Demo
//
//  Created by qishang on 16/3/17.
//  Copyright © 2016年 Rocky. All rights reserved.
//

#import "ViewController.h"
#import "MJRefresh.h"
#import "CustomCell.h"
#import "FootView.h"
#import "DetailViewController.h"
@interface ViewController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate> {

    CustomCell  * cell;
}
@property (assign, nonatomic) CGPoint offSet;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIScrollView *topScrollView;
@property (strong, nonatomic) UIScrollView *bootomScrollView;
@end

@implementation ViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        return [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateInitialViewController];
    }
    return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *topArr = @[@"估算净值", @"估算涨幅", @"最新净值", @"日涨幅", @"操作"];
    
    CGFloat labelW = self.view.bounds.size.width / 4;
    
    [topArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *label = [UILabel new];
        label.frame = CGRectMake(labelW * idx, 0, labelW, 25);
        label.text = topArr[idx];
        label.font = [UIFont systemFontOfSize:12];
        label.textAlignment = NSTextAlignmentCenter;
        [self.topScrollView addSubview:label];
    }];
    
    self.topScrollView.contentSize = CGSizeMake(self.view.bounds.size.width / 4 * 5, 25);
    self.bootomScrollView.contentSize = CGSizeMake(400, 0);
    self.topScrollView.delegate = self;
    self.navigationController.navigationBar.translucent = NO;
    [self.tableView registerNib:[UINib nibWithNibName:@"CustomCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    self.tableView.tableFooterView = [FootView footView];
    // 注册一个
    extern NSString *GodCellScrollNotification;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollMove:) name:GodCellScrollNotification object:nil];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView.mj_header endRefreshing];
        });
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark- UITableViewDelegate 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"Cell";
    cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.tableView = self.tableView;
    __weak typeof(self)mySelf = self;
    cell.buyBtnClick = ^(NSIndexPath *indexPath) {
    
        NSString *str = [NSString stringWithFormat:@"股票%ld  ", indexPath.row];
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"购买" message:str preferredStyle:UIAlertControllerStyleAlert];
        [alertVC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [mySelf presentViewController:alertVC animated:YES completion:nil];

    };
    
    cell.tapGesClick = ^(NSIndexPath *indexPath) {
        [mySelf tableView:tableView didSelectRowAtIndexPath:indexPath];
    };
    if (indexPath.row % 2 != 0) {
        cell.backgroundColor = [UIColor colorWithRed:231/ 255.0 green:231.0 / 255 blue:231.0 / 255 alpha:0.6];
    } else {
        cell.backgroundColor = [UIColor whiteColor];
    }

         return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController pushViewController:[DetailViewController new] animated:YES];
    
}

#pragma mark-- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    if ([scrollView isEqual:self.topScrollView]) {
        CGPoint offSet = cell.rightScrollView.contentOffset;
        offSet.x = scrollView.contentOffset.x;
        cell.rightScrollView.contentOffset = offSet;
    }
    if ([scrollView isEqual:self.tableView]) {
        // 发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:GodCellScrollNotification object:self userInfo:@{@"x":@(_CellLastScrollX)}];
    }
   
}

-(void)scrollMove:(NSNotification*)notification{
    NSDictionary *xn = notification.userInfo;
    NSObject *obj = notification.object;
    float x = [xn[@"x"] floatValue];
    _CellLastScrollX = x;
    CGPoint offSet = self.topScrollView.contentOffset;
    offSet.x = x;
    self.topScrollView.contentOffset = offSet;
    obj = nil;
}

@end
