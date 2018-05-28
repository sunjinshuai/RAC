//
//  RACSignalViewController.m
//  RACDemo
//
//  Created by QMMac on 2018/5/28.
//  Copyright © 2018年 QMMac. All rights reserved.
//

#import "RACSignalViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface RACSignalViewController ()

@end

@implementation RACSignalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self test];
}

- (void)test {
    // 1.创建信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        // 3.发送信号
        [subscriber sendNext:@"ws"];
        // 4.取消信号，如果信号想要被取消，就必须返回一个RACDisposable
        // 信号什么时候被取消：1.自动取消，当一个信号的订阅者被销毁的时候机会自动取消订阅，2.手动取消，
        //block什么时候调用：一旦一个信号被取消订阅就会调用
        //block作用：当信号被取消时用于清空一些资源
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"取消订阅");
        }];
    }];
    // 2. 订阅信号
    // subscribeNext
    // 把nextBlock保存到订阅者里面
    // 只要订阅信号就会返回一个取消订阅信号的类
    RACDisposable *disposable = [signal subscribeNext:^(id x) {
        // block的调用时刻：只要信号内部发出数据就会调用这个block
        NSLog(@"======%@", x);
    }];
    // 取消订阅
    [disposable dispose];
}

@end
