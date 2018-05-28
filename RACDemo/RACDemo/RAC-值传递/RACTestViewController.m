//
//  RACTestViewController.m
//  RACDemo
//
//  Created by QMMac on 2018/5/28.
//  Copyright © 2018年 QMMac. All rights reserved.
//

#import "RACTestViewController.h"

@interface RACTestViewController ()

@property(nonatomic, strong) UIButton *popButton;

@end

@implementation RACTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.popButton.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 100)/2, ([UIScreen mainScreen].bounds.size.height - 50)/2, 100, 50);
    [self.view addSubview:self.popButton];
}

- (void)pop {
    
    [self.subject sendNext:@"ws"];
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *
 总结：
 我们完全可以用RACSubject代替代理/通知，进行值传递，确实方便许多
 这里我们点击RACTestViewController的pop的时候 将字符串"ws"传给了ViewController的button的title。
 步骤：
 // 1.创建信号
 RACSubject *subject = [RACSubject subject];
 
 // 2.订阅信号
 [subject subscribeNext:^(id x) {
 // block:当有数据发出的时候就会调用
 // block:处理数据
 NSLog(@"%@",x);
 }];
 
 // 3.发送信号
 [subject sendNext:value];
 **注意：~~**
 RACSubject和RACReplaySubject的区别
 RACSubject必须要先订阅信号之后才能发送信号，而RACReplaySubject可以先发送信号后订阅.
 RACSubject 代码中体现为：先走RACTestViewController的sendNext，后走ViewController的subscribeNext订阅
 RACReplaySubject 代码中体现为：先走ViewController的subscribeNext订阅，后走RACTestViewController的sendNext
 可按实际情况各取所需。
 
 */

- (UIButton *)popButton {
    if (!_popButton) {
        _popButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_popButton setTitle:@"pop" forState:UIControlStateNormal];
        [_popButton addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
        [_popButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [self.view addSubview:_popButton];
    }
    return _popButton;
}

@end
